class Discount {
  int code;
  bool status;
  String message;
  String dataDiscount="0";

  Discount({this.code, this.status, this.message, this.dataDiscount});

  Discount.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    dataDiscount = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.dataDiscount;
    return data;
  }
}
