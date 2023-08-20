import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thesis_project/models/current_location_details.dart';
import 'package:thesis_project/repository/repo_home.dart';

import '../const/constants.dart';
import '../const/keywords.dart';
import '../models/provider_dataset.dart';
import '../models/reverse_geocode_loc_details.dart';
import 'package:http/http.dart' as http;

class HomeViewModel {
  final HomeRepository _homeRepository = HomeRepository();
  String? mGetServiceCatIcon({required String serviceCategory}) {
    switch (serviceCategory) {
      case acRepair:
        return "assets/images/ic_ac_repair.png";
      case paintings:
        return "assets/images/ic_painting.png";
      case electronics:
        return "assets/images/ic_electronics.png";
      case cleaning:
        return "assets/images/ic_cleaning.png";
      case beauty:
        return "assets/images/ic_beauty.png";
      case plumbing:
        return "assets/images/ic_plumber.png";
      case shifting:
        return "assets/images/ic_shifting.png";
      case tutor:
        return "assets/images/ic_tutor.png";
      case barber:
        return "assets/images/ic_barabr.png";
      default:
        return null;
    }
  }

  String mMakeGreetings() {
    int hour = DateTime.now().hour;

    if (hour < 12) {
      return "Morning";
    } else if (hour < 17) {
      return "Afternoon";
    } else {
      return "Evening";
    }
  }

  Future<CurrentLocationDetails?> mManageLocAccessAndFetchCurrentPos() async {
    bool isLocationAccessGranted = await mCheckLocationPermission();
    CurrentLocationDetails? _currentLocationDetails;
    // _isLocationAccessGranted = false;
    if (!isLocationAccessGranted) {
      // _vShowLocationPermissionDialog();
      await mRequestLocationPermission().then((isGranted) async {
        isGranted
            ? {
                await mGetCurrentLocationDetails()
                    .then((currentLocationDetails) {
                  if (currentLocationDetails != null) {
                    logger.d(
                        "1. My current lat: ${currentLocationDetails.lat}, My current long: ${currentLocationDetails.long}, My current location: ${currentLocationDetails.formattedAdress}");

                    _currentLocationDetails = currentLocationDetails;
                  }
                })
              }
            : null;
      });
    } else {
      await mGetCurrentLocationDetails().then((currentLocationDetails) {
        if (currentLocationDetails != null) {
          logger.d(
              "2. My current lat: ${currentLocationDetails.lat}, My current long: ${currentLocationDetails.long}, My current location: ${currentLocationDetails.formattedAdress}");
          _currentLocationDetails = currentLocationDetails;
        }
      });
    }

    return _currentLocationDetails;
  }

  Future<bool> mCheckLocationPermission() async {
    PermissionStatus status = await _homeRepository.mCheckLocationPermission();
    bool isGranted = false;

    if (status.isGranted) {
      logger.i('Location permission is granted.');
      isGranted = true;
    } else if (status.isDenied) {
      logger.i('Location permission is denied.');
      isGranted = false;
    } else if (status.isPermanentlyDenied) {
      logger.i('Location permission is permanently denied.');
      isGranted = false;
    } else if (status.isRestricted) {
      logger.i('Location permission is restricted.');
      isGranted = false;
    } else if (status.isLimited) {
      logger.i('Location permission is limited.');
      isGranted = false;
    }

    return isGranted;
  }

  Future<bool> mRequestLocationPermission() async {
    PermissionStatus status =
        await _homeRepository.mRequestLocationPermission();

    if (status.isGranted) {
      print('Location permission granted.');
      return true;
      // You can proceed with using location services here
    } else if (status.isDenied) {
      print('Location permission denied by user.');
      return false;
    } else if (status.isPermanentlyDenied) {
      print('Location permission permanently denied by user.');
      return false;
    } else {
      return false;
    }
  }

  Future<CurrentLocationDetails?> mGetCurrentLocationDetails() async {
    Position? position = await _homeRepository.mGetCurrentPostion();
    double lat;
    double long;
    String formattedAdress;
    CurrentLocationDetails? currentLocationDetails;
    bool _isLocationAccessGranted;

    if (position == null) {
      return null;
    } else {
      lat = position.latitude;
      long = position.longitude;
      String? res = await mGetPlaceName(lat, long);
      res != null
          ? {
              formattedAdress = res,
              currentLocationDetails = CurrentLocationDetails(
                  lat: lat, long: long, formattedAdress: formattedAdress),
            }
          : null;
    }

    return currentLocationDetails;
  }

  Future<String?> mGetPlaceName(double latitude, double longitude) async {
    // List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    logger.w("Wait. Getting Place Name...");
    String? placeName;
    List<ReverseGeocodeLocDetails> listReverseGeocodeLocDetails =
        await _homeRepository.mGetPlaceName(latitude, longitude);

    for (var element in listReverseGeocodeLocDetails) {
      if (element.formattedAddress!.contains("CRX") ||
          element.formattedAddress!.contains("Unnamed")) {
        // c: avoid unknown place names
        continue;
      } else {
        logger.d("My current place name is: ${element.formattedAddress}");
        placeName = element.formattedAddress;
        break;
      }
    }

    return placeName;
  }

}
