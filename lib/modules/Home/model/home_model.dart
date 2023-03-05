import 'slider_model.dart';

class HomeModel {
  // var code;
  bool? status;
  String? message;
  List<DataCategory>? dataCategory;
  List<Sliders>? sliders;

  HomeModel({this.status, this.message, this.dataCategory, this.sliders});

  HomeModel.fromJson(Map<String, dynamic> json) {
    // code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      dataCategory = <DataCategory>[];
      json['data'].forEach((v) {
        dataCategory!.add(new DataCategory.fromJson(v));
      });
    }
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(new Sliders.fromJson(v));
      });
    }
  }
}

class DataCategory {
  int? id;
  String? name;
  String? image;

  DataCategory({
    this.id,
    this.name,
    this.image,
  });

  DataCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
