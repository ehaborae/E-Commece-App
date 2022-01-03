import 'package:e_commerce/models/shop_app/change_cart_model.dart';
import 'package:e_commerce/models/shop_app/change_favorites_model.dart';
import 'package:e_commerce/models/shop_app/login_model.dart';

abstract class ShopStates {}
class LoginLoadingState extends ShopStates {}

class LoginSuccessState extends ShopStates {
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends ShopStates {
  final String error;

  LoginErrorState(this.error);
}

class LoginChangePasswordVisibilityState extends ShopStates {}
class RegisterLoadingState extends ShopStates {}

class RegisterSuccessState extends ShopStates {
  final LoginModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends ShopStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNaveBarState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;

  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {
  final String error;

  ShopErrorCategoriesDataState(this.error);
}

class ShopSuccessChangeFavoritesDataState extends ShopStates {
  final ChangeFavoritesModel changeFavoritesModel;

  ShopSuccessChangeFavoritesDataState(this.changeFavoritesModel);
}

class ShopSuccessChangeFavoritesTestDataState extends ShopStates {}

class ShopErrorChangeFavoritesDataState extends ShopStates {
  final String error;
  final ChangeFavoritesModel changeFavoritesModel;

  ShopErrorChangeFavoritesDataState(this.error, this.changeFavoritesModel);
}

class ShopSuccessGetFavoritesDataState extends ShopStates {}

class ShopLoadingGetFavoritesDataState extends ShopStates {}

class ShopErrorGetFavoritesDataState extends ShopStates {
  final String error;

  ShopErrorGetFavoritesDataState(this.error);
}
class ShopSuccessGetUserDataState extends ShopStates {}

class ShopLoadingGetUsersDataState extends ShopStates {}

class ShopErrorGetUserDataState extends ShopStates {
  final String error;

  ShopErrorGetUserDataState(this.error);
}

class ShopSuccessUpdateUserDataState extends ShopStates {}

class ShopLoadingUpdateUsersDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}



class ShopLoadingProductDetailsState extends ShopStates {}

class ShopSuccessProductDetailsState extends ShopStates {}

class ShopErrorProductDetailsState extends ShopStates {
  final String error;

  ShopErrorProductDetailsState(this.error);
}

class ShowMoreState extends ShopStates {}


class ShopLoadingCatDetailsState extends ShopStates {}

class ShopSuccessCatDetailsState extends ShopStates {}

class ShopErrorCatDetailsState extends ShopStates {
  final String error;

  ShopErrorCatDetailsState(this.error);
}

class ShopSuccessGetCartDataState extends ShopStates {}

class ShopLoadingGetCartDataState extends ShopStates {}

class ShopErrorGetCartDataState extends ShopStates {
  final String error;

  ShopErrorGetCartDataState(this.error);
}


class ShopSuccessChangeCartDataState extends ShopStates {
  final ChangeCartModel changeCartModel;

  ShopSuccessChangeCartDataState(this.changeCartModel);
}

class ShopSuccessChangeCartTestDataState extends ShopStates {}
class ShopLoadingChangeCartTestDataState extends ShopStates {}

class ShopErrorChangeCartDataState extends ShopStates {
  final String error;
  final ChangeCartModel changeCartModel;

  ShopErrorChangeCartDataState(this.error, this.changeCartModel);
}

class ChangeShippingAddressIndex extends ShopStates {}

class ChangePaymentMethodIndex extends ShopStates {}