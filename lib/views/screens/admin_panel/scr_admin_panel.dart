// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/my_screensize.dart';
import 'package:thesis_project/view_models/vm_common.dart';
import 'package:thesis_project/views/screens/admin_panel/pages/provider_data.dart';

import '../../../models/provider_dataset.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  bool _isVisibleProviderData = false;
  bool _isVisibleConsumerData = false;
  
  var _commonViewModel = CommonViewmodel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: MyColors.caribbeanGreenTint7,
      appBar: AppBar(
        title: Text("Admin Panel"),
        backgroundColor: MyColors.caribbeanGreenTint7,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  /* setState(() {
                    _isVisibleProviderData = !_isVisibleProviderData;
                    _isVisibleConsumerData = false;
                  }); */
                    List<ProviderDataset> list = await _commonViewModel
                              .mGetPorviderDatasetFromJson(context: context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ProviderDataPage(providerDatasetList: list);
                  }));
                },
                child: Row(
                  children: [
                    Text(
                      "Provider Data",
                      style: TextStyle(
                        color: MyColors.spaceCadetTint1,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: MyColors.vividCerulean,
                      size: 24,
                    ),
                  ],
                ),
              ),
              /* Visibility(
          visible: _isVisibleProviderData,
          child: Column(children: [
            Container(
              width: MyScreenSize.mGetHeight(context, 80),
              child: NeumorphicButton(
                child: Text("Activity Period"),
              ),

            )
          ]),
        ), */
              Divider(
                height: 8,
                color: Colors.black12,
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isVisibleConsumerData = !_isVisibleConsumerData;
                    _isVisibleProviderData = false;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      "Consumer Data",
                      style: TextStyle(
                        color: MyColors.spaceCadetTint1,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_outlined,
                      color: MyColors.vividCerulean,
                      size: 24,
                    ),

                    /* Visibility(
                      visible: _isVisibleConsumerData,
                      child: Column(children: []),
                    ), */
                  ],
                ),
              ),
              Divider(
                height: 8,
                color: Colors.black12,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
