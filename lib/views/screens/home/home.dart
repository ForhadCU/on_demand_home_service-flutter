// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider.dart';
import 'package:thesis_project/models/servie_category.dart';
import 'package:thesis_project/utils/custom_text.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/my_screensize.dart';
import 'package:thesis_project/utils/statusbar.dart';
import 'package:thesis_project/views/screens/home/widgets/bottom_nav.dart';

import '../../../models/food.dart';
import '../settings/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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

  @override
  void initState() {
    super.initState();
    uCustomStatusBar();
    _mInitiate();
    _mMakeGreetings();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: MyColors.caribbeanGreenTint7,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
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
                  ? SettingsScreen()
                  : null),
    );
  }

  _vHome() {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _vTopBarPart(),
            SizedBox(
              height: 12,
            ),
            _vTextGreetings(),
            SizedBox(
              height: 12,
            ),
            _vProductSlider(),
            SizedBox(
              height: 24,
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
              height: 28,
            ),
            _vRecommends(),
          ],
        ),
      ),
    );
  }

  _vProductSlider() {
    return Container(
      margin: EdgeInsets.only(top: 0, bottom: 5),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 140.0,
          autoPlay: true,
        ),
        items: _listFood1.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                  onTap: () {
                    /* Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return FoodDescScreen(food: i);
                    })); */
                  },
                  child: vFoodCard(i));
            },
          );
        }).toList(),
      ),
    );
  }

  vFoodCard(Food i) {
    return Container(
      // alignment: Alignment.center,
      clipBehavior: Clip.hardEdge,
      // height: MyScreenSize.mGetHeight(context, 30),
      width: MyScreenSize.mGetWidth(context, 100),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(1, 1),
            blurRadius: 2,
          ),
        ],
        color: MyColors.caribbeanGreenTint7,
        borderRadius: BorderRadius.circular(10),
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
    return Container(
      // padding: EdgeInsets.all(4),
      height: MyScreenSize.mGetHeight(context, 6),
      width: MyScreenSize.mGetWidth(context, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: MyColors.caribbeanGreen
      ),
      child: Image(image: AssetImage("assets/images/image 1.png")),
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
            CustomText(
              text: _userAddress,
              fontsize: 14,
            ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Good $_greeting!",
          style: TextStyle(
            fontFamily: fontOswald,
            fontSize: 32,
            color: MyColors.spaceCadetTint4,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          "What you are looking for today.",
          style: TextStyle(
            fontFamily: fontOswald,
            fontSize: 24,
            color: MyColors.spaceCadetTint4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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

    for (var i = 1; i < 11; i++) {
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
    return Container(
      width: MyScreenSize.mGetWidth(context, 20),
      margin: EdgeInsets.only(right: 4, left: 4, top: 8, bottom: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(.2)),
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
              // itemCount: providerList.length,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _vItemProvider(providerList[0]);
              }),
        )
      ],
    );
  }

  _vItemProvider(ServiceProvider providerList) {
    return Container(
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
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(14)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      providerList.name!,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Row(
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
                    ),
                    Text(
                      "(${providerList.numOfReview} Reviews)",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${providerList.category!} Service",
                      style: TextStyle(
                        color: MyColors.vividCerulean,
                      ),
                    ),
                    Text(
                      "${providerList.serviceFee} Tk",
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
              backgroundImage: AssetImage("assets/images/provider1.jpg"),
              radius: 32,
            ),
          ),
        ),
      ]),
    );
  }
}
