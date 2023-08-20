// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/models/provider_dataset.dart';
import 'package:thesis_project/models/working_hour.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/my_screensize.dart';
import 'package:thesis_project/utils/statusbar.dart';

class ProviderProfileScreen extends StatefulWidget {
  final ProviderDataset? providerDataset;

  const ProviderProfileScreen({super.key, required this.providerDataset});

  @override
  State<ProviderProfileScreen> createState() => ProviderProfileScreenState();
}

class ProviderProfileScreenState extends State<ProviderProfileScreen> {
  late var currentDate = DateTime.now();
  late DatePickerController _datePickerController;
  late List<DateTime> selectedDateList;
  int _selectedHour = 1;
  late ProviderDataset _providerDataset;
  @override
  void initState() {
    super.initState();
    _providerDataset = widget.providerDataset!;
    _datePickerController = DatePickerController();
    selectedDateList = [];
    var today = DateTime.now();
    selectedDateList.add(DateTime(today.year, today.month, today.day));

    Future.delayed(Duration(seconds: 1)).then((value) {
      _datePickerController.animateToSelection(
        duration: Duration(seconds: 3),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    uCustomStatusBar(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light);

    return Scaffold(
      backgroundColor: MyColors.caribbeanGreenTint7,
      body: WillPopScope(
        onWillPop: () async {
          uCustomStatusBar();
          return true;
        },
        child: Stack(children: [
          /*   CustomPaint(
            painter: HeaderCurvedContainerForProfile(),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ), */
          // v: Image
          Positioned(
            right: -MyScreenSize.mGetWidth(context, 45),
            top: -12,
            child: Container(
                clipBehavior: Clip.hardEdge,
                height: MyScreenSize.mGetHeight(context, 42),
                width: MyScreenSize.mGetWidth(context, 120),
                decoration: BoxDecoration(
                  border:
                      Border.all(width: 8, color: Colors.white.withOpacity(.8)),
                  shape: BoxShape.circle,
                  color: MyColors.caribbeanGreenTint5,
                ),
                // child: Image(image: AssetImage("assets/images/provider1.jpg",), fit: BoxFit.fill,),
                child: CircleAvatar(
                  // foregroundImage: AssetImage("assets/images/provider4.jpeg"),
                  foregroundImage:
                      NetworkImage(_providerDataset.imgUri!),
                )),
          ),
          // v: Name and Rating
          Positioned(
            top: MyScreenSize.mGetHeight(context, 34),
            left: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _providerDataset.name!,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: MyColors.spaceCadetTint1,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                  decoration: BoxDecoration(
                    color: MyColors.caribbeanGreenTint4,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _providerDataset.category!,
                    style: TextStyle(
                      color: MyColors.spaceCadetTint2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                RatingStars(
                  value: _providerDataset.rating!,
                  starSize: 14,
                  starColor: Colors.amber.shade800,
                  valueLabelColor: Colors.black26,
                  starOffColor: Colors.black26,
                ),
              ],
            ),
          ),
          // v: schedule part
          Positioned(
            bottom: 0,
            child: Container(
              height: MyScreenSize.mGetHeight(context, 52),
              width: MyScreenSize.mGetWidth(context, 100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white.withOpacity(.9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // v: select working date
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(24, 36, 12, 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Select Working Date",
                            style: TextStyle(
                                color: MyColors.caribbeanGreen, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: DatePicker(
                              DateTime.now().subtract(const Duration(days: 10)),
                              controller: _datePickerController,
                              initialSelectedDate: DateTime.now(),
                              selectionColor: MyColors.caribbeanGreenTint1,
                              selectedTextColor: Colors.white,
                              inactiveDates: [
                                DateTime.now()
                                    .subtract(const Duration(days: 1)),
                                DateTime.now()
                                    .subtract(const Duration(days: 2)),
                                DateTime.now()
                                    .subtract(const Duration(days: 3)),
                                DateTime.now()
                                    .subtract(const Duration(days: 4)),
                                DateTime.now()
                                    .subtract(const Duration(days: 5)),
                                DateTime.now()
                                    .subtract(const Duration(days: 6)),
                                DateTime.now()
                                    .subtract(const Duration(days: 7)),
                                DateTime.now()
                                    .subtract(const Duration(days: 8)),
                                DateTime.now()
                                    .subtract(const Duration(days: 9)),
                                DateTime.now()
                                    .subtract(const Duration(days: 10)),
                              ],
                              daysCount: 32,
                              onDateChange: (date) {
                                // _datePickerController.animateToSelection(
                                //   duration: Duration(seconds: 1),
                                // );
                                // New date selected
                                setState(() {
                                  // _selectedValue = date;
                                  logger.d(date);
                                  selectedDateList.clear();
                                  selectedDateList.add(date);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // v: select working hour
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(24, 36, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Working Hour",
                            style: TextStyle(
                                color: MyColors.caribbeanGreen, fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: workingHourList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  return _vItem(workingHourList[index]);
                                })),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(24, 24, 28, 24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // v: Price
                          Container(
                            /* padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: MyColors.caribbeanGreenTint1,
                              borderRadius: BorderRadius.circular(12)
                              ,
                            ), */
                            child: Row(
                              children: [
                                Text(
                                  "Price : ",
                                  style: TextStyle(
                                    color: MyColors.caribbeanGreen,
                                    // color: Cfolors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "${_providerDataset.serviceFee} Tk/hr",
                                  style: TextStyle(
                                    // color: MyColors.caribbeanGreen,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          NeumorphicButton(
                            // margin: EdgeInsets.all(4),
                            padding: EdgeInsets.symmetric(
                              horizontal: MyScreenSize.mGetWidth(context, 10),
                              vertical: MyScreenSize.mGetHeight(context, 1),
                            ),
                            style: NeumorphicStyle(
                              color: MyColors.vividCerulean,
                              // color: Colors.white,
                              depth: 3,
                              shape: NeumorphicShape.concave,
                              intensity: 2,
                            ),
                            child: Text(
                              "Hire Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _vItem(WorkingHour workingHour) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedHour = workingHour.quantity!;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(6),
        // height: MyScreenSize.mGetHeight(context, 5),
        // width: MyScreenSize.mGetWidth(context, 8),
        decoration: BoxDecoration(
            color: _selectedHour == workingHour.quantity
                ? MyColors.caribbeanGreenTint1
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12, width: .5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              workingHour.quantity.toString(),
              style: TextStyle(
                fontSize: 22,
                // fontFamily: fontOswald,
                color: _selectedHour == workingHour.quantity
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              //  workingHour.matrix!,
              "hour",
              style: TextStyle(
                // fontSize: 22,
                // fontFamily: fontOswald,
                color: _selectedHour == workingHour.quantity
                    ? Colors.white
                    : Colors.black,
                // fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
