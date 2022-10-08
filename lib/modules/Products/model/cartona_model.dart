import 'package:capotcha/modules/Products/model/product_model.dart';

class CartonaModel {
  int? code;
  bool? status;
  String? message;
  List<DataCartona>? data;

  CartonaModel({this.code, this.status, this.message, this.data});

  CartonaModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataCartona>[];
      json['data'].forEach((v) {
        data!.add(new DataCartona.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataCartona {
  int? id;
  String? name;
  num? price;
  int? discount;
  num? total;
  String? cartonPoints;
  String? stock;
  String? image;
  String? maxQty;
  List<Product>? products;

  DataCartona(
      {this.id,
      this.name,
      this.price,
      this.discount,
      this.total,
      this.image,
      this.cartonPoints,
      this.stock,
      this.maxQty,
      this.products});

  DataCartona.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    total = json['total'];
    image = json['image'];
    cartonPoints = json['carton_points'];
    stock = json['stock'];
    maxQty = json['max_qty'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['total'] = this.total;
    data['image'] = this.image;
    data['carton_points'] = this.cartonPoints;
    data['stock'] = this.stock;
    data['max_qty'] = this.maxQty;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
