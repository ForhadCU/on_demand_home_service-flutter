import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thesis_project/views/screens/signUp/signup.dart';

void main() {
  mConfigureFlutter();
  runApp(const ProviderScope(child: MyApp()));
}

void mConfigureFlutter() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thesis Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        // brightness: Brightness.dark
      ),
      // home: const HomePage(),
      home: const SignUpScreen(),
    );
    
  }
}

// google api key: AIzaSyAo215TRl_Nkdp1t0m48C6rda_c9vRD_E4
