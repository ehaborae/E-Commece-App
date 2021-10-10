import 'package:e_commerce/layouts/shop_app/cubit/cubit.dart';
import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/modules/shop_app/search/search_screen.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        int index = cubit.currentIndex;
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Salla',style: TextStyle(color: Colors.black),),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNB(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: index == 0
                    ? Icon(
                        Icons.home,
                      )
                    : Icon(
                        Icons.home_outlined,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: index == 1
                    ? Icon(
                        Icons.category,
                      )
                    : Icon(
                        Icons.category_outlined,
                      ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: index == 2
                    ? Icon(
                        Icons.favorite,
                      )
                    : Icon(
                        Icons.favorite_outline,
                      ),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: index == 3
                    ? Icon(
                        Icons.settings,
                      )
                    : Icon(
                        Icons.settings_outlined,
                      ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
