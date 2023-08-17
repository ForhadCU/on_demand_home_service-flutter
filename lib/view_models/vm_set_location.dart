import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../const/constants.dart';
import '../models/current_location_details.dart';
import '../models/reverse_geocode_loc_details.dart';
import '../repository/repo_set_location.dart';

class SetLocationViewModel {
  final SetLocationRepo _setLocationRepo = SetLocationRepo();
  Future<CurrentLocationDetails?> mManageLocAccessAndFetchCurrentPos() async {
    bool isLocationAccessGranted = await mCheckLocationPermission();
    CurrentLocationDetails? _currentLocationDetails;
    // _isLocationAccessGranted = false;
    if (!isLocationAccessGranted) {
      // _vShowLocationPermissionDialog();
      await mRequestLocationPermission().then((isGranted) async {
        isGranted
            ? {
                await mGetCurrentLocationDetails().then((result) {
                  if (result != null) {
                    logger.d(
                        "1. My current lat: ${result.lat}, My current long: ${result.long}, My current location: ${result.formattedAdress}");
                    _currentLocationDetails = result;
                  }
                })
              }
            : null;
      });
    } else {
      await mGetCurrentLocationDetails().then((result) {
        if (result != null) {
          logger.d(
              "2. My current lat: ${result.lat}, My current long: ${result.long}, My current location: ${result.formattedAdress}");
          _currentLocationDetails = result;
        }
      });
    }

    return _currentLocationDetails;
  }

  Future<bool> mCheckLocationPermission() async {
    PermissionStatus status = await _setLocationRepo.mCheckLocationPermission();
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
        await _setLocationRepo.mRequestLocationPermission();

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
    Position? position = await _setLocationRepo.mGetCurrentPostion();
    double lat;
    double long;
    String formattedAdress;
    String placeId;
    CurrentLocationDetails? currentLocationDetails;
    bool _isLocationAccessGranted;

    logger.d("Position: $position");

    if (position == null) {
      return null;
    } else {
      lat = position.latitude;
      long = position.longitude;
      Map<String, String>? res = await mGetPlaceName(lat, long);
      logger.d(res);
      res != null
          ? {
              formattedAdress = res["placeName"]!,
              placeId = res["placeId"]!,
              currentLocationDetails = CurrentLocationDetails(
                  lat: lat, long: long, formattedAdress: formattedAdress),
            }
          : null;
    }

    return currentLocationDetails;
  }

  Future<Map<String, String>?> mGetPlaceName(
      double latitude, double longitude) async {
    // List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    logger.w("Wait. Getting Place Name...");
    logger.i(latitude);
    logger.i(longitude);
    String? placeName;
    String? placeId;
    List<ReverseGeocodeLocDetails> listReverseGeocodeLocDetails =
        await _setLocationRepo.mGetPlaceName(latitude, longitude);
    logger.i("L: ${listReverseGeocodeLocDetails.length}");

    for (var element in listReverseGeocodeLocDetails) {
      if (element.formattedAddress!.contains("CRX") ||
          element.formattedAddress!.contains("Unnamed")) {
        // c: avoid unknown place names
        continue;
      } else {
        logger.d("My current place name is: ${element.formattedAddress}");
        placeName = element.formattedAddress;
        placeId = element.placeId;
        break;
      }
    }

    return {"placeName": placeName!, "placeId": placeId!};
  }
}
