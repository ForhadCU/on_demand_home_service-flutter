import 'package:thesis_project/models/provider_dataset.dart';

class Sorting {
  List<ProviderDataset> quicksortForProviderMinDistance(
      List<ProviderDataset> arr) {
    if (arr.length <= 1) {
      return arr;
    }

    // e: check chat gpt. use Linear Search filterring algorithm

    ProviderDataset pivot = arr[0];
    List<ProviderDataset> left = [];
    List<ProviderDataset> right = [];

    for (int i = 1; i < arr.length; i++) {
      if (arr[i].liveDistance! <= pivot.liveDistance!) {
        left.add(arr[i]);
      } else {
        right.add(arr[i]);
      }
    }

    List<ProviderDataset> sortedLeft = quicksortForProviderMinDistance(left);
    List<ProviderDataset> sortedRight = quicksortForProviderMinDistance(right);

    List<ProviderDataset> sortedArr = [];
    sortedArr.addAll(sortedLeft);
    sortedArr.add(pivot);
    sortedArr.addAll(sortedRight);

    return sortedArr;
  }

  List<ProviderDataset> quicksortForMaxActivityPeriod(
    List<ProviderDataset> arr,
  ) {
    if (arr.length <= 1) {
      return arr;
    }

    // e: check chat gpt. use Linear Search filterring algorithm

    ProviderDataset pivot = arr[0];
    List<ProviderDataset> left = [];
    List<ProviderDataset> right = [];

    for (int i = 1; i < arr.length; i++) {
      if (arr[i].activePeriod! >= pivot.activePeriod!) {
        left.add(arr[i]);
      } else {
        right.add(arr[i]);
      }
    }

    List<ProviderDataset> sortedLeft = quicksortForMaxActivityPeriod(left);
    List<ProviderDataset> sortedRight = quicksortForMaxActivityPeriod(right);

    List<ProviderDataset> sortedArr = [];
    sortedArr.addAll(sortedLeft);
    sortedArr.add(pivot);
    sortedArr.addAll(sortedRight);

    return sortedArr;
  }

  List<ProviderDataset> quicksortForProviderMaxRating(
      List<ProviderDataset> arr) {
    if (arr.length <= 1) {
      return arr;
    }

    // e: check chat gpt. use Linear Search filterring algorithm

    ProviderDataset pivot = arr[0];
    List<ProviderDataset> left = [];
    List<ProviderDataset> right = [];

    for (int i = 1; i < arr.length; i++) {
      if (arr[i].rating! >= pivot.rating!) {
        left.add(arr[i]);
      } else {
        right.add(arr[i]);
      }
    }

    List<ProviderDataset> sortedLeft = quicksortForProviderMaxRating(left);
    List<ProviderDataset> sortedRight = quicksortForProviderMaxRating(right);

    List<ProviderDataset> sortedArr = [];
    sortedArr.addAll(sortedLeft);
    sortedArr.add(pivot);
    sortedArr.addAll(sortedRight);

    return sortedArr;
    /* 
    if (arr.length <= 1) {
      return arr;
    }

    // e: check chat gpt. use Linear Search filterring algorithm

    ProviderDataset pivot = arr[0];
    List<ProviderDataset> left = [];
    List<ProviderDataset> right = [];

    for (int i = 1; i < arr.length; i++) {
      if (arr[i].rating! <= pivot.rating!) {
        left.add(arr[i]);
      } else {
        right.add(arr[i]);
      }
    }

    List<ProviderDataset> sortedLeft = quicksortForProviderMinDistance(left);
    List<ProviderDataset> sortedRight = quicksortForProviderMinDistance(right);

    List<ProviderDataset> sortedArr = [];
    sortedArr.addAll(sortedLeft);
    sortedArr.add(pivot);
    sortedArr.addAll(sortedRight);

    return sortedArr;
   */
  }

  List<ProviderDataset> quicksortForMaxMonthlyRating(
      List<ProviderDataset> providerDatasetList) {
    if (providerDatasetList.length <= 1) {
      return providerDatasetList;
    }

    // e: check chat gpt. use Linear Search filterring algorithm

    ProviderDataset pivot = providerDatasetList[0];
    List<ProviderDataset> left = [];
    List<ProviderDataset> right = [];

    for (int i = 1; i < providerDatasetList.length; i++) {
      if (providerDatasetList[i].monthlyRating! >= pivot.monthlyRating!) {
        left.add(providerDatasetList[i]);
      } else {
        right.add(providerDatasetList[i]);
      }
    }

    List<ProviderDataset> sortedLeft = quicksortForMaxMonthlyRating(left);
    List<ProviderDataset> sortedRight = quicksortForMaxMonthlyRating(right);

    List<ProviderDataset> sortedproviderDatasetList = [];
    sortedproviderDatasetList.addAll(sortedLeft);
    sortedproviderDatasetList.add(pivot);
    sortedproviderDatasetList.addAll(sortedRight);

    return sortedproviderDatasetList;
  }

  List<ProviderDataset> quicksortForMaxOverallReview(
      List<ProviderDataset> providerDatasetList) {
    if (providerDatasetList.length <= 1) {
      return providerDatasetList;
    }

    // e: check chat gpt. use Linear Search filterring algorithm

    ProviderDataset pivot = providerDatasetList[0];
    List<ProviderDataset> left = [];
    List<ProviderDataset> right = [];

    for (int i = 1; i < providerDatasetList.length; i++) {
      if (providerDatasetList[i].numOfReview! >= pivot.numOfReview!) {
        left.add(providerDatasetList[i]);
      } else {
        right.add(providerDatasetList[i]);
      }
    }

    List<ProviderDataset> sortedLeft = quicksortForMaxOverallReview(left);
    List<ProviderDataset> sortedRight = quicksortForMaxOverallReview(right);

    List<ProviderDataset> sortedproviderDatasetList = [];
    sortedproviderDatasetList.addAll(sortedLeft);
    sortedproviderDatasetList.add(pivot);
    sortedproviderDatasetList.addAll(sortedRight);

    return sortedproviderDatasetList;
  }

  List<ProviderDataset> quicksortForMaxOverallRating(
      List<ProviderDataset> providerDatasetList) {
    if (providerDatasetList.length <= 1) {
      return providerDatasetList;
    }

    // e: check chat gpt. use Linear Search filterring algorithm

    ProviderDataset pivot = providerDatasetList[0];
    List<ProviderDataset> left = [];
    List<ProviderDataset> right = [];

    for (int i = 1; i < providerDatasetList.length; i++) {
      if (providerDatasetList[i].rating! >= pivot.rating!) {
        left.add(providerDatasetList[i]);
      } else {
        right.add(providerDatasetList[i]);
      }
    }

    List<ProviderDataset> sortedLeft = quicksortForMaxOverallRating(left);
    List<ProviderDataset> sortedRight = quicksortForMaxOverallRating(right);

    List<ProviderDataset> sortedproviderDatasetList = [];
    sortedproviderDatasetList.addAll(sortedLeft);
    sortedproviderDatasetList.add(pivot);
    sortedproviderDatasetList.addAll(sortedRight);

    return sortedproviderDatasetList;
  }
}
