class ShippingTimesModel {
  bool? statues;
  String? message;
  Cities? cities;

  ShippingTimesModel({this.statues, this.message, this.cities});

  ShippingTimesModel.fromJson(Map<String, dynamic> json) {
    statues = json['statues'];
    message = json['message'];
    cities =
        json['cities'] != null ? new Cities.fromJson(json['cities']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statues'] = this.statues;
    data['message'] = this.message;
    if (this.cities != null) {
      data['cities'] = this.cities!.toJson();
    }
    return data;
  }
}

class Cities {
  String? areaName;
  String? shippingCost;
  List<ShippingTimes>? shippingTimes;

  Cities({this.areaName, this.shippingCost, this.shippingTimes});

  Cities.fromJson(Map<String, dynamic> json) {
    areaName = json['area_name'];
    shippingCost = json['shipping_cost'];
    if (json['shipping_times'] != null) {
      shippingTimes = <ShippingTimes>[];
      json['shipping_times'].forEach((v) {
        shippingTimes!.add(new ShippingTimes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_name'] = this.areaName;
    data['shipping_cost'] = this.shippingCost;
    if (this.shippingTimes != null) {
      data['shipping_times'] =
          this.shippingTimes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingTimes {
  String? period;
  int? avilable;

  ShippingTimes({this.period, this.avilable});

  ShippingTimes.fromJson(Map<String, dynamic> json) {
    period = json['period'];
    avilable = json['avilable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period'] = this.period;
    data['avilable'] = this.avilable;
    return data;
  }
}
