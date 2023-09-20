class AuthResponseModel {
  int success;
  String? token;
  String? error;

  AuthResponseModel({required this.success, this.token, this.error});

  factory AuthResponseModel.fromJson(Map<String, dynamic> parsedJson) {
    return AuthResponseModel(
        success: parsedJson['success'],
        token: parsedJson['token'],
        error: parsedJson['error']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user['success'] = success;
    user['token'] = token;
    user['error'] = error;
    return user;
  }
}

/*
class Data {
  String? id;
  String? username;
  String? email;

  Data({this.id, this.username, this.email});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json['id'], username: json['username'], email: json['email']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    return data;
  }
}
 */
