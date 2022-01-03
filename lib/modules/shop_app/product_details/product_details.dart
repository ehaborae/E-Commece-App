import 'package:buildcondition/buildcondition.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShopCubit.get(context).getProductDetails(productId: widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        return BuildCondition(
          condition: ShopCubit.get(context).productDetailsModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                ShopCubit.get(context).productDetailsModel!.data!.name,
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 1,
              ),
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 15.0,
                end: 15.0,
                top: 15.0,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: NetworkImage(ShopCubit.get(context)
                          .productDetailsModel!
                          .data!
                          .image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 15.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Price : ',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                '${ShopCubit.get(context).productDetailsModel!.data!.price} EGP',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.blue,
                                    ),
                                maxLines: ShopCubit.get(context).maxLines,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          height: 45.0,
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 15.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              ShopCubit.get(context).changeFavorites(
                                  ShopCubit.get(context)
                                      .productDetailsModel!
                                      .data!
                                      .id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (!ShopCubit.get(context).favorites[
                                    ShopCubit.get(context)
                                        .productDetailsModel!
                                        .data!
                                        .id]!)
                                  Text(
                                    'Add to',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                if (ShopCubit.get(context).favorites[
                                    ShopCubit.get(context)
                                        .productDetailsModel!
                                        .data!
                                        .id]!)
                                  Text(
                                    'Remove from',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Icon(
                                  ShopCubit.get(context).favorites[
                                          ShopCubit.get(context)
                                              .productDetailsModel!
                                              .data!
                                              .id]!
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: ShopCubit.get(context).favorites[
                                          ShopCubit.get(context)
                                              .productDetailsModel!
                                              .data!
                                              .id]!
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0,),
                    cartButton(
                        context: context,
                        productId: ShopCubit.get(context)
                            .productDetailsModel!
                            .data!
                            .id),
                    Divider(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 15.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description:',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            ShopCubit.get(context)
                                .productDetailsModel!
                                .data!
                                .description,
                            style: Theme.of(context).textTheme.bodyText1,
                            maxLines: ShopCubit.get(context).maxLines,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: defaultTextButton(
                              text: ShopCubit.get(context).seeMore
                                  ? 'read more'
                                  : 'read less',
                              onPressed: () {
                                ShopCubit.get(context).descriptionView();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
