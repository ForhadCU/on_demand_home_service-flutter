// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';
import 'package:lottie/lottie.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/models/current_location_details.dart';
import 'package:thesis_project/models/provider_dataset.dart';
import 'package:thesis_project/utils/custom_text.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/my_screensize.dart';
import 'package:thesis_project/views/screens/home/home.dart';

import '../../../const/keywords.dart';
import '../../../models/auto_complete_result.dart';
import '../../../repository/repo_map_services.dart';
import '../../../repository/repo_search_places.dart';
import '../../../view_models/vm_set_location.dart';

class SetLocationScreen extends ConsumerStatefulWidget {
  final String userName;
  final List<ProviderDataset> providerDatasetList;
  const SetLocationScreen({required this.providerDatasetList, required this.userName, super.key});

  @override
  _SetLocationScreenState createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends ConsumerState<SetLocationScreen> {
  bool searchToggle = false;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  final SetLocationViewModel _setLocationViewModel = SetLocationViewModel();

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Providers
    final placeResults = ref.watch(placeResultsProvider);
    final searchFlag = ref.watch(searchToggleProvider);

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.caribbeanGreenTint7,
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _vHeaderText(),
            SizedBox(
              height: 50,
            ),
            _vSetLocation(searchFlag, placeResults),
            // _vBgImage(),
            // _vSubmitBtn(),
          ],
        ),
      ),
    ));
  }

  _vHeaderText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NeumorphicText(
              "Please Set Your",
              style: NeumorphicStyle(
                  depth: 1,
                  // shadowDarkColor: MyColors.spaceCadetShadow1,
                  color: MyColors.spaceCadetTint2),
              textStyle: NeumorphicTextStyle(
                  fontFamily: fontOswald,
                  fontSize: 46,
                  fontWeight: FontWeight.bold),
            ),
            NeumorphicText(
              "Location",
              style: NeumorphicStyle(
                  depth: 1,
                  // shadowDarkColor: MyColors.spaceCadetShadow1,
                  color: MyColors.spaceCadetTint2),
              textStyle: NeumorphicTextStyle(
                  fontSize: 46,
                  fontFamily: fontOswald,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ],
    );
  }

/*   _vSetLocation(SearchToggle searchFlag, PlaceResults placeResults) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _vSearchBar(searchFlag, placeResults),
      SizedBox(
        height: 12,
      ),
      Divider(
        color: Colors.black12,
      ),
      SizedBox(
        height: 8,
      ),
      _vBtns(),
      SizedBox(
        height: 8,
      ),
      Divider(
        color: Colors.black12,
      ),
      SizedBox(
        height: 8,
      ),
      _vListPlaceResult(),
    ]);
  }  */
  _vSetLocation(SearchToggle searchFlag, PlaceResults placeResults) {
    return Expanded(
      child: Stack(children: [
        _bgImage(),
        _vSearchBar(searchFlag, placeResults),
        _vBtns(),
        _vSearchResults(searchFlag, placeResults),
        /*  SizedBox(
          height: 12,
        ),
        Divider(
          color: Colors.black12,
        ),
        SizedBox(
          height: 8,
        ),
        _vBtns(),
        SizedBox(
          height: 8,
        ),
        Divider(
          color: Colors.black12,
        ),
        SizedBox(
          height: 8,
        ),
        _vListPlaceResult(), */
      ]),
    );
  }

  _vBgImage() {
    return Container();
  }

  _vSubmitBtn() {
    return Container();
  }

  _vSearchBar(SearchToggle searchFlag, PlaceResults placeResults) {
    return Row(
      children: [
        Expanded(
          child: Neumorphic(
            // padding: EdgeInsets.all(8),
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
              depth: -4,
              intensity: 0.8,
              // color: MyColors.caribbeanGreenTint7,
              color: Colors.white,
            ),
            child: TextFormField(
              controller: searchController,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: MyColors.vividCerulean,
              style: TextStyle(color: MyColors.vividCerulean),
              decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.pin_drop, color: Colors.grey, size: 24,),
                  hintText: 'Search your location',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          searchToggle = false;

                          searchController.text = '';
                          // _markers = {};
                          if (searchFlag.searchToggle) {
                            searchFlag.toggleSearch();
                          }
                        });
                      },
                      icon: Icon(Icons.close))),
              onChanged: (value) {
                logger.w(_debounce?.isActive ?? false);
                if (_debounce?.isActive ?? false) {
                  _debounce?.cancel();
                }
                _debounce = Timer(Duration(milliseconds: 700), () async {
                  if (value.length > 2) {
                    if (!searchFlag.searchToggle) {
                      searchFlag.toggleSearch();
                      // _markers = {};
                    }

                    List<AutoCompleteResult> searchResults =
                        await MapServices().searchPlacesByName(value);

                    placeResults.setResults(searchResults);
                  } else {
                    List<AutoCompleteResult> emptyList = [];
                    placeResults.setResults(emptyList);
                  }
                });
              },
            ),
          ),
        ),
        /* SizedBox(
          width: 66,
        ), */
        /* Expanded(
          child: Neumorphic(
            padding: EdgeInsets.all(14),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              shape: NeumorphicShape.concave,
            ),
            child: NeumorphicIcon(
              Icons.search,
              size: 24,
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                color: MyColors.vividCerulean,
              ),
            ),
          ),
        ) */
      ],
    );
  }

  _vBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        !_isLoading
            ? NeumorphicButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  CurrentLocationDetails? currentLocationDetails =
                      await _setLocationViewModel
                          .mManageLocAccessAndFetchCurrentPos();
                  if (currentLocationDetails != null) {
                    logger.d(currentLocationDetails.formattedAdress);
                    _mGotoHome(currentLocationDetails);
                  } else {
                    logger.d("null");
                  }
                },
                margin: EdgeInsets.only(top: 56),
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 12,
                ),
                style: NeumorphicStyle(color: MyColors.vividCerulean, depth: 1),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.my_location,
                      size: 18,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Use My Current Location",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              )
            : GFLoader(
                type: GFLoaderType.ios,
                size: 24,
              ),
      ],
    );
  }

  _vListPlaceResult() {
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _vItemPlaceName(index);
        });
  }

  _vItemPlaceName(int index) {
    return InkWell(
      onTap: () {
        // _mAction();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.symmetric(vertical: 8),
            child: CustomText(
              text: "Place name $index",
              fontsize: 16,
              fontWeight: FontWeight.w400,
              fontcolor: MyColors.spaceCadetTint2,
            ),
          ),
          Divider(
            color: Colors.black12,
          )
        ],
      ),
    );
  }

