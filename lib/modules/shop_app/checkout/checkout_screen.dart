import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/layouts/shop_app/shop_layout.dart';
import 'package:e_commerce/modules/shop_app/checkout/widgets/address_item.dart';
import 'package:e_commerce/modules/shop_app/checkout/widgets/box_item.dart';
import 'package:e_commerce/modules/shop_app/checkout/widgets/cash_section.dart';
import 'package:e_commerce/modules/shop_app/checkout/widgets/payment_item.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:e_commerce/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Checkout',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.black54,
                  ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: BoxItem(
                    title: 'Address',
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => AddressItem(
                        index: index,
                        address: addresses[index],
                      ),
                      // separatorBuilder:(context, index) => Divider(),
                      itemCount: addresses.length,
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => PaymentItem(
                        index: index,
                        paymentMethod: paymentMethodList[index],
                      ),
                      // separatorBuilder:(context, index) => Divider(),
                      itemCount: paymentMethodList.length,
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
                        CashSection(
                          total:
                              '${ShopCubit.get(context).getCartModel!.data!.total}',
                          subtotal:
                              '${ShopCubit.get(context).getCartModel!.data!.subTotal}',
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
                      CacheHelper.saveData(
                              key: 'address',
                              value: addresses[
                                  ShopCubit.get(context).shippingAddressIndex])
                          .then((value) {
                        address = addresses[
                            ShopCubit.get(context).shippingAddressIndex];
                        CacheHelper.saveData(
                                key: 'paymentMethod',
                                value: paymentMethodList[
                                    ShopCubit.get(context).paymentMethodIndex])
                            .then((value) {
                          paymentMethod = paymentMethodList[
                              ShopCubit.get(context).paymentMethodIndex];
                          CacheHelper.saveData(key: 'isInProgress', value: true)
                              .then((value) {
                            isInProgress = true;
                            showToast(
                              message: 'Create Checkout Successfully',
                              toastStates: ToastStates.SUCCESS,
                            );
                            ShopCubit.get(context).currentIndex = 0;
                            navigateAndFinish(context, ShopLayout());
                            print(addresses[ShopCubit.get(context).shippingAddressIndex]);
                            print(paymentMethodList[ShopCubit.get(context).paymentMethodIndex]);
                            print(isInProgress);
                          });
                        });
                      });

                    },
                    text: 'Create Checkout',
                    context: context,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
