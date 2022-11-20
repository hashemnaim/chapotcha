class ProfileModel {
  int? code;
  bool? status;
  String? message;
  User? user;
  Address? address;

  ProfileModel({this.code, this.status, this.message, this.user, this.address});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? mobile;
  String? totalDept;
  String? image;
  String? type;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? membership;
  String? mobileVerifyCode;
  String? status;
  String? favorits;
  String? upgradeStatus;
  String? points;
  String? balance;
  String? coponCode;
  String? address;
  String? fcmToken;

  User({
    this.id,
    this.name,
    this.mobile,
    this.totalDept,
    this.image,
    this.type,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.membership,
    this.mobileVerifyCode,
    this.status,
    this.favorits,
    this.upgradeStatus,
    this.points,
    this.balance,
    this.coponCode,
    this.address,
    this.fcmToken,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    totalDept = json['total_dept'];
    image = json['image'];
    type = json['type'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    membership = json['membership'];
    mobileVerifyCode = json['mobile_verify_code'];
    status = json['status'];
    favorits = json['favorits'];
    upgradeStatus = json['upgrade_status'];
    points = json['points'];
    balance = json['balance'];
    coponCode = json['copon_code'];
    address = json['address'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['total_dept'] = this.totalDept;
    data['image'] = this.image;
    data['type'] = this.type;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['membership'] = this.membership;
    data['mobile_verify_code'] = this.mobileVerifyCode;
    data['status'] = this.status;
    data['favorits'] = this.favorits;
    data['upgrade_status'] = this.upgradeStatus;
    data['points'] = this.points;
    data['balance'] = this.balance;
    data['copon_code'] = this.coponCode;
    data['address'] = this.address;
    data['fcm_token'] = this.fcmToken;

    return data;
  }
}

class Address {
  int? id;
  String? phone;
  String? street;
  String? building;
  String? apartment;
  String? lat;
  String? lng;
  String? city;
  String? area;

  Address(
      {this.id,
      this.phone,
      this.street,
      this.building,
      this.apartment,
      this.lat,
      this.lng,
      this.city,
      this.area});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    street = json['street'];
    building = json['building'] ?? "";
    apartment = json['apartment'] ?? "";
    lat = json['lat'];
    lng = json['lng'];
    city = json['city'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['street'] = this.street;
    data['building'] = this.building;
    data['apartment'] = this.apartment;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['city'] = this.city;
    data['area'] = this.area;
    return data;
  }
}
