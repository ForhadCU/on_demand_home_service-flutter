// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/models/booking.dart';
import 'package:thesis_project/utils/statusbar.dart';
import 'package:thesis_project/view_models/vm_bookings.dart';
import 'package:thesis_project/views/screens/profile/scr_provider_profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/my_colors.dart';
import '../../utils/my_date_format.dart';
import '../../utils/my_screensize.dart';
import '../../view_models/vm_home.dart';

class BookingsScreen extends StatefulWidget {
  final Booking? booking;
  final String? provider;
  const BookingsScreen({super.key, this.booking, this.provider});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  BookingsViewModel _bookingsViewModel = BookingsViewModel();
  List<Booking> _list = bookingList;

  bool isAcceptedCliked = false;
  bool isRejectedClicked = false;

  // bool _isCardClicked = false;

  @override
  void initState() {
    super.initState();
    widget.booking != null ? _list.add(widget.booking!) : null;
  }

  @override
  Widget build(BuildContext context) {
    uCustomStatusBar();
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.caribbeanGreenTint7,
        /*  appBar: AppBar(
          title: Text("Admin Panel"),
          backgroundColor: MyColors.caribbeanGreenTint7,
          elevation: 0,
        ), */
        body: Container(
          padding: EdgeInsets.only(left: 12, top: 18, bottom: 12, right: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MyScreenSize.mGetWidth(context, 1),
                    height: MyScreenSize.mGetHeight(context, 3),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Bookings",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: bookingList.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return _vItem(bookingList[index]);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _vItem(Booking booking) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
          border: Border.all(
              color: booking.bookingStatus!
                  ? MyColors.vividmalachite
                  : Colors.orange,
              width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              blurRadius: 2,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // v: top
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: _bookingsViewModel.mGetServiceCatIconBgColor(
                      categoryName: booking.providerDataSet!.category!,
                    )),
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      // Text("Price: "),
                      Text(
                        "${booking.providerDataSet!.serviceFee!} ",
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
            height: 24,
            color: Colors.black12,
          ),
          // v: bookingStatus
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
                    /* color: booking.bookingStatus!
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
            height: 12,
          ),
          // v: working hour
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 28,
                      color: Colors.black45,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${booking.workingHour} hour, ${MyDateFormat.mFormateDate2(DateTime.fromMillisecondsSinceEpoch(booking.ts!))}",
                          // booking.schedule.toString(),

                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "Working Hour",
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // c: Disable button
              NeumorphicButton(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                style: NeumorphicStyle(
                  color: Colors.white,
                ),
                child: Text(
                  "Null",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(booking.providerDataSet!.imgUri!),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 6,
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.providerDataSet!.name!,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 18),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            // Text("Price: "),
                            Text(
                              "${booking.providerDataSet!.location} ",
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _mAction(booking);
                },
                child: Neumorphic(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  style: NeumorphicStyle(
                    depth: 1,
                    intensity: 4,
                    color: MyColors.vividCerulean,
                    shape: NeumorphicShape.convex,
                  ),
                  child: Text(
                    "Check",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 28,
          ),
          widget.provider != null
              ? Visibility(
                  visible:
                      !booking.acceptanceStatus! && !booking.rejectanceStatus!,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeumorphicButton(
                        onPressed: () {
                          setState(() {
                            booking.rejectanceStatus = true;
                            booking.acceptanceStatus = false;
                            booking.bookingStatus = false;
                          });
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                        style: NeumorphicStyle(color: Colors.red),
                        child: Text(
                          "Reject",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      NeumorphicButton(
                        onPressed: () {
                          booking.acceptanceStatus = true;
                          booking.rejectanceStatus = false;
                          booking.bookingStatus = true;
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                        style: NeumorphicStyle(color: MyColors.vividmalachite),
                        child: Text(
                          "Accept",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          booking.acceptanceStatus!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                      style: NeumorphicStyle(
                          color: Colors.white,
                          border: NeumorphicBorder(
                              color: MyColors.vividmalachite.withOpacity(.8))),
                      child: Text(
                        "Accepted",
                        style: TextStyle(color: MyColors.vividmalachite),
                      ),
                    ),
                  ],
                )
              : Container(),
          booking.rejectanceStatus!
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                      style: NeumorphicStyle(
                          color: Colors.white,
                          border: NeumorphicBorder(
                            color: Colors.red.withOpacity(.8),
                          )),
                      child: Text(
                        "Rejected",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  void _mAction(Booking booking) {
    /* 
    // e: get providers full details with providerId
    // launchUrl(Uri.parse("tel://01819692172"));
    // c: Goto Provider Profile
     Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProviderProfileScreen();
    }));
  */
  }
}
