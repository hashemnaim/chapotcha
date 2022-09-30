class Sliders {
  num? id;
  String? title;
  String? image;

  Sliders({this.id, this.title, this.image});

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}
