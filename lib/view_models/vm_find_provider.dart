import 'dart:math';

import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/models/provider_dataset.dart';
import 'package:thesis_project/models/search_provider.dart';
import 'package:thesis_project/repository/repo_search_provider.dart';
import 'package:thesis_project/utils/sorting.dart';
import 'package:thesis_project/view_models/vm_map.dart';

import '../models/provider.dart';

class FindProviderViewModel {
  final SearchProviderRepository searchProviderRepository =
      SearchProviderRepository();
  final Sorting _sorting = Sorting();
  final MapViewModel mapViewModel = MapViewModel();

  Future<List<ProviderDataset>> mGetAvailableProvidersIntoRange({
    required List<ProviderDataset> providerDataset,
    required double range,
    required double consumerLat,
    required double consumerLong,
    required String serviceCategory,
  }) async {
    List<ProviderDataset> results = [];

    for (var element in providerDataset) {
      double currentProviderDistance = mCalculateDistance(
          consumerLat, consumerLong, element.lat!, element.long!);
      if (currentProviderDistance <= range &&
          element.category == serviceCategory) {
        element.liveDistance = currentProviderDistance;
        results.add(element);
      }
    }
    // c: just for loading some moments
    await Future.delayed(const Duration(milliseconds: 1000));
    return results;
  }

  List<ProviderDataset> mSortProvidersForMinDistance(
      List<ProviderDataset> availableProvidersInRange) {
    List<ProviderDataset> list = [];

    /*   logger.d(
        "Sorted by distance: ${List.generate(_sorting.quicksortForProviderMinDistance(providerDatasetList).length, (index) => _sorting.quicksortForProviderMinDistance(providerDatasetList)[index].toJson())}"); */

    list = _sorting.quicksortForProviderMinDistance(availableProvidersInRange);
    /*  for (var element
        in _sorting.quicksortForProviderMinDistance(providerDatasetList)) {
      logger.d(
          "Provider Name: ${element.name} | Distance: ${element.liveDistance}");
    } */

    return list;
  }

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
    double startLat,
    double startLong,
    double endLat,
    double endLong,
  ) {
    return mapViewModel.mCalculateDistanceFromLatLong(
      startLat: startLat,
      startLong: startLong,
      endLat: endLat,
      endLong: endLong,
    );
  }

  mSortProviderForMaxRating(List<ProviderDataset> availableProvidersIntoRange) {
    List<ProviderDataset> list =
        _sorting.quicksortForProviderMaxRating(availableProvidersIntoRange);
    return list;
  }
}
