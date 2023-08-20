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
   */}
}
