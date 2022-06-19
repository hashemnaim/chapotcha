class RegisterModel {
  int code;
  bool status;
  String message;
  String accessToken;

  DataRegister data;

  RegisterModel({this.code, this.status, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    accessToken = json['accessToken'];
    data =
        json['data'] != null ? new DataRegister.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    data['accessToken'] = this.accessToken;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DataRegister {
  int id;
  String name;
  String mobile;
  String email;

  DataRegister({
    this.id,
    this.name,
    this.mobile,
    this.email,
  });

  DataRegister.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];

    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;

    data['email'] = this.email;

    return data;
  }
}
