import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/models/shop_app/categories_model.dart';
import 'package:e_commerce/models/shop_app/home_model.dart';
import 'package:e_commerce/modules/shop_app/categories/categories_screen.dart';
import 'package:e_commerce/modules/shop_app/favorites/favorites_screen.dart';
import 'package:e_commerce/modules/shop_app/products/products_screen.dart';
import 'package:e_commerce/modules/shop_app/settings/settings_screen.dart';
import 'package:e_commerce/shared/components/constants.dart';
import 'package:e_commerce/shared/network/end_points.dart';
import 'package:e_commerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context); // cubit getter

  // ----------------------------------------BNV
  int currentIndex = 0;

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottomNB(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNaveBarState());
  }

  // ----------------------------------------get home data

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME,token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel!.data!.banners[0].image);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  // ----------------------------------------get categories

  CategoriesModel? categoriesModel;
  
  void getCategoriesData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: GET_CATEGORIES,token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.date!.data[1].name);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }
}
