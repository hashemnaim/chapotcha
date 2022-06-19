class UpdateUser {
  int code;
  bool status;
  String message;
  UserUpdate userUpdate;

  UpdateUser({this.code, this.status, this.message, this.userUpdate});

  UpdateUser.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
   userUpdate = json['user'] != null ? new  UserUpdate.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userUpdate != null) {
      data['user'] = this.userUpdate.toJson();
    }
    return data;
  }
}

class UserUpdate {
  int id;
  String name;
  String mobile;
  String email;
  String address;

  UserUpdate(
      {this.id,
      this.name,
      this.mobile,
      this.email,
      this.address});

  UserUpdate.fromJson(Map<String, dynamic> json) {
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
    data['address'] = this.address;
    return data;
  }
}
