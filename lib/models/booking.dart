class Booking {
  String? _providerId;
  String? _providerName;
  String? _serviceCategory;
  String? _providerImgUrl;
  String? _schedule;
  String? _providerAddress;
  int? _workingHour;
  int? _serviceFee;
  bool? _status;

  Booking(
      {String? providerId,
      String? providerName,
      String? serviceCategory,
      String? providerImgUrl,
      String? schedule,
      String? providerAddress,
      int? serviceFee,
      int? workingHour,
      bool? status}) {
    if (providerId != null) {
      _providerId = providerId;
    }
    if (providerName != null) {
      _providerName = providerName;
    }
    if (serviceCategory != null) {
      _serviceCategory = serviceCategory;
    }
    if (providerImgUrl != null) {
      _providerImgUrl = providerImgUrl;
    }
    if (schedule != null) {
      _schedule = schedule;
    }
    if (providerAddress != null) {
      _providerAddress = providerAddress;
    }
    if (serviceFee != null) {
      _serviceFee = serviceFee;
    }
    if (workingHour != null) {
      _workingHour = workingHour;
    }
    if (status != null) {
      _status = status;
    }
  }

  String? get providerId => _providerId;
  set providerId(String? providerId) => _providerId = providerId;
  String? get providerName => _providerName;
  set providerName(String? providerName) => _providerName = providerName;
  String? get serviceCategory => _serviceCategory;
  set serviceCategory(String? serviceCategory) =>
      _serviceCategory = serviceCategory;
  String? get providerImgUrl => _providerImgUrl;
  set providerImgUrl(String? providerImgUrl) =>
      _providerImgUrl = providerImgUrl;
  String? get schedule => _schedule;
  set schedule(String? schedule) => _schedule = schedule;

  String? get providerAddress => _providerAddress;
  set providerAddress(String? providerAddress) =>
      _providerAddress = providerAddress;

  int? get serviceFee => _serviceFee;
  set serviceFee(int? serviceFee) => _serviceFee = serviceFee;
  int? get workingHour => _workingHour;
  set workingHour(int? workingHour) => _workingHour = workingHour;
  bool? get status => _status;
  set status(bool? status) => _status = status;

  Booking.fromJson(Map<String, dynamic> json) {
    _providerId = json['providerId'];
    _providerName = json['providerName'];
    _serviceCategory = json['serviceCategory'];
    _providerImgUrl = json['providerImgUrl'];
    _schedule = json['schedule'];
    _serviceFee = json['serviceFee'];
    _status = json['status'];
    _workingHour = json['workingHour'];
    _providerAddress = json['providerAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providerId'] = _providerId;
    data['providerName'] = _providerName;
    data['serviceCategory'] = _serviceCategory;
    data['providerImgUrl'] = _providerImgUrl;
    data['schedule'] = _schedule;
    data['serviceFee'] = _serviceFee;
    data['status'] = _status;
    data['workingHour'] = _workingHour;
    data['providerAddress'] = _providerAddress;
    return data;
  }
}
