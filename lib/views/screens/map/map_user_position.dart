// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/current_location_details.dart';
import '../../../utils/my_screensize.dart';
import '../../../utils/statusbar.dart';

class UserCurrentPostionScreen extends StatefulWidget {
  final CurrentLocationDetails currentLocationDetails;

  const UserCurrentPostionScreen(
      {super.key, required this.currentLocationDetails});

  @override
  State<UserCurrentPostionScreen> createState() =>
      _UserCurrentPostionScreenState();
}

class _UserCurrentPostionScreenState extends State<UserCurrentPostionScreen> {
  static late CameraPosition _kGooglePlex;
  Set<Marker> _markers = <Marker>{};
  Set<Marker> _markersDupe = <Marker>{};
  Completer<GoogleMapController> _controller = Completer();
  var tappedPoint;

  @override
  void initState() {
    super.initState();
    _mInitOperation();
  }

  @override
  Widget build(BuildContext context) {
    uCustomStatusBar(statusBarColor: Colors.transparent);
    return WillPopScope(
      onWillPop: () async {
        uCustomStatusBar();
        return true;
      },
      child: Scaffold(
        body: Container(
          height: MyScreenSize.mGetHeight(context, 100),
          width: MyScreenSize.mGetWidth(context, 100),
          child: GoogleMap(
            mapType: MapType.normal,
            markers: _markers,
            // polylines: _polylines,
            // circles: _circles,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: (point) {
              tappedPoint = point;
            },
          ),
        ),
      ),
    );
  }

  void _mInitOperation() async {
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.currentLocationDetails.lat!,
          widget.currentLocationDetails.long!),
      // zoom: 14.4746,
      zoom: 16,
    );
    _markers = {
      Marker(
          markerId: MarkerId('marker_id'),
          position: LatLng(widget.currentLocationDetails.lat!,
              widget.currentLocationDetails.long!),
          onTap: () {},
          icon: BitmapDescriptor.fromBytes(
              await getBytesFromAsset('assets/images/ic_my_position.png', 75)))
    };

    setState(() {});
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);

    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  _setMarker(LatLng point, String label, String types, String status) async {
    final Uint8List markerIcon;
    markerIcon =
        await getBytesFromAsset('assets/mapicons/local-services.png', 75);

    final Marker marker = Marker(
        markerId: MarkerId('marker_001'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.fromBytes(markerIcon));

    setState(() {
      _markers.add(marker);
    });
  }
}
