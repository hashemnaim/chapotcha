import '../../Products/model/product_model.dart';

class DetailsOrderModel {
  String? code;
  bool? status;
  Orders? orders;

  DetailsOrderModel({this.code, this.status, this.orders});

  DetailsOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    orders =
        json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    return data;
  }
}

class Orders {
  int? orderId;
  String? code;
  String? date;
  String? time;
  String? totalPrice;
  String? deliveryCost;
  String? discount_price;
  String? tax;
  String? status;
  String? statusCode;
  List<Product>? products;
  List<Cartons>? cartons;
  String? cash;
  Address? address;

  Orders(
      {this.orderId,
      this.date,
      this.time,
      this.code,
      this.totalPrice,
      this.deliveryCost,
      this.tax,
      this.discount_price,
      this.status,
      this.statusCode,
      this.products,
      this.cartons,
      this.cash,
      this.address});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    code = json['code'];
    date = json['date'];
    time = json['time'];
    totalPrice = json['total_price'].toString();
    deliveryCost = json['delivery_cost'].toString();
    discount_price = json['discount_price'].toString();
    tax = json['tax'];
    status = json['status'];
    statusCode = json['status_code'];
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
    if (json['cartons'] != null) {
      cartons = <Cartons>[];
      json['cartons'].forEach((v) {
        cartons!.add(new Cartons.fromJson(v));
      });
    }
    cash = json['cash'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['date'] = this.date;
    data['code'] = this.code;
    data['time'] = this.time;
    data['total_price'] = this.totalPrice;
    data['delivery_cost'] = this.deliveryCost;
    data['tax'] = this.tax;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.cartons != null) {
      data['cartons'] = this.cartons!.map((v) => v.toJson()).toList();
    }
    data['cash'] = this.cash;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Cartons {
  int? id;
  String? orderId;
  String? cartonId;
  String? cartonName;
  String? cartonPrice;
  String? image;
  String? cartonQuantity;
  String? totalPrice;

  Cartons(
      {this.id,
      this.orderId,
      this.cartonId,
      this.cartonName,
      this.cartonPrice,
      this.image,
      this.cartonQuantity,
      this.totalPrice});

  Cartons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'].toString();
    cartonId = json['carton_id'].toString();
    cartonName = json['carton_name'];
    cartonPrice = json['carton_price'].toString();
    image = json['image'];
    cartonQuantity = json['quantity'];
    totalPrice = json['total_price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['carton_id'] = this.cartonId;
    data['carton_name'] = this.cartonName;
    data['carton_price'] = this.cartonPrice;
    data['carton_quantity'] = this.cartonQuantity;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class Address {
  int? id;
  String? phone;
  String? street;
  String? building;
  String? apartment;
  String? lat;
  String? lng;
  String? city;
  String? city_id;
  String? area;

  Address(
      {this.id,
      this.phone,
      this.street,
      this.building,
      this.apartment,
      this.lat,
      this.lng,
      this.city,
      this.city_id,
      this.area});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    street = json['street'];
    building = json['building'];
    apartment = json['apartment'];
    lat = json['lat'];
    lng = json['lng'];
    city = json['city'];
    city_id = json['city_id'].toString();
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['building'] = this.building;
    data['apartment'] = this.apartment;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['city'] = this.city;
    data['city_id'] = this.city_id;
    data['area'] = this.area;
    return data;
  }
}
