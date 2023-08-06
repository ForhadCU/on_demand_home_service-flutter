class CurrentLocationDetails {
  double? lat;
  double? long;
  String? formattedAdress;

  CurrentLocationDetails({this.lat, this.long, this.formattedAdress});

  CurrentLocationDetails.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    formattedAdress = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['location'] = this.formattedAdress;
    return data;
  }
}
