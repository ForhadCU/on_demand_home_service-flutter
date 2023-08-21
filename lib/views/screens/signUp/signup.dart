// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:logger/logger.dart';
import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider_dataset.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/my_screensize.dart';
import 'package:thesis_project/utils/statusbar.dart';
import 'package:thesis_project/view_models/vm_signup.dart';
import 'package:thesis_project/views/screens/setLocation/set_location.dart';
import 'package:thesis_project/views/signIn/scr.sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _selectedRadioBtnValue = "1";
  final Logger logger = Logger();

  var items = [
    'Painter',
    'Doctor',
    'Electrician',
    'Engineer',
    'Mechanic',
  ];
  final TextEditingController _editingControllerName = TextEditingController();
  final TextEditingController _editingControllerEmail = TextEditingController();
  final TextEditingController _editingControllerPassword =
      TextEditingController();
  String _dropdownvalue = 'Painter';
  bool _isSubmitting = false;
  bool _isProvider = true;
  SignUpViewModel _signUpViewModel = SignUpViewModel();

  @override
  void initState() {
    super.initState();
    uCustomStatusBar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.caribbeanGreenTint7,
        body: Container(
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    vHeaderText(),
                    SizedBox(
                      height: 32,
                    ),
                    vNameInput(),
                    SizedBox(
                      height: 18,
                    ),
                    vEmailInput(),
                    SizedBox(
                      height: 18,
                    ),
                    vPhoneInput(),
                    SizedBox(
                      height: 18,
                    ),
                    vPassInput(),
                    SizedBox(
                      height: 44,
                    ),
                    vUserType(),
                    SizedBox(
                      height: 24,
                    ),
                    vCategoryDropdown(),
                    SizedBox(
                      height: 88,
                    ),
                    vSubmitBtn(),
                  ]),
            )),
      ),
    );
  }

  vHeaderText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NeumorphicText(
              "Hey!",
              style: NeumorphicStyle(
                  depth: 1,
                  shadowDarkColor: MyColors.spaceCadetShadow1,
                  color: MyColors.spaceCadetTint1),
              textStyle:
                  NeumorphicTextStyle(fontFamily: fontBebasNue, fontSize: 46),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignInScreen();
                  }));
                },
                child: Text(
                  "Sign in",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ))
          ],
        ),
        NeumorphicText(
          "Register Now",
          style: NeumorphicStyle(
              depth: 2,
              shadowDarkColor: MyColors.spaceCadetShadow1,
              color: MyColors.spaceCadetTint1),
          textStyle:
              NeumorphicTextStyle(fontSize: 32, fontFamily: fontBebasNue),
        )
      ],
    );
  }

  vNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Username",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Neumorphic(
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
              hintText: 'Enter your username',
              hintStyle: TextStyle(color: MyColors.spaceCadetTint5),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            ),
          ),
        )
      ],
    );
  }

  vEmailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Neumorphic(
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
              // hintText: 'Enter your text...',
              hintText: 'Enter your email',
              hintStyle: TextStyle(color: MyColors.spaceCadetTint5),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            ),
          ),
        )
      ],
    );
  }

  vPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Neumorphic(
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
              // hintText: 'Enter your text...',
              hintText: 'Enter your phone',
              hintStyle: TextStyle(color: MyColors.spaceCadetTint5),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            ),
          ),
        )
      ],
    );
  }

  vPassInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Neumorphic(
          // padding: EdgeInsets.all(8),
          style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(18)),
            depth: -4,
            intensity: 0.9,
            // color: MyColors.caribbeanGreenTint7,
            color: Colors.white,
          ),
          child: TextFormField(
            obscureText: true,
            cursorColor: MyColors.vividCerulean,
            style: TextStyle(color: MyColors.vividCerulean),
            decoration: InputDecoration(
              // hintText: 'Enter your text...',
              hintText: 'Enter your password',
              hintStyle: TextStyle(color: MyColors.spaceCadetTint5),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            ),
          ),
        )
      ],
    );
  }

  vUserType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "User Type",
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NeumorphicRadio<String>(
                  padding: EdgeInsets.all(16),
                  style: NeumorphicRadioStyle(
                    shape: NeumorphicShape.convex,
                    intensity: 0.8,
                    boxShape: NeumorphicBoxShape.circle(),
                    unselectedDepth: 4,
                    selectedDepth: 8,
                    selectedColor: MyColors.caribbeanGreenTint4,
                    unselectedColor: Colors.black12,
                    border: NeumorphicBorder(
                        isEnabled: _selectedRadioBtnValue == '0' ? true : false,
                        color: MyColors.caribbeanGreenTint1,
                        width: 1),
                  ),
                  groupValue: _selectedRadioBtnValue,
                  value: '0',
                  onChanged: (value) {
                    _mHandleChangedValue(value!);
                  },
                  // child: Text('Consumer'),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Consumer",
                  style: TextStyle(
                    color: _selectedRadioBtnValue == "0"
                        ? MyColors.vividCerulean
                        : Colors.grey,
                    fontSize: 16,
                    fontWeight: _selectedRadioBtnValue == '0'
                        ? FontWeight.w500
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 24,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                NeumorphicRadio<String>(
                  padding: EdgeInsets.all(16),
                  style: NeumorphicRadioStyle(
                    shape: NeumorphicShape.convex,
                    selectedColor: MyColors.caribbeanGreenTint4,
                    unselectedColor: Colors.black12,
                    border: NeumorphicBorder(
                        isEnabled: _selectedRadioBtnValue == '1' ? true : false,
                        color: MyColors.caribbeanGreenTint1,
                        width: 1),
                    boxShape: NeumorphicBoxShape.circle(),
                    unselectedDepth: 4,
                    selectedDepth: 8,
                    intensity: 0.8,
                  ),
                  groupValue: _selectedRadioBtnValue,
                  value: '1',
                  onChanged: (value) {
                    _mHandleChangedValue(value!);
                  },
                  // child: Text('Consumer'),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Provider",
                  style: TextStyle(
                    color: _selectedRadioBtnValue == "1"
                        ? MyColors.vividCerulean
                        : Colors.grey,
                    fontSize: 16,
                    fontWeight: _selectedRadioBtnValue == '1'
                        ? FontWeight.w500
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  _mHandleChangedValue(String value) {
    setState(() {
      _selectedRadioBtnValue = value;
      logger.d("Seleted: $_selectedRadioBtnValue");
      //c: hide category dropdown
      value == "0" ? _isProvider = false : _isProvider = true;
    });
  }

  vCategoryDropdown() {
    return Visibility(
      visible: _isProvider,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Category",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Neumorphic(
            style: NeumorphicStyle(
              color: MyColors.caribbeanGreenTint7,
              shadowLightColor: MyColors.caribbeanGreenTint7,
              shape: NeumorphicShape.flat,
              depth: 1,
            ),
            child: Container(
              height: MyScreenSize.mGetHeight(context, 4),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  isExpanded: true,
                  value: _dropdownvalue,
                  alignment: Alignment.bottomRight,
                  underline: Container(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: MyColors.caribbeanGreenTint2,
                  ),

                  // icon: const Icon(Icons.keyboard_arrow_down),

                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(color: MyColors.vividCerulean),
                      ),
                    );
                  }).toList(),

                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  vSubmitBtn() {
    return NeumorphicButton(
      margin:
          EdgeInsets.symmetric(horizontal: MyScreenSize.mGetWidth(context, 10)),
      onPressed: () async {
        setState(() {
          // e: Signup and Data Saving operation goes here...
          _isSubmitting = true;
        });

        // c: Generate dataset
        /*  List<ProviderDataset> list =
            await _signUpViewModel.mGenerateProviderDataset(); */
        await _signUpViewModel.mSignUp(
            email: "user@gmail.com", password: "1234567");

        _mNavigate();
      },
      style: NeumorphicStyle(
        depth: 5,
        intensity: 0.8,
        shape: NeumorphicShape.convex,
        color: MyColors.caribbeanGreenTint7,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isSubmitting
              ? GFLoader(
                  type: GFLoaderType.ios,
                  size: 24,
                )
              : Icon(
                  Icons.arrow_forward_ios,
                  color: MyColors.caribbeanGreenTint3,
                ),
        ],
      ),
    );
  }

  void _mNavigate() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SignInScreen();
    }));
  }
}
