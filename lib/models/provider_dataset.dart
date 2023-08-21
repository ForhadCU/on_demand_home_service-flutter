class ProviderDataset {
  String? name;
  String? category;
  String? imgUri;
  double? rating;
  double? monthlyRating;
  int? numOfReview;
  int? serviceFee;
  String? location;
  double? lat;
  double? long;
  String? phone;
  List<Jobs>? jobs;
  int? activePeriod;
  double? liveDistance;

  ProviderDataset({
    required this.name,
    required this.category,
    required this.imgUri,
    required this.rating,
    required this.monthlyRating,
    required this.numOfReview,
    required this.serviceFee,
    required this.location,
    required this.lat,
    required this.long,
    required this.phone,
    required this.jobs,
    required this.activePeriod,
    required this.liveDistance,
  });

  ProviderDataset.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    imgUri = json['imgUri'];
    rating = json['rating'];
    monthlyRating = json['monthlyRating'];
    numOfReview = json['numOfReview'];
    serviceFee = json['serviceFee'];
    location = json['location'];
    lat = json['lat'];
    long = json['long'];
    phone = json['phone'];
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(Jobs.fromJson(v));
      });
    }
    activePeriod = json['activePeriod'];
    liveDistance = json['liveDistance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['category'] = category;
    data['imgUri'] = imgUri;
    data['rating'] = rating;
    data['monthlyRating'] = monthlyRating;
    data['numOfReview'] = numOfReview;
    data['serviceFee'] = serviceFee;
    data['location'] = location;
    data['lat'] = lat;
    data['long'] = long;
    data['phone'] = phone;
    data['liveDistance'] = liveDistance;
    if (jobs != null) {
      data['jobs'] = jobs!.map((v) => v.toJson()).toList();
    }
    data['activePeriod'] = activePeriod;
    return data;
  }
}

class Jobs {
  String? consumerName;
  int? workingHour;
  int? ts;

  Jobs({this.consumerName, this.workingHour, this.ts});

  Jobs.fromJson(Map<String, dynamic> json) {
    consumerName = json['consumerName'];
    workingHour = json['workingHour'];
    ts = json['ts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['consumerName'] = consumerName;
    data['workingHour'] = workingHour;
    data['ts'] = ts;
    return data;
  }
}
