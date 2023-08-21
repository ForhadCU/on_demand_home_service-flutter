// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/getwidget.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/views/signIn/widgets/top_bar.dart';

import '../../utils/theme_configurator.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(
        defaultTextColor: Color(0xFF3E3E3E),
        accentColor: MyColors.caribbeanGreenTint7,
        // variantColor: Colors.black38,
        variantColor: MyColors.caribbeanGreenTint7,
        depth: 8,
        intensity: 0.65,
      ),
      themeMode: ThemeMode.light,
      child: Material(
        child: NeumorphicBackground(
          child: _Page(),
        ),
      ),
    );
  }
}

class _Page extends StatefulWidget {
  @override
  __PageState createState() => __PageState();
}

enum Gender { MALE, FEMALE, NON_BINARY }

class __PageState extends State<_Page> {
  String firstName = "";
  String lastName = "";
  double age = 12;
  late Gender gender;
  Set<String> rides = Set();

  bool isRememberd = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.caribbeanGreenTint7,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                child: TopBar(
                  actions: <Widget>[
                    ThemeConfigurator(),
                  ],
                ),
              ),
              Neumorphic(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                style: NeumorphicStyle(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  color: MyColors.caribbeanGreenTint7,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: NeumorphicButton(
                        onPressed: _isButtonEnabled() ? () {} : null,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        style: NeumorphicStyle(
                            color: MyColors.caribbeanGreenTint7),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    _AvatarField(),
                    SizedBox(
                      height: 8,
                    ),
                    _TextField(
                      label: "Email",
                      hint: "",
                      onChanged: (firstName) {
                        setState(() {
                          this.firstName = firstName;
                        });
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    _TextField(
                      label: "Password",
                      hint: "",
                      onChanged: (lastName) {
                        setState(() {
                          this.lastName = lastName;
                        });
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [ GFCheckbox(
            activeIcon: const Icon(Icons.check, size: 8, color: GFColors.WHITE),
            size: 12,
            onChanged: (value) {
              setState(() {
                isRememberd = !isRememberd;
              });
            },
            value: isRememberd),
        const Text("Do you want to save this session?")],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Neumorphic(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      style: NeumorphicStyle(
                          color: MyColors.caribbeanGreenTint7, depth: 8),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: MyColors.spaceCadetTint1,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    /*  _AgeField(
                      age: age,
                      onChanged: (age) {
                        setState(() {
                          this.age = age;
                        });
                      },
                    ), */
                    SizedBox(
                      height: 8,
                    ),
                    _GenderField(
                      gender: Gender.MALE,
                      onChanged: (gender) {
                        setState(() {
                          this.gender = gender;
                        });
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    /*
                    _RideField(
                      rides: this.rides,
                      onChanged: (rides) {
                        setState(() {
                          this.rides = rides;
                        });
                      },
                    ),
                    SizedBox(
                      height: 28,
                    ),
                     */
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isButtonEnabled() {
    return firstName.isNotEmpty && lastName.isNotEmpty;
  }
}

class _AvatarField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
        padding: EdgeInsets.all(10),
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
          depth: NeumorphicTheme.embossDepth(context),
        ),
        child: Icon(
          Icons.insert_emoticon,
          size: 120,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }
}

class _AgeField extends StatelessWidget {
  final double? age;
  final ValueChanged<double>? onChanged;

  _AgeField({this.age, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Age",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: NeumorphicSlider(
                  min: 8,
                  max: 75,
                  value: age!,
                  onChanged: (value) {
                    onChanged!(value);
                  },
                ),
              ),
            ),
            Text("${age!.floor()}"),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}

class _TextField extends StatefulWidget {
  final String? label;
  final String? hint;

  final ValueChanged<String>? onChanged;

  _TextField({@required this.label, @required this.hint, this.onChanged});

  @override
  __TextFieldState createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  TextEditingController? _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.hint);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            widget.label!,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: NeumorphicTheme.defaultTextColor(context),
            ),
          ),
        ),
        Neumorphic(
          margin: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 4),
          style: NeumorphicStyle(
            depth: NeumorphicTheme.embossDepth(context),
            boxShape: NeumorphicBoxShape.stadium(),
          ),
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          child: TextField(
            onChanged: widget.onChanged,
            controller: _controller,
            decoration: InputDecoration.collapsed(hintText: widget.hint),
          ),
        )
      ],
    );
  }
}

class _GenderField extends StatelessWidget {
  final Gender gender;
  final ValueChanged<Gender> onChanged;

  const _GenderField({
    required this.gender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
          child: Text(
            "Others",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 12),
            NeumorphicRadio(
              // groupValue: gender,
              padding: EdgeInsets.all(20),
              style: NeumorphicRadioStyle(
                unselectedColor: MyColors.caribbeanGreenTint7,
                unselectedDepth: 2,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              value: Gender.MALE,
              child: Icon(Icons.facebook),
              onChanged: (value) => onChanged(value!),
            ),
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: gender,
              padding: EdgeInsets.all(20),
              style: NeumorphicRadioStyle(
                unselectedColor: MyColors.caribbeanGreenTint7,
                unselectedDepth: 2,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              value: Gender.FEMALE,
              child: Icon(Icons.phone),
              onChanged: (value) => onChanged(value!),
            ),
            SizedBox(width: 12),
            NeumorphicRadio(
              groupValue: gender,
              padding: EdgeInsets.all(20),
              style: NeumorphicRadioStyle(
                unselectedColor: MyColors.caribbeanGreenTint7,
                unselectedDepth: 2,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              value: Gender.NON_BINARY,
              child: Icon(Icons.supervised_user_circle),
              onChanged: (value) => onChanged(value!),
            ),
            SizedBox(
              width: 18,
            )
          ],
        ),
      ],
    );
  }
}
