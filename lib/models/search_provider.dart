class ProviderSearch {
  late double _myLatitude;
  late double _myLongitude;
  late String _category;
  late int _searchRange;

  ProviderSearch(
      {required myLatitude,
      required double myLongitude,
      required String category,
      required int searchRange}) {
    _myLatitude = myLatitude;
    _myLongitude = myLongitude;
    _category = category;
    _searchRange = searchRange;
  }

  double get myLatitude => _myLatitude;
  set myLatitude(double myLatitude) => _myLatitude = myLatitude;
  double get myLongitude => _myLongitude;
  set myLongitude(double myLongitude) => _myLongitude = myLongitude;
  String get category => _category;
  set category(String category) => _category = category;
  int get searchRange => _searchRange;
  set searchRange(int searchRange) => _searchRange = searchRange;

  ProviderSearch.fromJson(Map<String, dynamic> json) {
    _myLatitude = json['myLatitude'];
    _myLongitude = json['myLongitude'];
    _category = json['category'];
    _searchRange = json['searchRange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['myLatitude'] = _myLatitude;
    data['myLongitude'] = _myLongitude;
    data['category'] = _category;
    data['searchRange'] = _searchRange;
    return data;
  }
}
