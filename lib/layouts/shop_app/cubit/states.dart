import 'package:e_commerce/models/shop_app/change_favorites_model.dart';

abstract class ShopStates {}

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
