class ProductDetailsModel {
  late bool status;
  DetailedProduct? data;

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? DetailedProduct.fromJson(json['data'])
        : null;
  }
}

class DetailedProduct {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;

  DetailedProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    oldPrice = json['old_price'] ?? 0;
    discount = json['discount'] ?? 0;
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    inFavorites = json['in_favorites'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}