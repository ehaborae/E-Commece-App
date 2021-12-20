import 'package:e_commerce/layouts/shop_app/cubit/states.dart';
import 'package:e_commerce/models/shop_app/categories_model.dart';
import 'package:e_commerce/models/shop_app/change_favorites_model.dart';
import 'package:e_commerce/models/shop_app/get_favorites.dart';
import 'package:e_commerce/models/shop_app/home_model.dart';
import 'package:e_commerce/models/shop_app/login_model.dart';
import 'package:e_commerce/models/shop_app/product_details_model.dart';
import 'package:e_commerce/models/shop_app/user_data.dart';
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

  // login start ----------------------------------
  late LoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      lang: 'en',
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);

      loginModel = LoginModel.fromJson(value.data);
      if (loginModel.status) {
        print(loginModel.status);
        print(loginModel.message);
        print(loginModel.data?.name);
        print(loginModel.data?.id);
        print(loginModel.data?.token);

        emit(LoginSuccessState(loginModel));
      } else {
        print(loginModel.status);
        print(loginModel.message);
        emit(LoginSuccessState(loginModel));
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  // login end ----------------------------------

  // register start ----------------------------------

  late LoginModel registerModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      lang: 'en',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);

      registerModel = LoginModel.fromJson(value.data);
      if (registerModel.status) {
        print(registerModel.status);
        print(registerModel.message);
        print(registerModel.data?.name);
        print(registerModel.data?.id);
        print(registerModel.data?.token);

        emit(RegisterSuccessState(registerModel));
      } else {
        print(registerModel.status);
        print(registerModel.message);
        emit(RegisterSuccessState(registerModel));
      }
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
      print(error.toString());
    });
  }

  IconData suffixRegister = Icons.visibility_outlined;
  bool isPasswordRegister = true;

  void registerChangePasswordVisibility() {
    isPasswordRegister = !isPasswordRegister;
    suffixRegister = isPasswordRegister
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  // register end ----------------------------------

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
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      // print(homeModel!.data!.banners[0].image);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      // print(favorites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  // ----------------------------------------get categories

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel!.date!.data[1].name);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }

  // ----------------------------------------Change Favorites

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopSuccessChangeFavoritesTestDataState());
    DioHelper.postData(
      data: {
        'product_id': productId,
      },
      url: FAVORITES,
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesDataState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesDataState(error, changeFavoritesModel!));
    });
  }

  // ----------------------------------------get Favorites

  ShopFavoritesModel? favoritesModel;

  Future<void> getFavoritesData() async {
    emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = ShopFavoritesModel.fromJson(value.data);
      print('----------------------------SuccessGetFavorite');
      print(favoritesModel!.data!.data.length);
      print(favoritesModel!.data!.data[0].product.name);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState(error.toString()));
    });
  }

  // ----------------------------------------get Profile

  UserModel? userModel;

  void getProfileData() {
    emit(ShopLoadingGetUsersDataState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState(error.toString()));
    });
  }

  // ----------------------------------------update Profile

  void updateProfileData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUsersDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }

  ProductDetailsModel? productDetailsModel;

  void getProductDetails({
    required int productId,
  }) {
    productDetailsModel = null;
    emit(ShopLoadingProductDetailsState());
    DioHelper.getData(url: '$PRODUCTS$productId', token: token).then((value) {
      productDetailsModel = ProductDetailsModel.fromJson(value.data);
      print('----------------------------getProductDetails success');
      print(productDetailsModel!.data!.name);

      emit(ShopSuccessProductDetailsState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProductDetailsState(error.toString()));
    });
  }
  int? maxLines;
  bool seeMore = false;
  void descriptionView(){
    if(seeMore){
      maxLines = null;
      seeMore = false;
      emit(ShowMoreState());
    }else{
      maxLines = 6;
      seeMore = true;
      emit(ShowMoreState());
    }
  }
}
