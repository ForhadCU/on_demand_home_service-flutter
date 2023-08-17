class CurrentLocationDetails {
  double? lat;
  double? long;
  String? formattedAdress;
  String? placeId;

  CurrentLocationDetails({this.lat, this.long, this.formattedAdress, this.placeId});

  CurrentLocationDetails.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    formattedAdress = json['location'];
    formattedAdress = json['placeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = lat;
    data['long'] = long;
    data['location'] = formattedAdress;
    data['placeId'] = placeId;
    return data;
  }
}
