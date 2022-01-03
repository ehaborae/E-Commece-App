import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  final String paymentMethod;
  final int index;

  const PaymentItem({
    Key? key,
    required this.paymentMethod,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).changePaymentMethodIndex(index: index);
      },
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
              vertical: 13.0,
            ),
            child: Row(
              children: [
                if (ShopCubit.get(context).paymentMethodIndex == index)
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 5,
                  ),
                if (ShopCubit.get(context).paymentMethodIndex != index)
                  CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 5,
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 4,
                    ),
                  ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  paymentMethod,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
