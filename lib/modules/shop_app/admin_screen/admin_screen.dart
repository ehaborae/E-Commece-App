import 'package:buildcondition/buildcondition.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/layouts/shop_app/shop_layout.dart';
import 'package:e_commerce/modules/shop_app/checkout/widgets/address_item.dart';
import 'package:e_commerce/modules/shop_app/checkout/widgets/box_item.dart';
import 'package:e_commerce/modules/shop_app/checkout/widgets/payment_item.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Admin',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.black87),
            ),
            centerTitle: true,
          ),
          body : BuildCondition(
            condition:
            ShopCubit.get(context).getCartModel!.data!.cartItems.length > 0,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (state is ShopLoadingChangeCartTestDataState)
                    LinearProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: BoxItem(
                      title: 'User Data',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 1.0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 5.0,
                            ),
                            child: Text(
                              '${ShopCubit.get(context).userModel!.data!.name}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 5.0,
                            ),
                            child: Text(
                              '${ShopCubit.get(context).userModel!.data!.email}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 5.0,
                            ),
                            child: Text(
                              '${ShopCubit.get(context).userModel!.data!.phone}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: BoxItem(
                      title: 'Address',
                      child: AddressItem(
                        index: ShopCubit.get(context).shippingAddressIndex,
                        address: addresses[
                        ShopCubit.get(context).shippingAddressIndex],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: BoxItem(
                      title: 'Payment Method',
                      child: PaymentItem(
                        index: ShopCubit.get(context).paymentMethodIndex,
                        paymentMethod: paymentMethodList[
                        ShopCubit.get(context).paymentMethodIndex],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: BoxItem(
                      title: 'Products',
                      child: Column(
                        children: [
                          Container(
                            height: 1.0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildListCheckoutItem(
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
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: BoxItem(
                      title: 'Cash',
                      child: Column(
                        children: [
                          Container(
                            height: 1.0,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 13.0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Total',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  '${ShopCubit.get(context).getCartModel!.data!.total} EGP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: defaultButton(
                      function: () {
                        // CacheHelper.saveData(
                        //     key: 'address',
                        //     value: addresses[
                        //     ShopCubit.get(context).shippingAddressIndex])
                        //     .then((value) {
                        //   address = addresses[
                        //   ShopCubit.get(context).shippingAddressIndex];
                        //   CacheHelper.saveData(
                        //       key: 'paymentMethod',
                        //       value: paymentMethodList[
                        //       ShopCubit.get(context).paymentMethodIndex])
                        //       .then((value) {
                        //     paymentMethod = paymentMethodList[
                        //     ShopCubit.get(context).paymentMethodIndex];
                        //     CacheHelper.saveData(key: 'isInProgress', value: true)
                        //         .then((value) {
                        //       isInProgress = true;
                        //       showToast(
                        //         message: 'Create Checkout Successfully',
                        //         toastStates: ToastStates.SUCCESS,
                        //       );
                        //       ShopCubit.get(context).currentIndex = 0;
                        //       navigateAndFinish(context, ShopLayout());
                        //       print(addresses[ShopCubit.get(context).shippingAddressIndex]);
                        //       print(paymentMethodList[ShopCubit.get(context).paymentMethodIndex]);
                        //       print(isInProgress);
                        //     });
                        //   });
                        // });
                        ShopCubit.get(context).clearCart().then((value) {
                          showToast(
                            message: 'Order Accepted Successfully',
                            toastStates: ToastStates.SUCCESS,
                          );
                          isInProgress = false;
                          ShopCubit.get(context).currentIndex = 0;
                          navigateAndFinish(context, ShopLayout());
                        });
                      },
                      text: 'Accept the order',
                      context: context,
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                    "Can't find any orders",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
