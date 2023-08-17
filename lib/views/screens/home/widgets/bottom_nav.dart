

import 'package:flutter/material.dart';

import '../../../../utils/my_colors.dart';
import '../../../../utils/my_screensize.dart';


class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({
    super.key,
    required this.fabLocation,
    this.shape,
    required this.callback,
    required this.pageIndex,
  });

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;
  final Function callback;
  final int pageIndex;

  static final centerLocations = <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
  ];

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  Color tabColor0 = Colors.white;
  Color tabColor1 = Colors.white;

  @override
  void initState() {
    print("Nav call");
    switch (widget.pageIndex) {
      case 0:
        tabColor0 = MyColors.caribbeanGreenTint6;
        break;
      case 1:
        tabColor1 = MyColors.caribbeanGreenTint6;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final localizations = GalleryLocalizations.of(context)!;
    return BottomAppBar(
      color: MyColors.spaceCadetTint1,
      clipBehavior: Clip.antiAlias,
      shape: widget.shape,

      // elevation: 5,
      height: MyScreenSize.mGetHeight(context, 7),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              widget.callback(0);
              setState(() {
                tabColor1 = tabColor0;
                tabColor0 = MyColors.caribbeanGreenTint6;
              });
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.home,
                  color: tabColor0,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Home",
                  style: TextStyle(color: tabColor0),
                )
              ],
            ),
          ),
      
          /* InkWell(
            onTap: () {
              widget.callback(1);
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.search),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ), */
      
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              "Search",
              style: TextStyle(color: Colors.white),
            ),
          ),
          //  const SizedBox(width: 1,)
      
          // if (centerLocations.contains(fabLocation)) const Spacer(),
          /* InkWell(
            onTap: () {
              widget.callback(2);
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.chat),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "chat",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ), */
      
          InkWell(
            onTap: () {
              setState(() {
                tabColor0 = tabColor1;
                tabColor1 = MyColors.caribbeanGreenTint6;
              });
              widget.callback(1);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.view_list,
                  color: tabColor1,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Bookings",
                  style: TextStyle(color: tabColor1),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}