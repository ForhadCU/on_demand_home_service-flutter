import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/models/provider_dataset.dart';

class CommonViewmodel {
  Future<List<ProviderDataset>> mGetPorviderDatasetFromJson({
    required BuildContext context,
  }) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/jsondata/provider_dataset.json");
    List<dynamic> jsonResult = jsonDecode(data);

    List<ProviderDataset> providerDatasetList = List.generate(jsonResult.length,
        (index) => ProviderDataset.fromJson(jsonResult[index]));

    // logger.w("Json test: $providerDatasetList");

    return providerDatasetList;
  }

    static void mSetFrucValueAsInt(
      {required double number, required Function callback}) {
    final String actValue = number.toStringAsFixed(1);
    for (var i = 0; i < actValue.length; i++) {
      if (actValue[i] == '.') {
        callback(int.parse(actValue[i + 1]));
      } else {
        continue;
      }
    }
  }
}
