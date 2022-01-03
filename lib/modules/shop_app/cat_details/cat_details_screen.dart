import 'package:buildcondition/buildcondition.dart';
import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatDetails extends StatefulWidget {
  const CatDetails({
    Key? key,
    required this.catId,
    required this.catName,
  }) : super(key: key);
  final int catId;
  final String catName;

  @override
  State<CatDetails> createState() => _CatDetailsState();
}

class _CatDetailsState extends State<CatDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShopCubit.get(context).getCategoryDetails(catId: widget.catId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        return BuildCondition(
          condition: ShopCubit.get(context).categoryDetailsModel != null,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(
                widget.catName,
                style: Theme.of(context).textTheme.subtitle1,
                maxLines: 1,
              ),
            ),
            body: BuildCondition(
              condition:
              ShopCubit.get(context).categoryDetailsModel!.data!.data.length > 0,
              builder: (context) => BuildCondition(
                condition:
                ShopCubit.get(context).categoryDetailsModel!.data!.data.isNotEmpty,
                builder: (context) => RefreshIndicator(
                  onRefresh: () {
                    return ShopCubit.get(context).getCategoryDetails(catId: widget.catId);
                  },
                  child: ListView.separated(
                      itemBuilder: (context, index) => buildListCatProductsItem(
                        context: context,
                        model: ShopCubit.get(context).
                        categoryDetailsModel!.data!.data[index],
                      ),
                      separatorBuilder: (context, index) => Container(
                        width: double.infinity,
                        height: 3,
                        child: Divider(),
                      ),
                      itemCount:
                      ShopCubit.get(context).categoryDetailsModel!.data!.data.length),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
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
                      'This cat is empty',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
