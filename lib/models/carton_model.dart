class CartonModel {
  int code;
  bool status;
  String message;
  List<DataCarton> dataCarton;

  CartonModel({this.code, this.status, this.message, this.dataCarton});

  CartonModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      dataCarton = new List<DataCarton>();
      json['data'].forEach((v) {
        dataCarton.add(new DataCarton.fromJson(v));
      });
    }
  }
}

class DataCarton {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String mainPrice;
  String cartonPrice;
  String discount;
  String status;
  String image;
  String stock;
  String maxQty;
  List<Products> products;

  DataCarton(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.mainPrice,
      this.cartonPrice,
      this.discount,
      this.maxQty,
      this.stock,
      this.status,
      this.image,
      this.products});

  DataCarton.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mainPrice = json['main_price'];
    cartonPrice = json['carton_price'];
    discount = json['discount'];
    status = json['status'];
    stock = json['stock'];
    maxQty = json['max_qty'];
    image = json['image'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }
}

class Products {
  int id;
  String productId;
  String cartonId;
  String productQuantity;
  String createdAt;
  String updatedAt;
  Product product;

  Products(
      {this.id,
      this.productId,
      this.cartonId,
      this.productQuantity,
      this.createdAt,
      this.updatedAt,
      this.product});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    cartonId = json['carton_id'];
    productQuantity = json['product_quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }
}

class Product {
  int id;
  String createdAt;
  String updatedAt;
  String name;
  String price;
  String categoryId;
  String image;
  String state;
  String offer;
  String unit;
  String oldPrice;
  String maxQty;
  String points;

  Product(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.price,
      this.categoryId,
      this.image,
      this.state,
      this.offer,
      this.unit,
      this.oldPrice,
      this.maxQty,
      this.points});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    price = json['price'];
    categoryId = json['category_id'];
    image = json['image'];
    state = json['state'];
    offer = json['offer'];
    unit = json['unit'];
    oldPrice = json['old_price'];
    maxQty = json['max_qty'];
    points = json['points'];
  }
}
