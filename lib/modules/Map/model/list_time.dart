class CartListTimeModel {
  int? code;
  bool? statues;
  String? message;
  String? lastAddress;
  String? locationLong;
  String? lastMobile;
  String? locationLat;
  List<Cities>? cities;

  CartListTimeModel({
    this.code,
    this.statues,
    this.message,
    this.lastAddress,
    this.lastMobile,
    this.locationLong,
    this.locationLat,
    this.cities,
  });

  CartListTimeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    statues = json['statues'];
    message = json['message'];
    lastAddress = json['last_address'];
    lastMobile = json['last_mobile'];
    locationLong = json['location_long'];
    locationLat = json['location_lat'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['statues'] = this.statues;
    data['message'] = this.message;
    data['last_address'] = this.lastAddress;
    data['last_mobile'] = this.lastMobile;
    data['location_long'] = this.locationLong;
    data['location_lat'] = this.locationLat;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Cities {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? available;
  List<Areas>? areas;

  Cities(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.available,
      this.areas});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    available = json['available'];
    if (json['areas'] != null) {
      areas = <Areas>[];
      json['areas'].forEach((v) {
        areas!.add(new Areas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['available'] = this.available;
    if (this.areas != null) {
      data['areas'] = this.areas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  int? id;
  String? name;
  String? cityId;
  String? available;
  String? createdAt;
  String? updatedAt;
  String? shippingCost;
  List<String>? shippingTimes;

  Areas(
      {this.id,
      this.name,
      this.cityId,
      this.available,
      this.createdAt,
      this.updatedAt,
      this.shippingCost,
      this.shippingTimes});

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cityId = json['city_id'];
    available = json['available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    shippingCost = json['shipping_cost'];

    shippingTimes = json['shipping_times'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city_id'] = this.cityId;
    data['available'] = this.available;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['shipping_cost'] = this.shippingCost;

    data['shipping_times'] = this.shippingTimes;
    return data;
  }
}
