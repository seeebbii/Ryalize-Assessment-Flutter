import 'auth_data.model.dart';

class AuthenticationModel {
  int? status;
  bool? success;
  String? message;
  String? token;
  AuthData? user;

  AuthenticationModel(
      {this.status, this.success, this.message, this.token, this.user});

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? AuthData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