/*   void _mAction() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  } */

  _vSearchResults(SearchToggle searchFlag, PlaceResults placeResults) {
    return searchFlag.searchToggle
        ? placeResults.allReturnedResults.isNotEmpty
            ? Positioned(
                top: 49.0,
                /* left: 15.0,
                right: 15, */
                child: Container(
                  height: 200.0,
                  // width: screenWidth - 30.0,
                  width: MyScreenSize.mGetWidth(context, 94),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: ListView(
                    children: [
                      ...placeResults.allReturnedResults
                          .map((e) => buildListItem(e, searchFlag))
                    ],
                  ),
                ))
            : Positioned(
                top: 49.0,
                /*   left: 15.0,
                right: 15, */

                child: Container(
                  height: 200.0,
                  // width: screenWidth - 30.0,
                  width: MyScreenSize.mGetWidth(context, 94),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.7),
                  ),
                  child: Center(
                    child: Column(children: [
                      Text('No results to show',
                          style: TextStyle(
                              fontFamily: 'WorkSans',
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 5.0),
                      Container(
                        width: 125.0,
                        child: ElevatedButton(
                          onPressed: () {
                            searchFlag.toggleSearch();
                          },
                          child: Center(
                            child: Text(
                              'Close this',
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      )
                    ]),
                  ),
                ))
        : Container();
  }

  Widget buildListItem(AutoCompleteResult placeItem, SearchToggle searchFlag) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTapDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () async {
          // logger.d("Place desc: ${placeItem}");
          var place = await MapServices().getPlaceById(placeItem.placeId);
          logger.i(
              "Lat: ${place['geometry']['location']['lat']}, Long:${place['geometry']['location']['lng']}");
          /* gotoSearchedPlace(place['geometry']['location']['lat'],
              place['geometry']['location']['lng']); */
          CurrentLocationDetails currentLocationDetails =
              CurrentLocationDetails(
                  formattedAdress: placeItem.description,
                  lat: place['geometry']['location']['lat'],
                  long: place['geometry']['location']['lng']);
          searchFlag.toggleSearch();
          _mGotoHome(currentLocationDetails);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.green, size: 25.0),
            SizedBox(width: 4.0),
            Container(
              height: 40.0,
              // width: MediaQuery.of(context).size.width - 75.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(placeItem.description ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _mGotoHome(CurrentLocationDetails currentLocationDetails) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(
          currentLocationDetails: currentLocationDetails,
          providerDatasetList: widget.providerDatasetList);
    }));
  }

  _bgImage() {
    return Positioned(
      bottom: MyScreenSize.mGetHeight(context, 10),
      child: Container(
          height: MyScreenSize.mGetHeight(context, 40),
          width: MyScreenSize.mGetWidth(context, 100),
          // child: Image(image: AssetImage("")),
          child: Lottie.asset("assets/animassets/map_1.json")),
    );
  }
}
