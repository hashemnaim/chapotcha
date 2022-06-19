class Search {
  int code;
  bool status;
  String message;
  List<DataSearch> dataSearch;

  Search({this.code, this.status, this.message, this.dataSearch});

  Search.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      dataSearch = new List<DataSearch>();
      json['data'].forEach((v) {
        dataSearch.add(new DataSearch.fromJson(v));
      });
    }
  }
}

class DataSearch {
  int id;
  String name;
  String price;
  String oldPrice;

  String status;
  String offer;
  String unit;
  String image;
  String stock;
  String maxQty;

  DataSearch(
      {this.id,
      this.name,
      this.price,
      this.unit,
      this.status,
      this.oldPrice,
      this.offer,
      this.maxQty,
      this.stock,
      this.image});

  DataSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    unit = json['unit'];
    oldPrice = json['old_price'];

    status = json['state'];
    offer = json['offer'];
    image = json['image'];
    stock = json['stock'];
    maxQty = json['max_qty'];
  }
}
