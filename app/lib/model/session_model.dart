class SessionModel {
  String displayName;
  String email;
  String token;

  SessionModel({required this.displayName, required this.email,required this.token});

  factory SessionModel.fromJson(Map<String, dynamic> parsedJson) {
    return SessionModel(
        displayName: parsedJson['username'],
        email: parsedJson['email'],
        token: parsedJson['token']);

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> session = Map<String, dynamic>();
    session['username'] = displayName;
    session['email'] = email;
    session['token'] = token;
    return session;
  }
}