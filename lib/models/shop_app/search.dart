class ShopSearchModel {
  late bool status;
  ShopSearchDetails? data;

  ShopSearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? ShopSearchDetails.fromJson(json['data'])
        : null;
  }
}

class ShopSearchDetails {
  late List<ShopProductSear> data = [];

  ShopSearchDetails.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(ShopProductSear.fromJson(element));
    });
  }
}



class ShopProductSear {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ShopProductSear.fromJson(Map<String, dynamic> json) {
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
