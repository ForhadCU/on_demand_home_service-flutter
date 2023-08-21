import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../const/constants.dart';

class SignInRepository{
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;


     Future<dynamic> mSignIn(
      {
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User user = userCredential.user!;

      // Sign-in successful, perform any necessary actions
      logger.d('User ID: ${user.uid}');
      logger.d('Email: ${user.email}');
      return user;
    } catch (e) {
      // Sign-in failed, handle the error
      String error = e.toString();
      logger.e('Sign-in error: $error');
      return error;
    }

  }
    static Future<bool> mCheckUniqueUserName(
      {required FirebaseFirestore firebaseFirestore,
      required String username}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection("USER").get();
    if (querySnapshot.size > 0) {
      for (var element in querySnapshot.docs) {
        if (element.get("username") == username) {
          logger.w("User name already exist");
          return false;
        }
      }
      logger.w("User name is Uinque");
      return true;
    } else {
      logger.w("User name is Uinque");
      return true;
    }
  }
    static bool mCheckUserVerified(
      {required FirebaseAuth firebaseAuth, required User user}) {
    // User? user = firebaseAuth.currentUser;
    if (user.emailVerified) {
      logger.i("Email is verified");
      return true;
    } else {
      logger.w("Email is not verified");
      return false;
    }
  }
    static User? mCheckUserSignInStatus({required FirebaseAuth firebaseAuth}) {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      // User is already signed in
      // Perform any necessary actions for a signed-in user
      if (mCheckUserVerified(firebaseAuth: firebaseAuth, user: user)) {
        logger.i('User is signed in with the following details:');
        logger.i('User ID: ${user.uid}');
        logger.i('Email: ${user.email}');
        return user;
      } else {
        return null;
      }
    } else {
      // User is not signed in
      // Perform any necessary actions for a non-signed-in user
      logger.w('User is not signed in');
      return null;
    }
  }
}