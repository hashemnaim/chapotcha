import '../../../widgets/custom_drop_down.dart';

class CitiesModel {
  // bool status;
  String? message;
  List<Item>? item;

  int? code;

  CitiesModel({this.message, this.item, this.code});

  CitiesModel.fromJson(Map<String, dynamic> json) {
    // status = json['status'];
    message = json['message'];

    if (json['data'] != null) {
      item = <Item>[];
      json['data'].forEach((v) {
        item!.add(Item.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['status'] = status;
    data['message'] = message;
    if (item != null) {
      data['data'] = item!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class AddressModel {
  int? code;
  String? message;
  List<DataAddress>? data;

  AddressModel({this.code, this.message, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataAddress>[];
      json['data'].forEach((v) {
        data!.add(new DataAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataAddress {
  int? id;
  String? phone;
  String? street;
  String? building;
  String? apartment;
  String? lat;
  String? lng;
  int? isDefault;
  String? city;
  String? area;

  DataAddress(
      {this.id,
      this.phone,
      this.street,
      this.building,
      this.apartment,
      this.lat,
      this.lng,
      this.isDefault,
      this.city,
      this.area});

  DataAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    street = json['street'];
    building = json['building'];
    apartment = json['apartment'];
    lat = json['lat'];
    lng = json['lng'];
    isDefault = json['is_default'];
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
    data['is_default'] = this.isDefault;
    data['city'] = this.city;
    data['area'] = this.area;
    return data;
  }
}
