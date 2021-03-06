import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/models/shop_app/get_favorites.dart';
import 'package:e_commerce/models/shop_app/product_details_model.dart';
import 'package:e_commerce/modules/shop_app/product_details/product_details.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(BuildContext context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

Widget defaultFormField({
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? onTap,
  Function(String)? onChanged,
  Function()? suffixPressed,
  Function(String)? onSubmit,
  required TextInputType type,
  required String? Function(String?)? validate,
  bool isPassword = false,
}) =>
    TextFormField(
      validator: validate,
      keyboardType: type,
      onTap: onTap,
      obscureText: isPassword,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 6.0,
  required Function()? function,
  required String text,
  required BuildContext context,
}) =>
    Container(
      width: width,
      height: 55.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: Theme.of(context).textTheme.button!.copyWith(
            color: Colors.white,
          )
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function()? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
      ),
    );

void showToast({
  required String message,
  required ToastStates toastStates,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(toastStates),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color choseToastColor(ToastStates toastStates) {
  Color color;
  switch (toastStates) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildListProducts(model, context, {required bool isSearch}) => Padding(
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
                    model.image,
                  ),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && !isSearch)
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
                  model.name,
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
                      model.price.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, color: Colors.blue),
                    ),
                    if (model.discount != 0)
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
                          if (!isSearch)
                            Text(
                              model.oldPrice.toString(),
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
                    if (!isSearch)
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).favorites[model.id]!
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: ShopCubit.get(context).favorites[model.id]!
                              ? Colors.blue
                              : Colors.grey,
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

Widget buildListFavItem({
  required ShopProduct model,
  required BuildContext context,
}) =>
    InkWell(
      onTap: () {
        navigateTo(
          context,
          ProductDetails(
            productId: model.id,
          ),
        );
      },
      child: Padding(
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
                      model.image,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0)
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
                    model.name,
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
                        model.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                      if (model.discount != 0)
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
                              model.oldPrice.toString(),
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
                      // IconButton(
                      //   onPressed: () {
                      //     ShopCubit.get(context).changeFavorites(model.id);
                      //   },
                      //   icon: Icon(
                      //     Icons.favorite,
                      //     color: Colors.blue,
                      //     size: 20,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).favorites[model.id]!
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: ShopCubit.get(context).favorites[model.id]!
                              ? Colors.blue
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  cartButton(context: context, productId: model.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget buildListCartItem({
  required ShopProduct model,
  required BuildContext context,
}) =>
    InkWell(
      onTap: () {
        navigateTo(
          context,
          ProductDetails(
            productId: model.id,
          ),
        );
      },
      child: Padding(
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
                      model.image,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0)
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
                    model.name,
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
                        model.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                      if (model.discount != 0)
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
                              model.oldPrice.toString(),
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
                      // IconButton(
                      //   onPressed: () {
                      //     ShopCubit.get(context).changeFavorites(model.id);
                      //   },
                      //   icon: Icon(
                      //     Icons.favorite,
                      //     color: Colors.blue,
                      //     size: 20,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).favorites[model.id]!
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: ShopCubit.get(context).favorites[model.id]!
                              ? Colors.blue
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  cartButtonForCartScreen(context: context, productId: model.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget buildListCheckoutItem({
  required ShopProduct model,
  required BuildContext context,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            ProductDetails(
              productId: model.id,
            ),
          );
        },
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
                      model.image,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0)
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
                    model.name,
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
                        model.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                      if (model.discount != 0)
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
                              model.oldPrice.toString(),
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
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget buildListCatProductsItem({
  required DetailedProduct model,
  required BuildContext context,
}) =>
    InkWell(
      onTap: () {
        navigateTo(
          context,
          ProductDetails(
            productId: model.id,
          ),
        );
      },
      child: Padding(
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
                      model.image,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (model.discount != 0)
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
                    model.name,
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
                        model.price.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      ),
                      if (model.discount != 0)
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
                              model.oldPrice.toString(),
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
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).favorites[model.id]!
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: ShopCubit.get(context).favorites[model.id]!
                              ? Colors.blue
                              : Colors.grey,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  cartButton(context: context, productId: model.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget cartButton({required int productId, required BuildContext context}) {
  return SizedBox(
    height: 45.0,
    child: Container(
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          if(isInProgress != true){
            ShopCubit.get(context).changeCart(productId);
          }else{
            showToast(message: 'Your order is in progress', toastStates: ToastStates.WARNING);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ShopCubit.get(context).cart[productId]!
                  ? isInProgress != true ? 'Remove From' : 'In Progress'
                  : 'Add To',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Icon(
              ShopCubit.get(context).cart[productId]!
                  ? isInProgress != true ? Icons.remove_shopping_cart_outlined : null
                  : Icons.add_shopping_cart_outlined,
              size: 20.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          6.0,
        ),
        color:
            ShopCubit.get(context).cart[productId]! ? isInProgress != true ? Colors.red : Colors.green : Colors.blue,
      ),
    ), // child: defaultButton(
  );
}

Widget cartButtonForCartScreen(
    {required int productId, required BuildContext context}) {
  return SizedBox(
    height: 45.0,
    child: Container(
      width: double.infinity,
      child: MaterialButton(
        onPressed: () {
          if(isInProgress != true){
            ShopCubit.get(context).changeCart(productId);
          }else{
            showToast(message: 'Your order is in progress', toastStates: ToastStates.WARNING);
          }

        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isInProgress != true ?
              'Remove From' : 'In Progress',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            if(isInProgress != true)
            Icon(
              Icons.remove_shopping_cart_outlined,
              size: 20.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          6.0,
        ),
        color:  isInProgress != true ?
        Colors.red : Colors.green,
      ),
    ), // child: defaultButton(
  );
}
