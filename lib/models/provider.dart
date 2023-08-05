class ServiceProvider {
  String? id;
  String? name;
  String? category;
  String? usertype;
  double? lat;
  double? long;
  int? rating;
  int? serviceFee;
  String? imgUri;
  int? numOfReview;

  ServiceProvider({
    this.id,
    this.name,
    this.category,
    this.usertype,
    this.lat,
    this.long,
    this.rating,
    this.serviceFee,
    this.imgUri,
    this.numOfReview,
  });

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    usertype = json['usertype'];
    lat = json['lat'];
    long = json['long'];
    rating = json['rating'];
    serviceFee = json['serviceFee'];
    imgUri = json['imgUri'];
    numOfReview = json['numOfReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['usertype'] = usertype;
    data['lat'] = lat;
    data['long'] = long;
    data['rating'] = rating;
    data['serviceFee'] = serviceFee;
    data['imgUri'] = imgUri;
    data['numOfReview'] = numOfReview;
    return data;
  }
}
