class SendMassage {
  int code;
  bool status;
  String message;
  Data data;

  SendMassage({this.code, this.status, this.message, this.data});

  SendMassage.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String name;
  String mobile;
  String title;
  String body;

  int id;

  Data(
      {this.name,
      this.mobile,
      this.title,
      this.body,
    
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    title = json['title'];
    body = json['body'];
 
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['title'] = this.title;
    data['body'] = this.body;
   
    data['id'] = this.id;
    return data;
  }
}
