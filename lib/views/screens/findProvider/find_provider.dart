// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider.dart';
import 'package:thesis_project/models/provider_dataset.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/my_screensize.dart';
import 'package:thesis_project/view_models/vm_find_provider.dart';
import 'package:thesis_project/views/screens/map/map.dart';
import 'package:thesis_project/views/screens/profile/scr_provider_profile.dart';

import '../../../models/current_location_details.dart';

class FindProviderScreen extends StatefulWidget {
  final CurrentLocationDetails currentLocationDetails;
  final String serviceCategory;
  final int searchRange;
  final List<ProviderDataset> providerDatasetList;

  const FindProviderScreen(
      {super.key,
      required this.currentLocationDetails,
      required this.serviceCategory,
      required this.searchRange,
      required this.providerDatasetList});

  @override
  State<FindProviderScreen> createState() => _FindProviderScreenState();
}

class _FindProviderScreenState extends State<FindProviderScreen> {
  late TextEditingController _editCtrlerSearchbar;

  late double _searchRange;

  late String _myLocation;
  final FindProviderViewModel _findProviderViewModel = FindProviderViewModel();
  late bool _isGettingResults;

  List<ProviderDataset>? _providerDatasetList;

  var _selectedRadioBtnValue = "0";

  bool _isDefaultFilter = true;

  String _filterName = "Default Filter";
  double _initialSearchingRange = 5; //in killometters

  List<ProviderDataset>? _availableProvidersIntoRange;
  List<ProviderDataset>? _sortedProvidersForMinDistance;

  String? _serviceCategory;

