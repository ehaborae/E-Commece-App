import 'package:flutter/material.dart';

class CashSection extends StatelessWidget {
  final String subtotal;
  final String total;

  const CashSection({
    Key? key,
    required this.subtotal,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              Text(
                'Sub total',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const Spacer(),
              Text(
                '$subtotal EGP',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
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
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
              Text(
                '$total EGP',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
