import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/models/shop_app/categories_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, sate) {},
      builder: (context, sate) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.date!.data[index]),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 3,
                ),
            itemCount:
                ShopCubit.get(context).categoriesModel!.date!.data.length);
      },
    );
  }

  Widget buildCatItem(Data data) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${data.image}'),
              height: 80.0,
              width: 80.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              '${data.name}',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_right,
                color: Colors.blue,
              ),
            ),
            ],
        ),
      );
}
