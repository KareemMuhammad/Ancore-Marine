class UserHolder {
  bool? status;
  String? successNumber;
  String? message;
  User? user;

  UserHolder({this.status, this.successNumber, this.message, this.user});

  UserHolder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    successNumber = json['successNumber'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['successNumber'] = this.successNumber;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  int? roleId;
  String? token;

  User(
      {this.id,
        this.name,
        this.email,
        this.mobile,
        this.roleId,
        this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    roleId = json['role_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['role_id'] = this.roleId;
    data['token'] = this.token;
    return data;
  }
}