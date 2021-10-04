class ShopFavoritesModel {
  late bool status;
  ShopFavoritesDetails? data;

  ShopFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? ShopFavoritesDetails.fromJson(json['data'])
        : null;
  }
}

class ShopFavoritesDetails {
  late List<FavoriteProduct> data = [];

  ShopFavoritesDetails.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoriteProduct.fromJson(element));
    });
  }
}

class FavoriteProduct {
  late int id;
  late ShopProduct product;

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    product = ShopProduct.fromJson(json['product']);
  }
}

class ShopProduct {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ShopProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    oldPrice = json['old_price'] ?? 0;
    discount = json['discount'] ?? 0;
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    inFavorites = json['in_favorites'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}
