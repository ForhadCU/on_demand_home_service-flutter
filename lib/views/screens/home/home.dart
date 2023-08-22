// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider.dart';
import 'package:thesis_project/models/provider_dataset.dart';
import 'package:thesis_project/models/servie_category.dart';
import 'package:thesis_project/utils/custom_text.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/my_screensize.dart';
import 'package:thesis_project/utils/statusbar.dart';
import 'package:thesis_project/view_models/vm_bookings.dart';
import 'package:thesis_project/view_models/vm_home.dart';
import 'package:thesis_project/views/bookings/scr.bookings.dart';
import 'package:thesis_project/views/screens/findProvider/find_provider.dart';
import 'package:thesis_project/views/screens/home/widgets/bottom_nav.dart';
import 'package:thesis_project/views/screens/profile/scr_provider_profile.dart';

import '../../../models/booking.dart';
import '../../../models/current_location_details.dart';
import '../../../models/food.dart';
import '../../../utils/my_date_format.dart';

class HomeScreen extends StatefulWidget {
  final CurrentLocationDetails currentLocationDetails;
  final List<ProviderDataset> providerDatasetList;
  final String? provider;
  const HomeScreen(
      {super.key,
      this.provider,
      required this.currentLocationDetails,
      required this.providerDatasetList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = "Mrs. Kaberi Jaman";
  String _userAddress = "Jobra, Chittagong";
  FocusNode? _focusNode;
  final List<Food> _listFood1 = [];
  late String _greeting;
  int _pageIndex = 0;
  Color _fontColor = MyColors.spaceCadet;
  final HomeViewModel _homeViewModel = HomeViewModel();
  late bool _isLocationAccessGranted;
  late CurrentLocationDetails? _currentLocationDetails;

  var _controllerAddress;
  String _selectedCategory = electronics;

  List<ProviderDataset>? _recommendedProviderList;

  @override
  void initState() {
    super.initState();
    _mInitiate();
    _mManageLocationReq();
    _mLoadData();
  }

  @override
  Widget build(BuildContext context) {
    uCustomStatusBar();

    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColors.caribbeanGreenTint7.withOpacity(1),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // _mOnClickSearchBtn();
              _mOnClickSearchBtn();
            },
            shape: CircleBorder(),
            backgroundColor: MyColors.spaceCadetTint1,
            child: Icon(
              Icons.search,
              color: MyColors.caribbeanGreenTint6,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: HomeBottomNavBar(
            pageIndex: _pageIndex,
            fabLocation: FloatingActionButtonLocation.centerDocked,
            shape: const CircularNotchedRectangle(),
            callback: (int pageIndex) {
              setState(() {
                _pageIndex = pageIndex;
              });
            },
          ),
          body: _pageIndex == 0
              ? _vHome()
              : _pageIndex == 1
                  ? BookingsScreen(provider: widget.provider,)
                  : null),
    );
  }

