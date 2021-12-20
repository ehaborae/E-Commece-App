import 'package:buildcondition/buildcondition.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/shared/components/components.dart';
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
          condition:
              ShopCubit.get(context).favoritesModel!.data!.data.length > 0,
          builder: (context) => BuildCondition(
            condition:
                ShopCubit.get(context).favoritesModel!.data!.data.isNotEmpty,
            builder: (context) => RefreshIndicator(
              onRefresh: () {
                return ShopCubit.get(context).getFavoritesData();
              },
              child: ListView.separated(
                  itemBuilder: (context, index) => buildListFavItem(
                        context: context,
                        model: ShopCubit.get(context)
                            .favoritesModel!
                            .data!
                            .data[index]
                            .product,
                      ),
                  separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 3,
                      ),
                  itemCount:
                      ShopCubit.get(context).favoritesModel!.data!.data.length),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
          fallback: (context) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/4076/4076503.png'),
                  height: 200.0,
                  width: 200.0,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Favorites is empty, add some!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
