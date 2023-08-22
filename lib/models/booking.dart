import 'package:thesis_project/models/provider_dataset.dart';

class Booking {
  ProviderDataset? providerDataSet;
  double? workingHour;
  int? ts;
  bool? bookingStatus;
  bool? acceptanceStatus;
  bool? rejectanceStatus;

  Booking(
      {this.providerDataSet, this.workingHour, this.ts, this.bookingStatus, this.acceptanceStatus, this.rejectanceStatus});

  Booking.fromJson({required Map<String, dynamic> json}) {
    providerDataSet = json["providerDataSet"] != null
        ? ProviderDataset.fromJson(json["providerDataSet"])
        : null;
    workingHour = json["workingHour"];
    ts = json["ts"];
    bookingStatus = json["bookingStatus"];
    acceptanceStatus = json["acceptanceStatus"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    if (providerDataSet != null) {
      data["providerDataSet"] = providerDataSet!.toJson();
    }

    data["workingHour"] = workingHour;
    data["ts"] = ts;
    data["bookingStatus"] = bookingStatus;
    data["acceptanceStatus"] = acceptanceStatus;

    return data;
  }
}
