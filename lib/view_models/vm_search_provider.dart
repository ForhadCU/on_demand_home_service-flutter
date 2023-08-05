import 'package:thesis_project/models/search_provider.dart';
import 'package:thesis_project/repository/repo_search_provider.dart';

import '../models/provider.dart';

class SearchProviderViewModel {
  SearchProviderRepository searchProviderRepository =
      SearchProviderRepository();
 Future< List<ServiceProvider>> mGetProviderList(
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
}
