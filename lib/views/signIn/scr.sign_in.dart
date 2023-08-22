// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/models/booking.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/utils/statusbar.dart';
import 'package:thesis_project/view_models/vm_common.dart';
import 'package:thesis_project/view_models/vm_singin.dart';
import 'package:thesis_project/views/bookings/scr.bookings.dart';
import 'package:thesis_project/views/screens/admin_panel/scr_admin_panel.dart';
import 'package:thesis_project/views/screens/setLocation/set_location.dart';
import 'package:thesis_project/views/screens/signUp/signup.dart';
import 'package:thesis_project/views/signIn/widgets/top_bar.dart';

import '../../const/keywords.dart';
import '../../models/provider_dataset.dart';
import '../../utils/theme_configurator.dart';
import '../screens/admin_panel/pages/provider_data.dart';

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
  String username = "";
  String pass = "";
  double age = 12;
  late Gender gender;
  Set<String> rides = Set();

  bool isRememberd = false;

  var _isSigning = false;

  var _signInViewModel = SignInViewModel();
  var _commonViewModel = CommonViewmodel();

  @override
  Widget build(BuildContext context) {
    uCustomStatusBar(
      statusBarColor: MyColors.caribbeanGreenTint7,
      statusBarBrightness: Brightness.dark,
    );
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
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUpScreen();
                          }));
                        },
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        style: NeumorphicStyle(
                            depth: 0, color: MyColors.caribbeanGreenTint7),
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
                    Column(
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
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(24)),
                            depth: -4,
                            intensity: 0.8,
                            // color: MyColors.caribbeanGreenTint7,
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              username = value;
                            },
                            cursorColor: MyColors.vividCerulean,
                            style: TextStyle(color: MyColors.vividCerulean),
                            decoration: InputDecoration(
                              // hintText: 'Enter your text...',
                              // hintText: 'Enter your email',
                              hintStyle:
                                  TextStyle(color: MyColors.spaceCadetTint5),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
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
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(24)),
                            depth: -4,
                            intensity: 0.9,
                            // color: MyColors.caribbeanGreenTint7,
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            onChanged: (value) {
                              pass = value;
                            },
                            obscureText: true,
                            cursorColor: MyColors.vividCerulean,
                            style: TextStyle(color: MyColors.vividCerulean),
                            decoration: InputDecoration(
                              // hintText: 'Enter your text...',
                              // hintText: 'Enter your password',
                              hintStyle:
                                  TextStyle(color: MyColors.spaceCadetTint5),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 16),
                            ),
                          ),
                        )
                      ],
                    ),

                    /*  _TextField(
                      label: "Password",
                      hint: "",
                      onChanged: (lastName) {
                        setState(() {
                          this.pass = lastName;
                        });
                      },
                    ), */
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GFCheckbox(
                            activeBgColor: MyColors.caribbeanGreen,
                            activeIcon: const Icon(Icons.check,
                                size: 8, color: GFColors.WHITE),
                            size: 14,
                            onChanged: (value) {
                              setState(() {
                                isRememberd = !isRememberd;
                              });
                            },
                            value: isRememberd),
                        const Text("Do you want to save this session?")
                      ],
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          _isSigning = true;
                        });

                        await Future.delayed(Duration(seconds: 1));
                        if (username == "admin") {
                          logger.w("Admin");
                          /* Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AdminPanelScreen();
                          })); */
                          List<ProviderDataset> list = await _commonViewModel
                              .mGetPorviderDatasetFromJson(context: context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProviderDataPage(providerDatasetList: list);
                          }));
                        } else if (username.contains("user")) {
                          logger.w("User");
                          // c: Generate dataset
                          /*   List<ProviderDataset> list =
                              await _signInViewModel.mGenerateProviderDataset(); */
                          List<ProviderDataset> list = await _commonViewModel
                              .mGetPorviderDatasetFromJson(context: context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return SetLocationScreen(
                              userName: username,
                              providerDatasetList: list,
                              // providerDatasetList: [],
                            );
                          }));
                        } else {
                          logger.w("Provider");
                          List<ProviderDataset> list = await _commonViewModel
                              .mGetPorviderDatasetFromJson(context: context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return SetLocationScreen(
                              provider: "Ok",
                              userName: username,
                              providerDatasetList: list,
                              // providerDatasetList: [],
                            );
                          }));
                        }
                      },
                      child: _isSigning
                          ? GFLoader(
                              size: 20,
                              type: GFLoaderType.ios,
                            )
                          : Neumorphic(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              style: NeumorphicStyle(
                                  color: MyColors.caribbeanGreenTint7,
                                  depth: 5),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: MyColors.spaceCadetTint1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
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
    return username.isNotEmpty && pass.isNotEmpty;
  }

  mSaveSessionStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool(sessionStatus, isRememberd);
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
