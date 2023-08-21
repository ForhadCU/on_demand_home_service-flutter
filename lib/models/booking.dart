import 'package:thesis_project/models/provider_dataset.dart';

class Booking {
  ProviderDataset? providerDataSet;
  double? workingHour;
  int? ts;
  bool? bookingStatus;

  Booking(
      {this.providerDataSet, this.workingHour, this.ts, this.bookingStatus});

  Booking.fromJson({required Map<String, dynamic> json}) {
    providerDataSet = json["providerDataSet"] != null
        ? ProviderDataset.fromJson(json["providerDataSet"])
        : null;
    workingHour = json["workingHour"];
    ts = json["ts"];
    bookingStatus = json["bookingStatus"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    if (providerDataSet != null) {
      data["providerDataSet"] = providerDataSet!.toJson();
    }

    data["workingHour"] = workingHour;
    data["ts"] = ts;
    data["bookingStatus"] = bookingStatus;

    return data;
  }
}
