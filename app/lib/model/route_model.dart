class RouteModel {
  String id;
  String name;
  String description;
  bool visibility;
  int? difficulty;
  int rating;
  String email;
  double distance;
  double? fromDistance;
  List<String>? tags;
  List<String>? images;
  List<Reviews>? reviews;
  List<dynamic> waypoints;

  RouteModel({required this.id,required this.name, this.description="", this.visibility=false, this.difficulty,
      this.rating = 0, required this.email,required this.distance,this.fromDistance, this.tags, this.images, required this.waypoints,this.reviews});

  factory RouteModel.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> images = parsedJson['images'];
    List<dynamic> waypoints = parsedJson['waypoints'];
    List<dynamic> tags = parsedJson['tags'];
    var reviews = parsedJson['reviews'] as List;
    List<Reviews> reviewsList = reviews.map((i) => Reviews.fromJson(i)).toList();
    return RouteModel(
        id: parsedJson['_id'],
        name: parsedJson['name'],
        email: parsedJson['email'],
        description: parsedJson['description'],
        difficulty: parsedJson['difficulty'],
        fromDistance: parsedJson['fromDistance'],
        distance: double.parse(parsedJson["distance"].toString()),
        rating: parsedJson['rating'],
        images: images.cast<String>(),
        waypoints: waypoints,
        tags:tags.cast<String>(),
        reviews: reviewsList
    );

  }
}

class Reviews {
  String? content;
  List<String>? images;
  String? displayName;
  String? email;
  String? picture;


  Reviews({this.content, this.images, this.displayName, this.email, this.picture});

  factory Reviews.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> images = parsedJson['images'];
    return Reviews(
        content: parsedJson['content'],
        images: images.cast<String>(),
        displayName:parsedJson['username'],
        email:parsedJson['email'],
        picture: parsedJson['picture']);
  }
}
