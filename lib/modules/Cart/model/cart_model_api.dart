class CartApiModel {
  int? code;
  bool? status;
  String? message;
  Data? data;

  CartApiModel({this.code, this.status, this.message, this.data});

  CartApiModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  num? subTotal;
  int? totalTax;
  num? couponDiscount;
  String? coupon_code;
  num? total;
  num? coupon_id;
  num? discount_price_cart;
  List<Items>? items;

  Data(
      {this.id,
      this.subTotal,
      this.totalTax,
      this.couponDiscount,
      this.total,
      this.coupon_code,
      this.coupon_id,
      this.discount_price_cart,
      this.items});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subTotal = json['sub_total'];
    totalTax = json['total_tax'];
    couponDiscount = json['coupon_discount'];
    total = json['total'];
    coupon_code = json['coupon_code'];
    coupon_id = json['coupon_id'];
    discount_price_cart = json['discount_rate_price'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_total'] = this.subTotal;
    // data['total_tax'] = this.totalTax;
    // data['coupon_discount'] = this.couponDiscount;
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? itemId;
  String? productId;
  int? productStatus;
  int? cartonStatus;
  String? productName;
  String? cartonName;
  String? cartonImage;
  String? productImage;
  String? productStok;
  String? price;
  String? maxQty;
  String? cartonMaxQty;
  String? productType;
  String? qty;
  num? total;

  Items(
      {this.itemId,
      this.productId,
      this.productStatus,
      this.productName,
      this.cartonImage,
      this.cartonStatus,
      this.productStok,
      this.productImage,
      this.cartonName,
      this.price,
      this.cartonMaxQty,
      this.maxQty,
      this.productType,
      this.qty,
      this.total});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    productId = json['product_id'].toString();
    productStatus = json['product_status'];
    productName = json['product_name'];
    productStok = json['product_stok'];
    productImage = json['product_image'];
    cartonName = json['carton_name'];
    cartonStatus = json['carton_status'];
    cartonImage = json['carton_image'];
    maxQty = json['max_qty'];
    cartonMaxQty = json['carton_max_qty'].toString();
    price = json['price'].toString();
    productType = json['product_type'];
    qty = json['qty'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['product_name'] = this.productName;
    data['carton_name'] = this.cartonName;
    data['price'] = this.price;
    data['product_type'] = this.productType;
    data['qty'] = this.qty;
    data['total'] = this.total;
    return data;
  }
}
