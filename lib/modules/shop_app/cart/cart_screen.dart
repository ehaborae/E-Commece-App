// ignore_for_file: unnecessary_null_comparison

import 'package:buildcondition/buildcondition.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/modules/shop_app/checkout/checkout_screen.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShopCubit.get(context).getCartData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BuildCondition(
          condition:
              ShopCubit.get(context).getCartModel != null,
          builder: (context) => BuildCondition(
            condition:
            ShopCubit.get(context).getCartModel!.data!.cartItems.length > 0,
            builder: (context) => RefreshIndicator(
              onRefresh: () {
                return ShopCubit.get(context).getCartData();
              },
              child: Column(
                children: [
                  if (state is ShopLoadingChangeCartTestDataState)
                    LinearProgressIndicator(),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => buildListCartItem(
                        context: context,
                        model: ShopCubit.get(context)
                            .getCartModel!
                            .data!
                            .cartItems[index]
                            .product,
                      ),
                      separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 3,
                        child: Divider(),
                      ),
                      itemCount: ShopCubit.get(context)
                          .getCartModel!
                          .data!
                          .cartItems
                          .length,
                    ),
                  ),
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Sub Total : ',
                                ),
                                Text(
                                  '${ShopCubit.get(context).getCartModel!.data!.subTotal}',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Total : ',
                                ),
                                Text(
                                  '${ShopCubit.get(context).getCartModel!.data!.total}',
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: defaultButton(
                            context: context,
                            function: () {
                              if(isInProgress != true){
                                navigateTo(context, CheckoutScreen());
                              }else{
                                showToast(message: 'Your order is in progress', toastStates: ToastStates.WARNING);
                              }
                            },
                            text: isInProgress != true
                                ? 'Checkout'
                                : 'In Progress',
                            background: isInProgress != true
                                ? Colors.blue
                                : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                    'Cart is empty, add some!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ),

          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