  _vHome() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 18, bottom: 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _vTopBarPart(),
            Divider(
              color: Colors.black12,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Recents",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                /* Text(
              "See All",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
            ), */
              ],
            ),
            _vProductSlider(),
            SizedBox(
              height: 12,
            ),
            _vTextGreetings(),
            SizedBox(
              height: 18,
            ),
            /* _vEditTextSearchProvider(),
              SizedBox(
                height: 20,
              ), */
            _vCategory(),
            Divider(
              thickness: 1,
              color: Colors.black12,
              height: 2,
            ),
            SizedBox(
              height: 20,
            ),
            _vRecommends(),
          ],
        ),
      ),
    );
  }

  _vProductSlider() {
    return Container(
      margin: EdgeInsets.only(top: 4, bottom: 5),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 150.0,
          autoPlay: true,
        ),
        items: bookingList.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                  onTap: () {
                    /* Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FoodDescScreen(food: i);
                    })); */
                  },
                  child: _vBannerItem(i));
            },
          );
        }).toList(),
      ),
    );
  }

  _vBannerItem(Booking booking) {
    return Container(
      // alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      // height: MyScreenSize.mGetHeight(context, 30),
      width: MyScreenSize.mGetWidth(context, 100),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(1, 1),
            blurRadius: 1,
          ),
        ],
        // color: booking.status! ? MyColors.vividmalachite : Colors.orange,
        color: booking.bookingStatus! ? Colors.white : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // v: top
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Image(
                  image: AssetImage(
                    HomeViewModel().mGetServiceCatIcon(
                            serviceCategory:
                                booking.providerDataSet!.category!) ??
                        "assets/images/ic_cleaning.png",
                  ),
                  width: 28,
                  height: 28,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${booking.providerDataSet!.category!} Service",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      // Text("Price: "),
                      Text(
                        "${booking.providerDataSet!.serviceFee} ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text("Tk/hr"),
                    ],
                  )
                ],
              )
            ],
          ),
          Divider(
            height: 14,
            color: Colors.black12,
          ),
          // v: status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Status"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black12),
                    border: Border.all(
                      color: booking.bookingStatus!
                          ? MyColors.vividmalachite
                          : Colors.orange,
                    ),
                    /* color: booking.status!
                        ? MyColors.vividmalachite
                        : Colors.orange, */
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(.5, .5),
                          blurRadius: .5)
                    ]),
                child: booking.bookingStatus!
                    ? Text(
                        "Confirmed",
                        style: TextStyle(
                          // color: Colors.white,
                          color: MyColors.vividmalachite,
                        ),
                      )
                    : Text(
                        "Pending",
                        style: TextStyle(
                          // color: Colors.white,
                          color: Colors.orange,
                        ),
                      ),
              )
            ],
          ),
          SizedBox(
            height: 6,
          ),
          // v: schedule
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                size: 18,
                color: Colors.black45,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${booking.workingHour} hour, ${MyDateFormat.mFormateDate2(DateTime.fromMillisecondsSinceEpoch(booking.ts!))}",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Schedule",
                    style: TextStyle(color: Colors.black45),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _vTopBarPart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _vUserDetailsPart(),
        _vNotificationBtn(),
      ],
    );
  }

  _vUserImage() {
    return InkWell(
      onTap: () {
        _vAction();
      },
      child: Container(
        // padding: EdgeInsets.all(4),
        height: MyScreenSize.mGetHeight(context, 6),
        width: MyScreenSize.mGetWidth(context, 14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)
            // color: MyColors.caribbeanGreen
            ),
        child: Image(
          image: AssetImage("assets/images/image 1.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _vUserNameAndAddress() {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 3),
          child: CustomText(
            text: _userName,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Row(
          children: [
            Icon(
              Icons.location_pin,
              color: MyColors.spaceCadetTint4,
              size: 18,
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              _userAddress,
              style: TextStyle(fontSize: 14),
            )
          ],
        )
      ]),
    );
  }

  _vNotificationBtn() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            // padding: EdgeInsets.all(4),
            height: MyScreenSize.mGetHeight(context, 6),
            width: MyScreenSize.mGetWidth(context, 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.caribbeanGreenTint6),
            child: Icon(
              Icons.notifications,
              color: MyColors.spaceCadet,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  _vUserDetailsPart() {
    return Expanded(
      flex: 5,
      child: Row(
        children: [
          _vUserImage(),
          SizedBox(
            width: 4,
          ),
          _vUserNameAndAddress(),
        ],
      ),
    );
  }

  _vTextGreetings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good $_greeting!",
            style: TextStyle(
              fontFamily: fontOswald,
              fontSize: 24,
              color: MyColors.spaceCadetTint4,
              fontWeight: FontWeight.bold,
            ),
          ),
          /* SizedBox(
            height: 2,
          ), */
          Text(
            "What you are looking for today.",
            style: TextStyle(
              fontFamily: fontOswald,
              fontSize: 18,
              color: MyColors.spaceCadetTint4,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _vEditTextSearchProvider() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "Search what you need",
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            suffixIcon: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.vividCerulean,
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 18,
              ),
            )),
      ),
    );
  }

  _vCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // v: lebels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "See All",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        // v:Horizontal List
        Container(
          height: MyScreenSize.mGetHeight(context, 12),
          width: MyScreenSize.mGetWidth(context, 100),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: serviceCategoryList.length,
              itemBuilder: (context, index) {
                return _vItem(serviceCategoryList[index]);
              }),
        )
      ],
    );
  }

  void _mInitiate() {
    _focusNode = FocusNode();
    _userAddress = widget.currentLocationDetails.formattedAdress!;
    _currentLocationDetails = widget.currentLocationDetails;

    // _controllerAddress = TextEditingController(text: _userAddress);
    // c: cut long userAdress
    if (_userAddress.length > 30) {
      _userAddress = "${_userAddress.substring(0, 30)}...";
    }

    for (var i = 1; i < 4; i++) {
      _listFood1.add(Food.bannarConstructor(
          name: "My Food $i",
          desc: dummyFoodDesc,
          imgUri: "assets/dummy_banner_1.png"));
    }
  }

  void _mMakeGreetings() {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      _greeting = "Morning";
    } else if (hour < 17) {
      _greeting = "Afternoon";
    } else {
      _greeting = "Evening";
    }
  }

  _vItem(ServiceCategory serviceCategoryList) {
    return InkWell(
      splashColor: Colors.black12.withOpacity(.1),
      onTap: () {
        // _mOnClickCategory(serviceCategoryList);
        setState(() {
          _selectedCategory = serviceCategoryList.name!;
        });
      },
      child: _selectedCategory != serviceCategoryList.name
          ? Container(
              width: MyScreenSize.mGetWidth(context, 20),
              margin: EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.white.withOpacity(.2)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(serviceCategoryList.iconUri!),
                    width: 48,
                    height: 48,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(serviceCategoryList.name!)
                ],
              ),
            )
          : Container(
              width: MyScreenSize.mGetWidth(context, 22),
              margin: EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: Offset(1, 1))
                  ],
                  // color: Colors.white.withOpacity(.2)),
                  color: BookingsViewModel().mGetServiceCatIconBgColor(
                    categoryName: serviceCategoryList.name!,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(serviceCategoryList.iconUri!),
                    width: 48,
                    height: 48,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(serviceCategoryList.name!)
                ],
              ),
            ),
    );
  }

  _vRecommends() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // v: lebels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recommended For You",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            /* Text(
              "See All",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w400),
            ), */
          ],
        ),
        SizedBox(
          height: 12,
        ),
        // v:Horizontal List
        Container(
          height: MyScreenSize.mGetHeight(context, 28),
          width: MyScreenSize.mGetWidth(context, 100),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recommendedProviderList!.length,
              // itemCount: 5,
              itemBuilder: (context, index) {
                return _vItemProvider(_recommendedProviderList![index]);
              }),
        )
      ],
    );
  }

  _vItemProvider(ProviderDataset providerDataset) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProviderProfileScreen(providerDataset: providerDataset);
        }));
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: MyScreenSize.mGetWidth(context, 36),
        child: Stack(alignment: Alignment.center, children: [
          // v: details
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                // v: body
                Container(
                  padding: EdgeInsets.only(
                    top: MyScreenSize.mGetHeight(context, 4),
                    bottom: MyScreenSize.mGetHeight(context, 1),
                    right: MyScreenSize.mGetWidth(context, 4),
                    left: MyScreenSize.mGetWidth(context, 4),
                  ),
                  height: MyScreenSize.mGetHeight(context, 19),
                  width: MyScreenSize.mGetWidth(context, 36),
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      border: Border.all(color: Colors.black12),
                      // color: Colors.white.withOpacity(.2),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        providerDataset.name!,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      /*   Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 20,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      ), */
                      RatingStars(
                        valueLabelVisibility: false,
                        value: providerDataset.rating!,
                        starSize: 12,
                        starColor: Colors.amber.shade700,
                      ),
                      Text(
                        "(${providerDataset.numOfReview} Reviews)",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${providerDataset.category!} Service",
                        style: TextStyle(
                          color: MyColors.vividCerulean,
                        ),
                      ),
                      Text(
                        "${providerDataset.serviceFee} Tk",
                        style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                // v: hire btn
                NeumorphicButton(
                  style: NeumorphicStyle(
                      color: MyColors.caribbeanGreenTint2,
                      depth: 1,
                      shape: NeumorphicShape.convex),
                  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  child: Text(
                    "Check",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
          // v: img
          Positioned(
            top: 0,
            child: Container(
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
                backgroundImage: NetworkImage(providerDataset.imgUri!),
                radius: 32,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _vShowLocationPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission'),
          content: Text(
              'Please grant location permission for the app to function properly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
              },
              child: Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  void _mLoadData() async {
    _greeting = _homeViewModel.mMakeGreetings();
    _recommendedProviderList =
        _homeViewModel.mSortProviderForMaxRating(widget.providerDatasetList);
    //  await _homeViewModel.mGetCurrentPostion();
    // await _homeViewModel.mCheckLocationPermission();
  }

  void _mManageLocationReq() async {
    /* _currentLocationDetails =
        await _homeViewModel.mManageLocAccessAndFetchCurrentPos(); */
    logger.d(
        "CurrentLocationDetails: ${_currentLocationDetails!.lat}, ${_currentLocationDetails!.long},${_currentLocationDetails!.formattedAdress}");
  }

  void _mOnClickCategory(ServiceCategory serviceCategoryList) async {
    // m: This function should be code into Viewmodel

    _isLocationAccessGranted = await _homeViewModel.mCheckLocationPermission();
    if (_isLocationAccessGranted) {
      if (_currentLocationDetails == null) {
        _currentLocationDetails =
            await _homeViewModel.mManageLocAccessAndFetchCurrentPos();
        if (_currentLocationDetails == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Something worng, restart your app",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ));
        } else {
          // c: navigate to search screen
          _mGotoSearchScreen();
          logger.i("Granted now");
        }
      } else {
        // c: navigate to search screen
        _mGotoSearchScreen();
        logger.i("Granted now");
      }
    } else {
      _vShowLocationPermissionDialog();
    }
  }

  void _mOnClickSearchBtn() async {
    // m: This function should be code into Viewmodel

    _isLocationAccessGranted = await _homeViewModel.mCheckLocationPermission();
    if (_isLocationAccessGranted) {
      if (_currentLocationDetails == null) {
        _currentLocationDetails =
            await _homeViewModel.mManageLocAccessAndFetchCurrentPos();
        if (_currentLocationDetails == null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Something worng, restart your app",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ));
        } else {
          // c: navigate to search screen
          _mGotoSearchScreen();
          logger.i("Granted now");
        }
      } else {
        // c: navigate to search screen
        _mGotoSearchScreen();
        logger.i("Granted now");
      }
    } else {
      _vShowLocationPermissionDialog();
    }
  }

  void _mGotoSearchScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      /* logger.d(
          "My lat: ${_currentLocationDetails!.lat}, My long: ${_currentLocationDetails!.long}, My place: ${_currentLocationDetails!.formattedAdress}");
      logger.d("length: ${widget.providerDatasetList.length}"); */
      return FindProviderScreen(
        currentLocationDetails: _currentLocationDetails!,
        serviceCategory: _selectedCategory,
        searchRange: 5,
        providerDatasetList: widget.providerDatasetList,
      );
    }));
  }

  void _vAction() {
    /* 
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return ProviderProfileScreen();
    })));
   */
  }
}
