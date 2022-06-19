class CompleteCart {
  int code;
  bool statues;
  String message;
  String lastAddress;
  String lastmobile;
  String locationlong;
  String locationlat;
  List<Cities> cities;
  CompleteCart({
    this.code,
    this.statues,
    this.message,
    this.lastAddress,
    this.lastmobile,
    this.cities,
  });

  CompleteCart.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    statues = json['statues'];
    message = json['message'];
    lastAddress = json['last_address'];
    lastmobile = json['last_mobile'];
    locationlong = json['location_long'];
    locationlat = json['location_lat'];

    if (json['cities'] != null) {
      cities = new List<Cities>();
      json['cities'].forEach((v) {
        cities.add(new Cities.fromJson(v));
      });
    }
    if (json['shipping_time'] != null) {}
  }
}

class ShippingTime {
  int id;
  String title;
  String avilable;
  String time;
  String max;

  ShippingTime({this.id, this.title, this.avilable, this.time, this.max});

  ShippingTime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    avilable = json['avilable'];
    time = json['time'];
    max = json['max'];
  }
}

class Cities {
  int id;
  String name;
  String available;
  List<Areas> areas;

  Cities({this.id, this.name, this.available, this.areas});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    available = json['available'];
    if (json['areas'] != null) {
      areas = new List<Areas>();
      json['areas'].forEach((v) {
        areas.add(new Areas.fromJson(v));
      });
    }
  }
}

class Areas {
  int id;
  String name;
  String cityId;
  String available;
  String shippingCost;
  List<String> shippingTimes;

  Areas({
    this.id,
    this.name,
    this.cityId,
    this.available,
    this.shippingCost,
    this.shippingTimes,
  });

  Areas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cityId = json['city_id'];
    available = json['available'];
    shippingCost = json['shipping_cost'];
    if (json['shipping_times'] != null) {
      shippingTimes = new List<String>();
      json['shipping_times'].forEach((v) {
        shippingTimes.add(v);
      });
    }
  }
}
