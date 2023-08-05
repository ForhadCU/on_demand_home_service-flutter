// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/utils/custom_text.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/views/screens/home/home.dart';

import '../../../const/keywords.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
            _vSetLocation(),
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
              "Loaction",
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

  _vSetLocation() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      _vSearchBar(),
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
  }

  _vBgImage() {
    return Container();
  }

  _vSubmitBtn() {
    return Container();
  }

  _vSearchBar() {
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
              cursorColor: MyColors.vividCerulean,
              style: TextStyle(color: MyColors.vividCerulean),
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.pin_drop, color: Colors.grey, size: 24,),
                hintText: 'Search your location',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              ),
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
      children: [
        NeumorphicButton(
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
        _mAction();
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

  void _mAction() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }
}
