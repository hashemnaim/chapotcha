class Profile_Modal {
  int code;
  bool status;
  String message;
  UserMyProfile user;

  Profile_Modal({this.code, this.status, this.message, this.user});

  Profile_Modal.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    user =
        json['user'] != null ? new UserMyProfile.fromJson(json['user']) : null;
  }
}

class UserMyProfile {
  int id;
  String name;
  String mobile;
  String email;
  String address;
  String points;
  String balance;
  List<Order> order;

  UserMyProfile(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.address,
      this.order,
      this.balance,
      this.points});

  UserMyProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    address = json['points'];
    balance = json['balance'];
    if (json['order'] != null) {
      order = new List<Order>();
      json['order'].forEach((v) {
        order.add(new Order.fromJson(v));
      });
    }
  }
}

class Order {
  num id;
  String userId;
  String totalPrice;

  String status;
  String statusCode;
  List<Details> details;

  Order(
      {this.id,
      this.userId,
      this.totalPrice,
      this.status,
      this.statusCode,
      this.details});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    status = json['status'];
    statusCode = json['status_code'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['total_price'] = this.totalPrice;
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  num id;
  String orderId;
  String productId;
  String productName;
  String price;
  String quantity;
  String totalPrice;

  Details(
      {this.id,
      this.orderId,
      this.productId,
      this.productName,
      this.price,
      this.quantity,
      this.totalPrice});

  Details.fromJson(Map<String, dynamic> json) {
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
