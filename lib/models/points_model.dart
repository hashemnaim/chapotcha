class Points {
  int code;
  bool status;
  String message;
  String points="0";
  String image;
  String details;

  Points(
      {this.code,
      this.status,
      this.message,
      this.points,
      this.image,
      this.details});

  Points.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    points = json['points'];
    image = json['image'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    data['points'] = this.points;
    data['image'] = this.image;
    data['details'] = this.details;
    return data;
  }
}
