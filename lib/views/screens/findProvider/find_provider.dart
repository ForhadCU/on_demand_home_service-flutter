// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/my_screensize.dart';
import 'package:thesis_project/view_models/vm_search_provider.dart';
import 'package:thesis_project/views/screens/map/map.dart';

import '../../../models/current_location_details.dart';

class FindProviderScreen extends StatefulWidget {
  final CurrentLocationDetails currentLocationDetails;
  final String serviceCategory;
  final int searchRange;

  const FindProviderScreen(
      {super.key,
      required this.currentLocationDetails,
      required this.serviceCategory,
      required this.searchRange});

  @override
  State<FindProviderScreen> createState() => _FindProviderScreenState();
}

class _FindProviderScreenState extends State<FindProviderScreen> {
  late TextEditingController _editCtrlerSearchbar;

  late int _searchRange;

  late String _myLocation;
  final SearchProviderViewModel _searchProviderViewModel =
      SearchProviderViewModel();
  late bool _isGettingResults;

  List<ServiceProvider>? _providerList;

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
        _mOnClikSearchBar();
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
            suffixIcon: _vFilterIcon(),
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

  void _mOnClikSearchBar() {
    logger.w("Clicked search");
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
              Expanded(flex: 6, child: Text("$_myLocation")),
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
              Expanded(flex: 6, child: Text("$_searchRange km")),
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
                  _mGotoMap();
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
          SizedBox(
            height: 20,
          ),
          // v: List
          !_isGettingResults
              ? Expanded(
                  child: ListView.builder(
                      // itemCount: _providerList!.length,
                      itemCount: 10,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _vItemProvider(_providerList![0]);
                      }),
                )
              : CircularProgressIndicator(
                  color: Colors.black26,
                )
        ]),
      ),
    );
  }

  _vItemProvider(ServiceProvider providerList) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 8),
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
                  backgroundImage: AssetImage(providerList.imgUri!),
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
                        width: 2,
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
                        width: 2,
                      ),
                      Text(
                        providerList.rating.toString(),
                        style: TextStyle(
                          color: MyColors.spaceCadet,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 2,
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                        color: MyColors.caribbeanGreen.withOpacity(.3),
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
    _searchRange = 5;
    _myLocation = "Fateyabad, Hathazari Road, Chittagong";
    _isGettingResults = true;
  }

  void _mLoad() async {
    await _searchProviderViewModel
        .mGetProviderList(
      /*   myLatitude: widget.myLatitude,
      myLongitude: widget.myLongitude,
      category: widget.category,
      searchRange: widget.searchRange, */
      myLatitude: 0.00,
      myLongitude: 0,
      category: acRepair,
      searchRange: 5,
    )
        .then((value) {
      _providerList = value;
      setState(() {
        _isGettingResults = false;
      });
    });
  }

  void _mGotoMap() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MapScreen();
    }));
  }
}
