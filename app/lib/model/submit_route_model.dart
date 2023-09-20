class SubmitRouteModel {
  int success;
  String? error;
  int? expired;

  SubmitRouteModel({required this.success, this.error,this.expired});

  factory SubmitRouteModel.fromJson(Map<String, dynamic> parsedJson) {
    return SubmitRouteModel(
        success: parsedJson['success'],
        error: parsedJson['error'],
        expired: parsedJson['expired']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = Map<String, dynamic>();
    user['success'] = success;
    user['error'] = error;
    user['expired'] = expired;
    return user;
  }
}