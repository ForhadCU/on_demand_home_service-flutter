import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/models/search_provider.dart';

import '../models/provider.dart';

class SearchProviderRepository {
 Future< List<ServiceProvider>> mGetProviderList(
      {required ProviderSearch providerSearch})  async {
    // e: send this object to data base

    // e: get result and return to vm
    List<ServiceProvider> list = providerList;

    return list;
  }
}
