import 'get_favorites.dart';

class GetCartModel {
  late bool status;
  CartDetails? data;

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null
        ? CartDetails.fromJson(json['data'])
        : null;
  }
}

class CartDetails {
  late List<CartItemProduct> cartItems = [];
  late dynamic total;
  late dynamic subTotal;

  CartDetails.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cartItems.add(CartItemProduct.fromJson(element));
    });
    total = json['total']??0.0;
    subTotal = json['sub_total']??0.0;
  }
}

class CartItemProduct {
  late dynamic id;
  late dynamic quantity;
  late ShopProduct product;

  CartItemProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    quantity = json['quantity'] ?? 0;
    product = ShopProduct.fromJson(json['product']);
  }
}