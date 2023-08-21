// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:thesis_project/utils/my_screensize.dart';

import '../../../../utils/custom_text.dart';
import '../../../../utils/my_colors.dart';

class EditDialog extends StatefulWidget {
  final Function callback;
  int currentRoundValue;
  int currentFrucValueAsInt;
  // final SharedPreferences sharedPreferences;
  EditDialog({
    Key? key,
    required this.callback,
    required this.currentRoundValue,
    required this.currentFrucValueAsInt,
  }) : super(key: key);

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
/*   late double _priWeight;
  late int _actualWeeks = 0;
  late int _runningWeeks = 0;
  late int _currentRoundValue = 0;
  late int _currentFrucValueAsInt = 0; */

  late SharedPreferences sharedPreferences;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    /*  MyServices.mGetSharedPrefIns().then((value) {
      setState(() {
        sharedPreferences = value;
        _priWeight = sharedPreferences.getDouble(MyKeywords.primaryWeight)!;
        _actualWeeks = sharedPreferences.getInt(MyKeywords.runningWeeks)!;
        _runningWeeks = _actualWeeks + 1;

        _currentRoundValue = _priWeight
            .floor(); //set current weight's value before decimal point
        MyServices.mSetFrucValueAsInt(
            priWeight: _priWeight,
            callback: (int value) {
              _currentFrucValueAsInt = value;
              logger.d(_currentFrucValueAsInt);
            });
      });
    }); */
    //set current weight's value after decimal point
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
      // insetPadding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //heading
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            color: MyColors.caribbeanGreenTint5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Editor',
                  fontWeight: FontWeight.w600,
                  fontcolor: MyColors.caribbeanGreenTint1,
                  fontsize: 18,
                ),
              ],
            ),
          ),
          /*  const SizedBox(
            height: 4,
          ),
          //body
          //week no
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(text: MaaData.weekNo),
              //get week no from sharedpref and convert it into Bangla font
              CustomText(text: MyServices.mGenerateBangNum(widget.runningWeeks))
            ],
          ), */
          const SizedBox(
            height: 8,
          ),
          //Weight picker
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: MyScreenSize.mGetHeight(context, 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //weight's round value picking..
                    NumberPicker(
                        itemWidth: 60,
                        minValue: 0,
                        maxValue: 150,
                        infiniteLoop: true,
                        value: widget
                            .currentRoundValue, //set round value from previous weight
                        onChanged: (value) => setState(() {
                              widget.currentRoundValue = value;
                            })),

                    const CustomText(
                      text: '.',
                      fontWeight: FontWeight.bold,
                      fontsize: 16,
                      fontcolor: Colors.purple,
                    ),

                    //weight's fructional value picking..
                    NumberPicker(
                        itemWidth: 60,
                        minValue: 0,
                        maxValue: 9,
                        infiniteLoop: true,
                        value: widget.currentFrucValueAsInt,
                        onChanged: (value) => setState(() {
                              widget.currentFrucValueAsInt = value;
                            }))
                  ],
                ),
              )
            ],
          ),
          //Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /* InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child:  Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'বাতিল',
                    fontcolor: Colors.red.withOpacity(.5),
                    fontsize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              ), */
              InkWell(
                onTap: () {
                  double updatedWeight = double.parse(
                      "${widget.currentRoundValue}.${widget.currentFrucValueAsInt}");

                  //arekta call back lagbe
                  widget.callback(updatedWeight);
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'Search',
                    fontcolor: MyColors.vividCerulean,
                    fontsize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 24,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
