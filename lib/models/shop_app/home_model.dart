class HomeModel {
  late bool status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  late List<BannerModel> banners = [];
  late List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}

class BannerModel {
  late int id;
  late String image;
  late bool category;
  late bool product;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    image = json['image']??'';
    category = json['category']??false;
    product = json['product']??false;
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    price = json['price']??0;
    oldPrice = json['old_price']??0;
    discount = json['discount']??0;
    image = json['image']??'';
    name = json['name']??'';
    description = json['description']??'';
    inFavorites = json['in_favorites']??false;
    inCart = json['in_cart']??false;
  }
}
