import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../const/constants.dart';
import '../const/keywords.dart';
import '../models/provider_dataset.dart';

class SignUpViewModel {
  Future<List<ProviderDataset>> mGenerateProviderDataset() async {
    List<ProviderDataset> providerDatasetList = [];
    for (int i = 1; i <= 35; i++) {
      providerDatasetList.add(
        ProviderDataset(
          name: "Provider ${i.toString().padLeft(3, '0')}",
          category: _mGetRandCategory(),
          imgUri: await _mGetRandImageUri(),
          // imgUri: null,
          rating: _mGetRandRating(),
          monthlyRating: _mGetRandMonthlyRating(),
          numOfReview: _mGenerateRandomNum(max: 150, min: 1),
          serviceFee: _mGenerateRandomNum(min: 250, max: 350),
          location: _mGetRandPlaceName(),
          lat: _mGetRandomLatLong(min: 22.4787345, max: 22.4797345),
          long: _mGetRandomLatLong(min: 91.7942796, max: 91.7972796),
          phone: "+8801${_mGenerateRandomNum(min: 712345678, max: 99999999)}",
          jobs: _mGetRandJobs(),
          activePeriod: _mGenerateRandomNum(min: 0, max: 1000),
          liveDistance: null,
        ),
      );
    }

    // c: Convert the object data list to json data list
    var jsonResult = List.generate(providerDatasetList.length,
        (index) => providerDatasetList[index].toJson());
    print("DataType of result is : ${jsonResult.runtimeType}");
    print("Results: $jsonResult");


    // c: Save this List of map to a json file
    _mSaveGeneratedDataset(jsonResult);

    return providerDatasetList;
  }

  void _mSaveGeneratedDataset(List<Map<String, dynamic>> jsonResult) {
    // c: create a json file
    File outputFile = File('output.json');

    //c: Open the empty file for writing
    var sink = outputFile.openWrite();

    //c: Write the JSON data to the file
    sink.write(jsonEncode(jsonResult));

    //c: Close the file
    sink.close();

    print("Data has been saved to 'output.json'");
  }

  String _mGetRandCategory() {
    int randIndex =
        _mGenerateRandomNum(min: 0, max: serviceCategoryList.length);
    String name = serviceCategoryList[randIndex].name ?? electronics;
    return name;
  }

  Future<int> _mGenerateRandIndex(int maxIndex) async {
    await Future.delayed(const Duration(milliseconds: 1));

    int index = DateTime.now().millisecondsSinceEpoch % maxIndex;
    return index;
  }

  Future<String> _mGetRandImageUri() async {
    String url = "https://randomuser.me/api/?inc=picture";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody['results'][0]['picture']['large'];
    } else {
      throw Exception("Failed to fetch image data");
    }
  }

  double _mGetRandRating() {
    return ratingsList[_mGenerateRandomNum(min: 0, max: ratingsList.length)];
  }

  double _mGetRandMonthlyRating() {
    return double.parse(
        (Random().nextDouble() * (5 - 3) + 3).toStringAsFixed(1));
  }

  double _mGetRandomLatLong({required double min, required double max}) {
    return (Random().nextDouble() * (max - min) + min);
  }

  int _mGenerateRandomNum({required int min, required int max}) {
    return Random().nextInt(max) + min;
  }

  List<Jobs> _mGetRandJobs() {
    int randLength = _mGenerateRandomNum(min: 1, max: 50);
    List<Jobs> jobs = [];
    for (var i = 0; i < randLength; i++) {
      jobs.add(Jobs(
        consumerName:
            "Consumer ${_mGenerateRandomNum(min: 0, max: randLength).toString().padLeft(3, "0")}",
        workingHour: _mGenerateRandomNum(min: 1, max: 5),
      ));
    }
    return jobs;
  }

  String _mGetRandPlaceName() {
    return placeNameList[
        _mGenerateRandomNum(min: 0, max: placeNameList.length)];
  }
}
