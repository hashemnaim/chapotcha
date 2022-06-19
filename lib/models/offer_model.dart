class OfferModel {
  int code;
  bool status;
  String message;
  List<DataOffer> dataOffer;

  OfferModel({this.code, this.status, this.message, this.dataOffer});

  OfferModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];

    if (json['data'] != null) {
      dataOffer = new List<DataOffer>();
      json['data'].forEach((v) {
        dataOffer.add(new DataOffer.fromJson(v));
      });
    }
  }
}

class DataOffer {
  int id;
  String name;
  String price;
  String status;
  String offer;
  String oldPrice;
  String image;
  String unit;
  String maxQty;
  String stock;
  DataOffer(
      {this.id,
      this.name,
      this.price,
      this.oldPrice,
      this.status,
      this.offer,
      this.maxQty,
      this.stock,
      this.image,
      this.unit});

  DataOffer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    status = json['state'];
    offer = json['offer'];
    oldPrice = json['old_price'];
    image = json['image'];
    maxQty = json['max_qty'];
    stock = json['stock'];
    unit = json['unit'];
  }
}
