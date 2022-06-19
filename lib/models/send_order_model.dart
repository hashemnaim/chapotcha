class SendOrder {
  int code;
  bool status;
  String message;
  var orderId;

  SendOrder({this.code, this.status, this.message, this.orderId});

  SendOrder.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    data['order_id'] = this.orderId;
    return data;
  }
}
