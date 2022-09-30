class OrderModel {
  List<Orders>? orders;

  OrderModel({this.orders});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;

  String? time;
  String? date;
  String? totalPrice;
  String? deliveryCost;
  String? tax;
  String? status;
  String? statusCode;
  String? cash;
  String? totalAmount;
  int? totalCount;

  Orders(
      {this.id,
      this.time,
      this.date,
      this.totalPrice,
      this.deliveryCost,
      this.tax,
      this.status,
      this.statusCode,
      this.cash,
      this.totalAmount,
      this.totalCount});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    date = json['date'];
    time = json['time'];
    totalPrice = json['total_price'];
    deliveryCost = json['delivery_cost'];
    tax = json['tax'];
    status = json['status'];
    statusCode = json['status_code'];

    cash = json['cash'];
    totalAmount = json['total_amount'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['time'] = this.time;
    data['total_price'] = this.totalPrice;
    data['delivery_cost'] = this.deliveryCost;
    data['tax'] = this.tax;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;

    data['cash'] = this.cash;
    data['total_amount'] = this.totalAmount;
    data['total_count'] = this.totalCount;
    return data;
  }
}
