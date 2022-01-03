import 'package:e_commerce/models/shop_app/product_details_model.dart';

class CategoryDetailsModel {
  late bool status;
  DetailedCategoryData? data;

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? DetailedCategoryData.fromJson(json['data'])
        : null;
  }
}

class DetailedCategoryData {
  late List<DetailedProduct> data = [];

  DetailedCategoryData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DetailedProduct.fromJson(element));
    });
  }
}