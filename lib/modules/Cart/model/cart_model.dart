class CartModel {
  int? productId;
  String? productName;
  String? price;
  String? quantity;
  String? image;
  String? unit;
  String? stock;
  String? maxQty;
  bool? available;

  CartModel(
      {this.productId,
      this.productName,
      this.price,
      this.quantity,
      this.image,
      this.unit,
      this.maxQty,
      this.stock,
      this.available});

  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json['id'];
    productName = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
    unit = json['unit'];
    maxQty = json['max_quantity'];
    stock = json['stock'];
    // available = json['available'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': productId,
      'name': productName,
      'price': price,
      'quantity': quantity,
      'image': image,
      'unit': unit,
      'max_quantity': maxQty,
      'stock': stock,
    };
  }

  Map<String, dynamic> toMapProduct() {
    return {
      'product_id': productId,
      'quantity': quantity,
    };
  }

  Map<String, dynamic> toMapCartona() {
    return {
      'carton_id': productId,
      'quantity': quantity,
    };
  }
}
