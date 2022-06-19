class HomeModel {
  var code;
  bool status;
  String message;
  List<DataCategory> dataCategory;
  List<Sliders> sliders;

  HomeModel(
      {this.code, this.status, this.message, this.dataCategory, this.sliders});

  HomeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      dataCategory = new List<DataCategory>();
      json['data'].forEach((v) {
        dataCategory.add(new DataCategory.fromJson(v));
      });
    }
    if (json['sliders'] != null) {
      sliders = new List<Sliders>();
      json['sliders'].forEach((v) {
        sliders.add(new Sliders.fromJson(v));
      });
    }
  }
}

class DataCategory {
  num id;
  String name;
  String description;
  String image;
  String prepare;
  String isCarton;

  List<Product> product;

  DataCategory(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.prepare,
      this.isCarton,
      this.product});

  DataCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    prepare = json['prepare'];
    isCarton = json['isCarton'];
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }
}

class Product {
  num id;
  String name;
  String price;
  String categoryId;
  String image;
  String state;
  String offer;
  String unit;
  String oldPrice;
  String maxQty;
  String stock;

  Product({
    this.id,
    this.name,
    this.price,
    this.oldPrice,
    this.categoryId,
    this.image,
    this.state,
    this.offer,
    this.unit,
    this.maxQty,
    this.stock,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];
    price = json['price'];
    categoryId = json['category_id'];
    image = json['image'];
    state = json['state'];
    offer = json['offer'];
    unit = json['unit'];
    oldPrice = json['old_price'];
    maxQty = json['max_qty'];
    stock = json['stock'];
  }
}

class Sliders {
  num id;
  String title;
  String image;

  Sliders({this.id, this.title, this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}
