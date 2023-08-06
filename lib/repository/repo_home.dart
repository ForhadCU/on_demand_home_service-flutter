import 'dart:convert' as convert;
import 'dart:math';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/models/provider.dart';
import 'package:thesis_project/utils/constants.dart';

import '../models/reverse_geocode_loc_details.dart';

class HomeRepository {
  Future<Position?> mGetCurrentPostion() async {
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

  Future<PermissionStatus> mRequestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    return status;
  }

  Future<PermissionStatus> mCheckLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    return status;
  }

  Future<List<ReverseGeocodeLocDetails>> mGetPlaceName(double latitude, double longitude) async {
    String? result;

    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude, $longitude&key=${MyConstants.googleApiKey}';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    List results = json['results'] as List;

   List<ReverseGeocodeLocDetails> list =
        results.map((e) => ReverseGeocodeLocDetails.fromJson(e)).toList();

    return list;
  }
}

/* Future<void> fetchUserLocation() async {
  final Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  setState(() {
    _locationInfo =
        'Latitude: ${position.latitude}\nLongitude: ${position.longitude}';
  });
} */
