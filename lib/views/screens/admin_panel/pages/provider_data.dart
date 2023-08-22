// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/const/keywords.dart';

import '../../../../models/provider_dataset.dart';
import '../../../../utils/my_colors.dart';
import '../../../../utils/my_screensize.dart';
import '../../../../view_models/vm_provider_data.dart';

class ProviderDataPage extends StatefulWidget {
  final List<ProviderDataset> providerDatasetList;
  const ProviderDataPage({super.key, required this.providerDatasetList});

  @override
  State<ProviderDataPage> createState() => _ProviderDataPageState();
}

class _ProviderDataPageState extends State<ProviderDataPage> {
  late String _selectedRadioBtnValue;
  String r1 = "Activity Period";
  String r2 = "Monthly Rating";
  String r3 = "Overall Rating";
  String r4 = "Overall Review";

  bool _isGettingResults = false;
  ProviderDataViewModel _providerDataViewModel = ProviderDataViewModel();

  late List<ProviderDataset> _providerDatasetList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedRadioBtnValue = r1;

    _mHandleChangedValue(_selectedRadioBtnValue);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 24, right: 12, left: 18, bottom: 12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _vDataCategory(),
            SizedBox(
              height: 24,
            ),
            _vShowResult(),
          ]),
        ),
      ),
    );
  }

  _vShowResult() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        width: MyScreenSize.mGetWidth(context, 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(children: [
          // v: heading
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: MyScreenSize.mGetWidth(context, 1),
                      height: MyScreenSize.mGetHeight(context, 3),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      _selectedRadioBtnValue,
                      style: TextStyle(
                          color: MyColors.spaceCadet,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: fontOswald),
                    ),
                    /* SizedBox(
                      width: 12,
                    ),
                    Image(
                      image: AssetImage("assets/images/ic_edit.png"),
                      color: Colors.black26,
                      width: 18,
                      height: 18,
                    ), */
                  ],
                ),
              ),
              /*  Expanded(
                child: InkWell(
                  onTap: () {
                    // _mOnClickAction();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border.all(
                                color: MyColors.caribbeanGreenTint7)),
                        child: Text(
                          _filterName,
                          style: TextStyle(
                              color: Color.fromARGB(255, 59, 10, 194),
                              fontWeight: FontWeight.normal,
                              fontFamily: fontOswald),
                        ),
                      ),
                      Neumorphic(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.all(4),
                        style: NeumorphicStyle(
                          color: Colors.white,
                          border: NeumorphicBorder(
                              color: MyColors.caribbeanGreenTint7),
                        ),
                        child: Lottie.asset(
                          "assets/animassets/filter.json",
                          width: 24,
                          height: 24,
                        ),
                      )
                    ],
                  ),
                ),
              ), */
            ],
          ),
          SizedBox(
            height: 8,
          ),
          // v: Filtering Matrix
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // v: distance
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.keyboard_double_arrow_down,
                    color: Colors.redAccent,
                    size: 14,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "Distance",
                    style: TextStyle(
                      color: MyColors.spaceCadetTint5,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                ],
              ),
              Visibility(
                visible: _selectedRadioBtnValue == "1" ? true : false,
                child: Row(
                  children: [
                    // v: Ratings
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MyScreenSize.mGetWidth(context, .5),
                          height: MyScreenSize.mGetHeight(context, 1.8),
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_double_arrow_up,
                          color: Colors.greenAccent,
                          size: 14,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Ratings",
                          style: TextStyle(
                            color: MyColors.spaceCadetTint5,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          width: MyScreenSize.mGetWidth(context, .5),
                          height: MyScreenSize.mGetHeight(context, 1.8),
                          margin: EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.keyboard_double_arrow_down,
                          color: Colors.redAccent,
                          size: 14,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Service Fee",
                          style: TextStyle(
                            color: MyColors.spaceCadetTint5,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        /*  Container(
                            width: MyScreenSize.mGetWidth(context, .5),
                            height: MyScreenSize.mGetHeight(context, 1.8),
                            margin: EdgeInsets.only(right: 2),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ), */
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ), */
          Divider(
            color: Colors.black12,
            height: 20,
          ),
          // v: List
          !_isGettingResults
              ? Expanded(
                  child: ListView.builder(
                      itemCount: _providerDatasetList!.length,
                      // itemCount: 10,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _vItemProvider(_providerDatasetList![index]);
                      }),
                )
              : Expanded(
                  child: Center(
                    child: GFLoader(
                      type: GFLoaderType.ios,
                      size: 28,
                    ),
                  ),
                )
        ]),
      ),
    );
  }

  _vDataCategory() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicRadio<String>(
              padding: EdgeInsets.all(14),
              style: NeumorphicRadioStyle(
                shape: NeumorphicShape.convex,
                intensity: 0.8,
                boxShape: NeumorphicBoxShape.circle(),
                unselectedDepth: 4,
                selectedDepth: 8,
                selectedColor: MyColors.caribbeanGreenTint4,
                unselectedColor: Colors.black12,
                border: NeumorphicBorder(
                    isEnabled: _selectedRadioBtnValue == r1 ? true : false,
                    color: MyColors.caribbeanGreenTint1,
                    width: 1),
              ),
              groupValue: _selectedRadioBtnValue,
              value: r1,
              onChanged: (value) {
                _mHandleChangedValue(value!);
              },
              // child: Text('Consumer'),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              r1,
              style: TextStyle(
                color: _selectedRadioBtnValue == r1
                    ? MyColors.vividCerulean
                    : Colors.grey,
                fontSize: 16,
                fontWeight: _selectedRadioBtnValue == r1
                    ? FontWeight.w500
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicRadio<String>(
              padding: EdgeInsets.all(14),
              style: NeumorphicRadioStyle(
                shape: NeumorphicShape.convex,
                selectedColor: MyColors.caribbeanGreenTint4,
                unselectedColor: Colors.black12,
                border: NeumorphicBorder(
                    isEnabled: _selectedRadioBtnValue == r2 ? true : false,
                    color: MyColors.caribbeanGreenTint1,
                    width: 1),
                boxShape: NeumorphicBoxShape.circle(),
                unselectedDepth: 4,
                selectedDepth: 8,
                intensity: 0.8,
              ),
              groupValue: _selectedRadioBtnValue,
              value: r2,
              onChanged: (value) {
                _mHandleChangedValue(value!);
              },
              // child: Text('Consumer'),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              r2,
              style: TextStyle(
                color: _selectedRadioBtnValue == r2
                    ? MyColors.vividCerulean
                    : Colors.grey,
                fontSize: 16,
                fontWeight: _selectedRadioBtnValue == r2
                    ? FontWeight.w500
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicRadio<String>(
              padding: EdgeInsets.all(14),
              style: NeumorphicRadioStyle(
                shape: NeumorphicShape.convex,
                selectedColor: MyColors.caribbeanGreenTint4,
                unselectedColor: Colors.black12,
                border: NeumorphicBorder(
                    isEnabled: _selectedRadioBtnValue == r4 ? true : false,
                    color: MyColors.caribbeanGreenTint1,
                    width: 1),
                boxShape: NeumorphicBoxShape.circle(),
                unselectedDepth: 4,
                selectedDepth: 8,
                intensity: 0.8,
              ),
              groupValue: _selectedRadioBtnValue,
              value: r4,
              onChanged: (value) {
                _mHandleChangedValue(value!);
              },
              // child: Text('Consumer'),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              r4,
              style: TextStyle(
                color: _selectedRadioBtnValue == r4
                    ? MyColors.vividCerulean
                    : Colors.grey,
                fontSize: 16,
                fontWeight: _selectedRadioBtnValue == r4
                    ? FontWeight.w500
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicRadio<String>(
              padding: EdgeInsets.all(14),
              style: NeumorphicRadioStyle(
                shape: NeumorphicShape.convex,
                selectedColor: MyColors.caribbeanGreenTint4,
                unselectedColor: Colors.black12,
                border: NeumorphicBorder(
                    isEnabled: _selectedRadioBtnValue == r3 ? true : false,
                    color: MyColors.caribbeanGreenTint1,
                    width: 1),
                boxShape: NeumorphicBoxShape.circle(),
                unselectedDepth: 4,
                selectedDepth: 8,
                intensity: 0.8,
              ),
              groupValue: _selectedRadioBtnValue,
              value: r3,
              onChanged: (value) {
                _mHandleChangedValue(value!);
              },
              // child: Text('Consumer'),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              r3,
              style: TextStyle(
                color: _selectedRadioBtnValue == r3
                    ? MyColors.vividCerulean
                    : Colors.grey,
                fontSize: 16,
                fontWeight: _selectedRadioBtnValue == r3
                    ? FontWeight.w500
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  _mHandleChangedValue(String value) async {
    logger.w(value);
    setState(() {
      _isGettingResults = true;
      print("object");
      _selectedRadioBtnValue = value;
      // _filterName = value == r1 ? "Default Filter" : "Advanced Filter";
      // _mLoad();
    });
    await Future.delayed(Duration(milliseconds: 1000));
    // _providerDatasetList.clear();

    if (_selectedRadioBtnValue == r1) {
      
      _providerDatasetList =
          _providerDataViewModel.mGetActivityPeriod(widget.providerDatasetList);
    } else if (_selectedRadioBtnValue == r2) {
      _providerDatasetList.clear();

      _providerDatasetList =
          _providerDataViewModel.mGetMonthlyRating(widget.providerDatasetList);
    } else if (_selectedRadioBtnValue == r3) {
      _providerDatasetList.clear();

      _providerDatasetList =
          _providerDataViewModel.mGetMonthlyRating(widget.providerDatasetList);
    } else if (_selectedRadioBtnValue == r4) {
      _providerDatasetList.clear();

      _providerDatasetList =
          _providerDataViewModel.mGetOverAllReview(widget.providerDatasetList);
    }

    setState(() {
      _isGettingResults = false;
    });
  }

  _vItemProvider(ProviderDataset providerList) {
    return InkWell(
      onTap: () {
        // _mAction(providerList);
      },
      focusColor: MyColors.caribbeanGreenTint7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // v: main
          Row(
            children: [
              // v: img
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: MyColors.caribbeanGreenTint7,
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.4),
                          offset: Offset(0.5, .5),
                          blurRadius: 1)
                    ]),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(providerList.imgUri!),
                  // backgroundImage: AssetImage("assets/images/provider3.jpeg"),
                  radius: 32,
                ),
              ),
              SizedBox(
                width: 18,
              ),
              // v: details
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // v: name
                  Text(
                    providerList.name!,
                    style: TextStyle(
                      fontSize: 18,
                      color: MyColors.spaceCadet,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // v: address
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 12,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        providerList.location!,
                        style: TextStyle(
                          color: MyColors.spaceCadetTint1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // v: rating and review
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        providerList.rating.toString(),
                        style: TextStyle(
                          color: MyColors.spaceCadet,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "(${providerList.numOfReview.toString()})",
                        style: TextStyle(
                          color: MyColors.spaceCadetTint1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  // v: Nearby Distance
                  /*  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.near_me,
                        size: 12,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${providerList.liveDistance!.toStringAsFixed(2)} km",
                        style: TextStyle(
                          color: MyColors.spaceCadet,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ), */

                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: MyColors.caribbeanGreen.withOpacity(.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Activity Period   : "),
                        Text(
                          " " + providerList.activePeriod.toString(),
                          style: TextStyle(
                            color: MyColors.spaceCadet,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " hour",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: MyColors.caribbeanGreen.withOpacity(.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Overall Reviews : "),
                        Text(
                          " " + providerList.numOfReview.toString(),
                          style: TextStyle(
                            color: MyColors.spaceCadet,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: MyColors.caribbeanGreen.withOpacity(.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Monthly Rating  : "),
                        Text(
                          " " + providerList.monthlyRating.toString(),
                          style: TextStyle(
                            color: MyColors.spaceCadet,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: MyColors.caribbeanGreen.withOpacity(.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Service Fee        : "),
                        Text(
                          " " + providerList.serviceFee.toString(),
                          style: TextStyle(
                            color: MyColors.spaceCadet,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " Tk/hour",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              /* SizedBox(width: 16,)
              ,
              Expanded(
                child: Row(mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_forward_ios, color: Colors.black26, size: 44 , weight: .5,),
                  ],
                ),
              ) */
            ],
          ),
          // v: underline
          Divider(
            color: Colors.black12,
            height: 32,
          )
        ],
      ),
    );
  }
}
