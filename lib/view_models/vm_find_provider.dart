import 'dart:math';

import 'package:thesis_project/models/search_provider.dart';
import 'package:thesis_project/repository/repo_search_provider.dart';

import '../models/provider.dart';

class FindProviderViewModel {
  SearchProviderRepository searchProviderRepository =
      SearchProviderRepository();
  Future<List<ServiceProvider>> mGetProviderList(
      {required double myLatitude,
      required double myLongitude,
      required String category,
      required int searchRange}) async {
    ProviderSearch providerSearch = ProviderSearch(
        myLatitude: myLatitude,
        myLongitude: myLongitude,
        category: category,
        searchRange: searchRange);

    return await searchProviderRepository.mGetProviderList(
        providerSearch: providerSearch);
  }

   double mCalculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // Earth's radius in kilometers

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            pow(sin(dLon / 2), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
