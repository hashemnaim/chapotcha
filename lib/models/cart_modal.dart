class CartModel {
  int code;
  bool statues;
  String message;
  String tax;
  int delavery;
  var points;
  var discount;
  String balance;
  int later;
  List<DataCart> dataCart;

  CartModel(
      {this.code,
      this.statues,
      this.message,
      this.tax,
      this.delavery,
      this.discount,
      this.balance,
      this.points,
      this.dataCart,
      this.later});

  CartModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    statues = json['statues'];
    message = json['message'];
    tax = json['tax'];
    points = json['points'];
    delavery = json['delivery'];
    discount = json['discount'];
    balance = json['balance'];

    if (json['data'] != null) {
      dataCart = new List<DataCart>();
      json['data'].forEach((v) {
        dataCart.add(new DataCart.fromJson(v));
      });
    }
    later = json['later'];
  }
}

class DataCart {
  int productId;
  String productName;
  num price;
  num quantity;
  String image;
  String unit;
  String stock;
  String maxQty;
  bool available;

  DataCart(
      {this.productId,
      this.productName,
      this.price,
      this.quantity,
      this.image,
      this.unit,
      this.maxQty,
      this.stock,
      this.available});

  DataCart.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
    unit = json['unit'];
    maxQty = json['max_quantity'];
    stock = json['stock'];
    available = json['available'];
  }

  DataCart.fromJsonDB(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }
  Map<String, dynamic> toJsonDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}

class DataCarontCart {
  int cartonId;
  num quantity;

  DataCarontCart({
    this.cartonId,
    this.quantity,
  });

  DataCarontCart.fromJsonDB(Map<String, dynamic> json) {
    cartonId = json['carton_id'];
    quantity = json['quantity'];
  }
  Map<String, dynamic> toJsonDB() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carton_id'] = this.cartonId;
    data['quantity'] = this.quantity;
    return data;
  }
}