  @override
  void initState() {
    super.initState();
    _mInit();
    _mLoad();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: MyColors.caribbeanGreenTint7,
      body: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _vSearchBar(),
            SizedBox(
              height: 24,
            ),
            _vInputOverview(),
            SizedBox(
              height: 24,
            ),
            _vSearchResults(),
          ],
        ),
      ),
    ));
  }

  _vSearchBar() {
    return InkWell(
      onTap: () {
        // _mOnClikSearchBar(context);
      },
      child: Container(
        padding: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          style: TextStyle(
              color: MyColors.spaceCadetTint3, fontWeight: FontWeight.w500),
          textAlignVertical: TextAlignVertical.center,
          controller: _editCtrlerSearchbar,
          enabled: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            // contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            prefixIcon: Icon(Icons.arrow_back),
            // suffixIcon: _vFilterIcon(),
            /* suffixIcon: Lottie.asset(
              "assets/animassets/filter.json",
              width: 24,
              height: 24,
            ), */
          ),
        ),
      ),
    );
  }

  _vFilterIcon() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image(
        image: AssetImage("assets/images/ic_filter.png"),
        color: MyColors.vividCerulean,
        fit: BoxFit.fill,
        width: 14,
        height: 14,
      ),
    );
  }

  void _mOnClikSearchBar(BuildContext context) {
    logger.w("Clicked search");
    AwesomeDialog(
            context: context,
            customHeader: Lottie.asset("assets/animassets/filter.json"))
        .show();
  }

  _vInputOverview() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // v: my location
          Row(
            children: [
              Icon(
                Icons.my_location,
                // color: Colors.black45,
                color: MyColors.vividmalachite,

                size: 18,
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                    "My Location",
                    style: TextStyle(
                        color: MyColors.spaceCadetTint1,
                        fontWeight: FontWeight.w500),
                  )),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(":",
                      style: TextStyle(
                          color: MyColors.spaceCadetTint1,
                          fontWeight: FontWeight.w500)),
                ],
              )),
              Expanded(
                flex: 6,
                child: Text(
                  _myLocation,
                  style: TextStyle(
                      color: MyColors.caribbeanGreenShades1,
                      fontFamily: fontOswald),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          // v: range
          Row(
            children: [
              Icon(
                Icons.near_me,
                // color: Colors.black45,
                color: MyColors.vividCerulean,

                size: 18,
              ),
              SizedBox(
                width: 6,
              ),
              Expanded(
                  flex: 2,
                  child: Text("Near by",
                      style: TextStyle(
                          color: MyColors.spaceCadetTint1,
                          fontWeight: FontWeight.w500))),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(":",
                      style: TextStyle(
                          color: MyColors.spaceCadetTint1,
                          fontWeight: FontWeight.w500)),
                ],
              )),
              Expanded(
                  flex: 6,
                  child: Text("$_searchRange km",
                      style: TextStyle(
                          color: MyColors.caribbeanGreen,
                          fontFamily: fontOswald))),
            ],
          ),
          /*  SizedBox(
            height: 8,
          ), */
          Divider(
            height: 24,
            color: Colors.black12,
          ),
          // v: view on map btn
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeumorphicButton(
                onPressed: () {
                  _providerDatasetList != null
                      ? _mGotoMap(_providerDatasetList!)
                      : {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("No data to show on map!")))
                        };
                },
                style: NeumorphicStyle(
                    border: NeumorphicBorder(color: Colors.black26),
                    color: MyColors.caribbeanGreenTint7,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(24))),
                padding: EdgeInsets.symmetric(
                  horizontal: 66,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      size: 24,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "View on Map",
                      style: TextStyle(
                        color: MyColors.vividCerulean,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _vSearchResults() {
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
                      widget.serviceCategory,
                      style: TextStyle(
                          color: MyColors.spaceCadet,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: fontOswald),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _mOnClickAction();
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
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          // v: Filtering Matrix
          Row(
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
          ),
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

  _vItemProvider(ProviderDataset providerList) {
    return InkWell(
      onTap: () {
        _mAction(providerList);
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
                  Row(
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
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: MyColors.caribbeanGreen.withOpacity(.2),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Service Fee : "),
                        Text(
                          providerList.serviceFee.toString(),
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

  void _mInit() {
    _editCtrlerSearchbar = TextEditingController(text: widget.serviceCategory);
    _searchRange = _initialSearchingRange;
    _myLocation = widget.currentLocationDetails.formattedAdress!;
    _isGettingResults = true;
    _serviceCategory = widget.serviceCategory;
  }

  void _mLoad() async {
    _availableProvidersIntoRange =
        await _findProviderViewModel.mGetAvailableProvidersIntoRange(
      providerDataset: widget.providerDatasetList,
      range: _searchRange,
      consumerLat: widget.currentLocationDetails.lat!,
      consumerLong: widget.currentLocationDetails.long!,
      serviceCategory: widget.serviceCategory,
    );
    _sortedProvidersForMinDistance = _findProviderViewModel
        .mSortProvidersForMinDistance(_availableProvidersIntoRange!);

    if (_isDefaultFilter) {
      // c: if default distance based filterring, then its enough.
      _providerDatasetList = _sortedProvidersForMinDistance;
      logger.w("Default Filter");
    } else {
      // c: but if Multi object Linear filttering
      _providerDatasetList = _findProviderViewModel
          .mSortProviderForMaxRating(_availableProvidersIntoRange!);
      logger.w("Advanced Filter");
    }

    setState(() {
      _isGettingResults = false;
    });
  }

  void _mGotoMap(List<ProviderDataset> providerDatasetList) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MapScreen(
        providerDataSetList: providerDatasetList,
        currentLocationDetails: widget.currentLocationDetails,
        serviceCategory: _serviceCategory!,
        searchRange: _searchRange,
      );
    }));
  }

  void _mOnClickAction() {
    AwesomeDialog(
        context: context,
        customHeader: Neumorphic(
          padding: EdgeInsets.all(8),
          style: NeumorphicStyle(
              color: Colors.white,
              shape: NeumorphicShape.convex,
              border: NeumorphicBorder(
                width: 1,
                color: MyColors.caribbeanGreenTint5,
              )),
          child: Lottie.asset(
            "assets/animassets/filter.json",
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Text(
              "Choose Filter Type",
              style: TextStyle(
                color: Color.fromARGB(255, 59, 10, 194).withOpacity(.5),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(
              color: Colors.black12,
              height: 12,
            ),
            Container(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NeumorphicRadio<String>(
                        padding: EdgeInsets.all(16),
                        style: NeumorphicRadioStyle(
                          shape: NeumorphicShape.convex,
                          intensity: 0.8,
                          boxShape: NeumorphicBoxShape.circle(),
                          unselectedDepth: 4,
                          selectedDepth: 8,
                          selectedColor: MyColors.caribbeanGreenTint4,
                          unselectedColor: Colors.black12,
                          border: NeumorphicBorder(
                              isEnabled:
                                  _selectedRadioBtnValue == '0' ? true : false,
                              color: MyColors.caribbeanGreenTint1,
                              width: 1),
                        ),
                        groupValue: _selectedRadioBtnValue,
                        value: '0',
                        onChanged: (value) {
                          _mHandleChangedValue(value!);
                        },
                        // child: Text('Consumer'),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Default",
                        style: TextStyle(
                          color: _selectedRadioBtnValue == "0"
                              ? MyColors.vividCerulean
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: _selectedRadioBtnValue == '0'
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      NeumorphicRadio<String>(
                        padding: EdgeInsets.all(16),
                        style: NeumorphicRadioStyle(
                          shape: NeumorphicShape.convex,
                          selectedColor: MyColors.caribbeanGreenTint4,
                          unselectedColor: Colors.black12,
                          border: NeumorphicBorder(
                              isEnabled:
                                  _selectedRadioBtnValue == '1' ? true : false,
                              color: MyColors.caribbeanGreenTint1,
                              width: 1),
                          boxShape: NeumorphicBoxShape.circle(),
                          unselectedDepth: 4,
                          selectedDepth: 8,
                          intensity: 0.8,
                        ),
                        groupValue: _selectedRadioBtnValue,
                        value: '1',
                        onChanged: (value) {
                          _mHandleChangedValue(value!);
                        },
                        // child: Text('Consumer'),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Advanced",
                        style: TextStyle(
                          color: _selectedRadioBtnValue == "1"
                              ? MyColors.vividCerulean
                              : Colors.grey,
                          fontSize: 16,
                          fontWeight: _selectedRadioBtnValue == '1'
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )).show();
  }

  _mHandleChangedValue(String value) {
    Navigator.pop(context);
    setState(() {
      _isGettingResults = true;

      _selectedRadioBtnValue = value;
      _filterName = value == "0" ? "Default Filter" : "Advanced Filter";
      _isDefaultFilter = value == "0" ? true : false;
      logger.d("Seleted: $_selectedRadioBtnValue");
      _mLoad();
    });
  }

  void _mAction(ProviderDataset providerDataset) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProviderProfileScreen(
        providerDataset: providerDataset,
      );
    }));
  }
}
