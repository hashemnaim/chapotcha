class OrderFollow {
  var code;
  bool status;
  Orders orders;

  OrderFollow({this.code, this.status, this.orders});

  OrderFollow.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    orders =
        json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }
}

class Orders {
  num orderId;
  String status;

  List<ProductsOrder> productsOrder;
  List<Cartons> cartons;

  Orders({this.orderId, this.status, this.productsOrder, this.cartons});

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];

    status = json['status'];
    if (json['products'] != null) {
      productsOrder = new List<ProductsOrder>();
      json['products'].forEach((v) {
        productsOrder.add(new ProductsOrder.fromJson(v));
      });
    }
    if (json['cartons'] != null) {
      cartons = new List<Cartons>();
      json['cartons'].forEach((v) {
        cartons.add(new Cartons.fromJson(v));
      });
    }
  }
}

class ProductsOrder {
  num id;
  String orderId;
  String productId;
  String productName;
  String price;
  String quantity;
  String totalPrice;

  ProductsOrder(
      {this.id,
      this.orderId,
      this.productId,
      this.productName,
      this.price,
      this.quantity,
      this.totalPrice});

  ProductsOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    return data;
  }
}

class Cartons {
  int id;
  String orderId;
  String cartonId;
  String cartonName;
  String cartonPrice;
  String cartonQuantity;
  String totalPrice;

  Cartons(
      {this.id,
      this.orderId,
      this.cartonId,
      this.cartonName,
      this.cartonPrice,
      this.cartonQuantity,
      this.totalPrice});

  Cartons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    cartonId = json['carton_id'];
    cartonName = json['carton_name'];
    cartonPrice = json['carton_price'];
    cartonQuantity = json['carton_quantity'];
    totalPrice = json['total_price'];
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
