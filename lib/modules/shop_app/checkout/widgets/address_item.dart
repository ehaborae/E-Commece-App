import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:flutter/material.dart';


class AddressItem extends StatelessWidget {
  final String address;
  final int index;

  const AddressItem({
    Key? key,
    required this.index,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ShopCubit.get(context).changeShippingAddressIndex(index: index);
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
                if (ShopCubit.get(context).shippingAddressIndex == index)
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 5,
                  ),
                if (ShopCubit.get(context).shippingAddressIndex != index)
                  CircleAvatar(
                    backgroundColor: Colors.black54,
                    radius: 5,
                    child: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      radius: 4,
                    ),
                  ),
                SizedBox(width: 15,),
                Expanded(
                  child: Text(
                    address,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
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
