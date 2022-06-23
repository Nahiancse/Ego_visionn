class UserModel {
  User? user;
  String? success;

  UserModel({this.user, this.success});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class User {
  String? id;
  String? code;
  String? name;
  String? phone;
  String? address;
  String? password;
  Null? organizationName;
  Null? image;
  String? status;
  String? branchId;

  User(
      {this.id,
      this.code,
      this.name,
      this.phone,
      this.address,
      this.password,
      this.organizationName,
      this.image,
      this.status,
      this.branchId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    password = json['password'];
    organizationName = json['organization_name'];
    image = json['image'];
    status = json['status'];
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['password'] = this.password;
    data['organization_name'] = this.organizationName;
    data['image'] = this.image;
    data['status'] = this.status;
    data['branch_id'] = this.branchId;
    return data;
  }
}
