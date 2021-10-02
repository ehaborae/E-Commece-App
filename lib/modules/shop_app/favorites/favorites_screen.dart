import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  'https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg',
                ),
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
              if (1 != 0)
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
                'MacBook',
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
                    '44500',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, color: Colors.blue),
                  ),
                  if (1 != 0)
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
                          '44500',
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
                      //ShopCubit.get(context).changeFavorites(productModel.id);
                    },
                    icon: Icon(
                      true ? Icons.favorite : Icons.favorite_border_outlined,
                      color: true ? Colors.blue : Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
