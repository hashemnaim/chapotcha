class LoginModel {
  int code;
  bool status;
  String message;
  UserLogin userLogin;
  String accessToken;

  LoginModel(
      {this.code, this.status, this.message, this.userLogin, this.accessToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    userLogin =
        json['user'] != null ? new UserLogin.fromJson(json['user']) : null;
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userLogin != null) {
      data['user'] = this.userLogin.toJson();
    }
    data['accessToken'] = this.accessToken;

    return data;
  }
}

class UserLogin {
  int id;
  String name;
  String mobile;
  String email;
  String address;

  UserLogin({this.id, this.name, this.mobile, this.email, this.address});

  UserLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    return data;
  }
}
