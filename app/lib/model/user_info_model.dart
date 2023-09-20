class UserInfoModel {
  int success;
  User? user;
  String? error;

  UserInfoModel({required this.success, this.user, this.error});

  factory UserInfoModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserInfoModel(
        success: parsedJson['success'],
        user: User.fromJson(parsedJson['user']),
        error: parsedJson['error']);
  }
}

class User {
  String? id;
  String? displayName;
  String? email;
  String? picture;

  User({this.id, this.displayName, this.email, this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        displayName: json['username'],
        email: json['email'],
        picture: json['picture']);
  }
}
