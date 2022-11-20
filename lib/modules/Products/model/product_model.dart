class Product {
  int? id;
  String? name;
  String? price;
  String? categoryId;
  String? image;
  String? state;
  String? offer;
  String? unit;
  String? oldPrice;
  String? quantity;
  String? maxQty;
  String? stock;

  Product({
    this.id,
    this.name,
    this.price,
    this.oldPrice,
    this.categoryId,
    this.image,
    this.state,
    this.offer,
    this.quantity,
    this.unit,
    this.maxQty,
    this.stock,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'].toString();
    price = json['price'].toString();
    categoryId = json['category_id'].toString();
    image = json['image'].toString();
    state = json['state'].toString();
    offer = json['offer'].toString();
    unit = json['unit'].toString();
    quantity = json['quantity'].toString();
    oldPrice = json['old_price'].toString();
    maxQty = json['max_qty'].toString();
    stock = json['stock'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    data['state'] = this.state;
    data['offer'] = this.offer;
    data['max_qty'] = this.maxQty;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['old_price'] = this.oldPrice;
    data['stock'] = this.stock;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'quantity': "1.0",
      'image': this.image,
      'unit': this.unit,
      'max_quantity': this.maxQty,
      'stock': this.stock,
    };
  }
}
