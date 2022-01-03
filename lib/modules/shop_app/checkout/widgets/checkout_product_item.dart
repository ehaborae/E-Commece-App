// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:medical_empire_app/core/models/cart_model.dart';
// import 'package:medical_empire_app/core/util/constants.dart';
// import 'package:medical_empire_app/core/util/cubit/cubit.dart';
//
// class CheckoutProductItem extends StatelessWidget {
//   final CartModel cartItem;
//
//   const CheckoutProductItem({Key? key, required this.cartItem})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 120.0,
//             width: 110.0,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8.0),
//               image: DecorationImage(
//                   image: NetworkImage(
//                     cartItem.image,
//                   ),
//                   fit: BoxFit.cover),
//               border: Border.all(
//                 color: Colors.grey[300]!,
//                 width: 1.0,
//               ),
//             ),
//           ),
//           space10Horizontal,
//           Expanded(
//             child: SizedBox(
//               height: 135.0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     MainCubit.get(context).isRtl?
//                     cartItem.name.ar:cartItem.name.en,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.bodyText2!,
//                   ),
//                   space10Vertical,
//                   Row(
//                     children: [
//                       Text(
//                         '${appTranslation(context).egp} ${int.parse(cartItem.price) * cartItem.quantity}',
//                         style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                               fontWeight: FontWeight.w700,
//                               color: HexColor(mainColor),
//                             ),
//                       ),
//                       const Spacer(),
//                       Text(
//                         '${appTranslation(context).quantity} : ${cartItem.quantity}',
//                         style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                               fontWeight: FontWeight.w700,
//                               color: HexColor(secondaryVariantDark),
//                             ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
