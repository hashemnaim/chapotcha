class PromoCode {
  int code;
  bool status;
  String message;
  String promo;

  PromoCode({this.code, this.status, this.message, this.promo});

  PromoCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    promo = json['data'] ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.promo;
   
    return data;
  }
}

