import 'package:thesis_project/utils/sorting.dart';

import '../models/provider_dataset.dart';

class ProviderDataViewModel {
  Sorting sorting = Sorting();
  List<ProviderDataset> mGetActivityPeriod(
      List<ProviderDataset> providerDataset) {
    return sorting.quicksortForMaxActivityPeriod(providerDataset);
  }

  List<ProviderDataset> mGetMonthlyRating(
      List<ProviderDataset> providerDatasetList) {
    return sorting.quicksortForMaxMonthlyRating(providerDatasetList);
  }

  List<ProviderDataset> mGetOverAllReview(
      List<ProviderDataset> providerDatasetList) {
    return sorting.quicksortForMaxOverallReview(providerDatasetList);
  }

  List<ProviderDataset> mGetOverallRating(
      List<ProviderDataset> providerDatasetList) {
    return sorting.quicksortForMaxOverallRating(providerDatasetList);
  }
}
