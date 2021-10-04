import 'package:buildcondition/buildcondition.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/models/shop_app/get_favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition: state is! ShopLoadingGetFavoritesDataState,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildFaveItem(
                  ShopCubit.get(context).favoritesModel!.data!.data[index],
                  context),
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 3,
              ),
              itemCount:
              ShopCubit.get(context).favoritesModel!.data!.data.length),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFaveItem(FavoriteProduct model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                      model.product.image,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      width: double.infinity,
                      color: Colors.red.withOpacity(.8),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        model.product.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                      if (model.product.discount != 0)
                        Row(
                          children: [
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              height: 1.0,
                              width: 2.0,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              model.product.oldPrice.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(model.product.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).favorites[model.product.id]!
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: true ? Colors.blue : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
