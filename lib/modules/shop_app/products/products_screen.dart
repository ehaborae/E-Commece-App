import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/models/shop_app/categories_model.dart';
import 'package:e_commerce/models/shop_app/home_model.dart';
import 'package:e_commerce/modules/shop_app/cat_details/cat_details_screen.dart';
import 'package:e_commerce/modules/shop_app/product_details/product_details.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesDataState) {
          showToast(
              message: state.changeFavoritesModel.message,
              toastStates: ToastStates.SUCCESS);
        } else if (state is ShopSuccessChangeFavoritesDataState) {
          showToast(
              message: state.changeFavoritesModel.message,
              toastStates: ToastStates.ERROR);
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return BuildCondition(
          // ignore: unnecessary_null_comparison
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              productsBuilder(cubit.homeModel, cubit.categoriesModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(
          HomeModel? homeModel, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel!.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 6.5,
                initialPage: 0,
                viewportFraction: .85,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                  Container(
                    height: 110.0,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItem(
                            categoriesModel!.date!.data[index], context),
                        separatorBuilder: (context, index) => Container(
                              width: 8.0,
                              height: 110,
                              color: Colors.white,
                            ),
                        itemCount: categoriesModel!.date!.data.length),
                  ),
                  Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.white,
              child: GridView.count(
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.8,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(
                  homeModel.data!.products.length,
                  (index) => SizedBox(
                    child: buildGridProduct(
                        homeModel.data!.products[index], context),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel productModel, context) => Container(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            navigateTo(
              context,
              ProductDetails(
                productId: productModel.id,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                      '${productModel.image}',
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 4.3,
                  ),
                  if (productModel.discount != 0)
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${productModel.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '${productModel.price} EGP',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14.0, color: Colors.blue),
                        ),
                        // if (productModel.discount != 0)
                        //   Row(
                        //     children: [
                        //       SizedBox(
                        //         width: 5.0,
                        //       ),
                        //       Container(
                        //         height: 1.0,
                        //         width: 2.0,
                        //         color: Colors.blue,
                        //       ),
                        //       SizedBox(
                        //         width: 5.0,
                        //       ),
                        //       Text(
                        //         '${productModel.oldPrice} EGP',
                        //         maxLines: 2,
                        //         overflow: TextOverflow.ellipsis,
                        //         style: TextStyle(
                        //           fontSize: 12.0,
                        //           color: Colors.grey,
                        //           decoration: TextDecoration.lineThrough,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsetsDirectional.only(
                            end: 10.0,
                          ),
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(productModel.id);
                          },
                          icon: Icon(
                            ShopCubit.get(context).favorites[productModel.id]!
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: ShopCubit.get(context)
                                    .favorites[productModel.id]!
                                ? Colors.blue
                                : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    cartButton(context: context, productId: productModel.id),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildCategoriesItem(Data data, BuildContext context) => Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          onTap: () {
            navigateTo(
                context,
                CatDetails(
                  catId: data.id,
                  catName: '${data.name}',
                ));
          },
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Image(
                image: NetworkImage('${data.image}'),
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
              Container(
                width: 100.0,
                color: Colors.black.withOpacity(.7),
                child: Text(
                  '${data.name}',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );


}
