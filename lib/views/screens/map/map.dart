// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:ui' as ui;

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:thesis_project/const/constants.dart';
import 'package:thesis_project/const/keywords.dart';
import 'package:thesis_project/models/provider.dart';
import 'package:thesis_project/utils/constants.dart';
import 'package:thesis_project/utils/my_colors.dart';
import 'package:thesis_project/views/screens/profile/scr_provider_profile.dart';

import '../../../models/auto_complete_result.dart';
import '../../../models/current_location_details.dart';
import '../../../models/provider_dataset.dart';
import '../../../repository/repo_map_services.dart';
import '../../../repository/repo_search_places.dart';

class MapScreen extends ConsumerStatefulWidget {
  final CurrentLocationDetails currentLocationDetails;
  final String serviceCategory;
  final double searchRange;
  final List<ProviderDataset> providerDataSetList;
  const MapScreen(
      {required this.providerDataSetList,
      required this.currentLocationDetails,
      required this.serviceCategory,
      required this.searchRange,
      Key? key})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Logger _logger = Logger();

//Debounce to throttle async calls during search
  Timer? _debounce;

//Toggling UI as we need;
  bool searchToggle = false;
  bool radiusSlider = false;
  // bool radiusSlider = true;
  bool cardTapped = false;
  bool pressedNear = false;
  // bool pressedNear = true;
  bool getDirections = false;

//Markers set
  Set<Marker> _markers = <Marker>{};
  Set<Marker> _markersDupe = <Marker>{};

  Set<Polyline> _polylines = Set<Polyline>();
  int markerIdCounter = 1;
  int polylineIdCounter = 1;

  var radiusValue;

  var tappedPoint;

  List allFavoritePlaces = [];

  String tokenKey = '';

  // //Page controller for the nice pageview
  late PageController _pageController;
  int prevPage = 0;

  var tappedPlaceDetail;
  String placeImg = '';
  var photoGalleryIndex = 0;
  bool showBlankCard = false;
  bool isReviews = true;
  bool isPhotos = false;

  var selectedPlaceDetails;

//Circle
  Set<Circle> _circles = Set<Circle>();

//Text Editing Controllers
  TextEditingController searchController = TextEditingController();
  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

//Initial map position on load
  static late CameraPosition _kGooglePlex;

  // late ServiceProvider tappedProviderDetails;
  late ProviderDataset tappedProviderDetails;

  @override
  void initState() {
    _mInit();
    _mInitOperation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    //Providers
    final placeResults = ref.watch(placeResultsProvider);
    final searchFlag = ref.watch(searchToggleProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: _markers,
                    polylines: _polylines,
                    circles: _circles,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onTap: (point) {
                      tappedPoint = point;
                      // _setCircle(point);
                      _setCircle(point);
                    },
                  ),
                ),
                searchToggle
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
                        child: Column(children: [
                          Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: _vSearchInput(searchFlag, placeResults),
                          )
                        ]),
                      )
                    : Container(),
                searchFlag.searchToggle
                    ? placeResults.allReturnedResults.isNotEmpty
                        ? Positioned(
                            top: 100.0,
                            left: 15.0,
                            child: Container(
                              height: 200.0,
                              width: screenWidth - 30.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.7),
                              ),
                              child: ListView(
                                children: [
                                  ...placeResults.allReturnedResults
                                      .map((e) => buildListItem(e, searchFlag))
                                ],
                              ),
                            ))
                        : Positioned(
                            top: 100.0,
                            left: 15.0,
                            child: Container(
                              height: 200.0,
                              width: screenWidth - 30.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white.withOpacity(0.7),
                              ),
                              child: Center(
                                child: Column(children: [
                                  Text('No results to show',
                                      style: TextStyle(
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(height: 5.0),
                                  Container(
                                    width: 125.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        searchFlag.toggleSearch();
                                      },
                                      child: Center(
                                        child: Text(
                                          'Close this',
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontFamily: 'WorkSans',
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ))
                    : Container(),
                getDirections
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5),
                        child: Column(children: [
                          Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _originController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  border: InputBorder.none,
                                  hintText: 'Origin'),
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              controller: _destinationController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  border: InputBorder.none,
                                  hintText: 'Destination',
                                  suffixIcon: Container(
                                      width: 96.0,
                                      child: Row(
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                var directions =
                                                    await MapServices()
                                                        .getDirections(
                                                            _originController
                                                                .text,
                                                            _destinationController
                                                                .text);
                                                _markers = {};
                                                _polylines = {};
                                                gotoPlace(
                                                    directions['start_location']
                                                        ['lat'],
                                                    directions['start_location']
                                                        ['lng'],
                                                    directions['end_location']
                                                        ['lat'],
                                                    directions['end_location']
                                                        ['lng'],
                                                    directions['bounds_ne'],
                                                    directions['bounds_sw']);
                                                _setPolyline(directions[
                                                    'polyline_decoded']);
                                              },
                                              icon: Icon(Icons.search)),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  getDirections = false;
                                                  _originController.text = '';
                                                  _destinationController.text =
                                                      '';
                                                  _markers = {};
                                                  _polylines = {};
                                                });
                                              },
                                              icon: Icon(Icons.close))
                                        ],
                                      ))),
                            ),
                          )
                        ]),
                      )
                    : Container(),
                radiusSlider
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 0.0),
                        child: Container(
                          height: 50.0,
                          color: Colors.black.withOpacity(0.2),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Slider(
                                      max: 7000.0,
                                      min: 1000.0,
                                      value: radiusValue,
                                      onChanged: (newVal) {
                                        radiusValue = newVal;
                                        pressedNear = false;
                                        _setCircle(tappedPoint);
                                      })),
                              !pressedNear
                                  ?
                                  // v: radius bar's first icon
                                  IconButton(
                                      onPressed: () {
                                        if (_debounce?.isActive ?? false) {
                                          _debounce?.cancel();
                                        }
                                        _debounce = Timer(Duration(seconds: 2),
                                            () async {
                                          await _mDisplayAvailableUsers();
                                          /* 
                                          var placesResult = await MapServices()
                                              .getPlaceDetails(tappedPoint,
                                                  radiusValue.toInt());

                                          List<dynamic> placesWithin =
                                              placesResult['results'] as List;

                                          allFavoritePlaces = placesWithin;

                                          tokenKey =
                                              placesResult['next_page_token'] ??
                                                  'none';
                                          _markers = {};
                                          for (var element in placesWithin) {
                                            _setNearMarker(
                                              LatLng(
                                                  element['geometry']
                                                      ['location']['lat'],
                                                  element['geometry']
                                                      ['location']['lng']),
                                              element['name'],
                                              element['types'],
                                              element['business_status'] ??
                                                  'not available',
                                            );
                                          }
                                          _markersDupe = _markers;
                                          pressedNear = true;
                                         */
                                        });
                                      },
                                      icon: Icon(
                                        Icons.near_me,
                                        color: Colors.blue,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        if (_debounce?.isActive ?? false) {
                                          _debounce?.cancel();
                                        }
                                        _debounce = Timer(Duration(seconds: 2),
                                            () async {
                                          if (tokenKey != 'none') {
                                            var placesResult =
                                                await MapServices()
                                                    .getMorePlaceDetails(
                                                        tokenKey);

                                            List<dynamic> placesWithin =
                                                placesResult['results'] as List;

                                            allFavoritePlaces
                                                .addAll(placesWithin);

                                            tokenKey = placesResult[
                                                    'next_page_token'] ??
                                                'none';

                                            for (var element in placesWithin) {
                                              _setNearMarker(
                                                LatLng(
                                                    element['geometry']
                                                        ['location']['lat'],
                                                    element['geometry']
                                                        ['location']['lng']),
                                                element['name'],
                                                element['types'],
                                                element['business_status'] ??
                                                    'not available',
                                              );
                                            }
                                          } else {
                                            if (kDebugMode) {
                                              print('Thats all folks!!');
                                            }
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.more_time,
                                          color: Colors.blue)),
                              IconButton(
                                  onPressed: () {
                                    logger.w("Clicked");
                                    setState(() {
                                      radiusSlider = false;
                                      pressedNear = false;
                                      cardTapped = false;
                                      radiusValue = 3000.0;
                                      _circles = {};
                                      _markers = {};
                                      allFavoritePlaces = [];
                                    });
                                  },
                                  icon: Icon(Icons.close, color: Colors.red))
                            ],
                          ),
                        ),
                      )
                    : Container(),

                // v: Title Card (Slide)
                pressedNear
                    ? Positioned(
                        bottom: 20.0,
                        child: Container(
                          height: 200.0,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                              controller: _pageController,
                              // itemCount: allFavoritePlaces.length,
                              // itemCount: widget.providerDataSetList.length,
                              itemCount: widget.providerDataSetList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _nearbyPlacesList(index);
                              }),
                        ))
                    : Container(),

                // v: Expaded card (Flip)
                cardTapped
                    ? Positioned(
                        top: 100.0,
                        left: 15.0,
                        child: FlipCard(
                          front: Container(
                            // height: 250.0,
                            width: 185,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            child: SingleChildScrollView(
                              child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 150.0,
                                      width: 185,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                        ),
                                        /* image: DecorationImage(
                                        image: NetworkImage(placeImg != ''
                                            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$placeImg&key=$key'
                                            : 'https://pic.onlinewebfonts.com/svg/img_546302.png'),
                                        fit: BoxFit.cover), */
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                tappedProviderDetails.imgUri!),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(7.0),
                                      width: 185,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Address: ',
                                            style: TextStyle(
                                                fontFamily: 'WorkSans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                              width: 105.0,
                                              child: Text(
                                                /* tappedPlaceDetail[
                                                    'formatted_address'] ??
                                                'none given', */
                                                tappedProviderDetails.location!,
                                                style: TextStyle(
                                                    fontFamily: 'WorkSans',
                                                    fontSize: 11.0,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          7.0, 0.0, 7.0, 0.0),
                                      width: 185,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Contact: ',
                                            style: TextStyle(
                                                fontFamily: 'WorkSans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                              width: 105.0,
                                              child: Text(
                                                /* tappedPlaceDetail[
                                                    'formatted_phone_number'] */
                                                tappedProviderDetails.phone ??
                                                    'none given',
                                                style: TextStyle(
                                                    fontFamily: 'WorkSans',
                                                    fontSize: 11.0,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    NeumorphicButton(
                                      onPressed: () {
                                        _mGotoProfile();
                                      },
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 50),
                                      style: NeumorphicStyle(
                                          color: MyColors.caribbeanGreen),
                                      child: Text(
                                        "Profile",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    NeumorphicButton(
                                      onPressed: () {
                                        _mShowDirection();
                                      },
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 44),
                                      style: NeumorphicStyle(
                                          color: MyColors.vividCerulean),
                                      child: Text(
                                        "Direction",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                  ]),
                            ),
                          ),
                          back: Container(
                            height: 300.0,
                            width: 225.0,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.95),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isReviews = true;
                                            isPhotos = false;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 700),
                                          curve: Curves.easeIn,
                                          padding: EdgeInsets.fromLTRB(
                                              7.0, 4.0, 7.0, 4.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(11.0),
                                              color: isReviews
                                                  ? Colors.green.shade300
                                                  : Colors.white),
                                          child: Text(
                                            'Reviews',
                                            style: TextStyle(
                                                color: isReviews
                                                    ? Colors.white
                                                    : Colors.black87,
                                                fontFamily: 'WorkSans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isReviews = false;
                                            isPhotos = true;
                                          });
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 700),
                                          curve: Curves.easeIn,
                                          padding: EdgeInsets.fromLTRB(
                                              7.0, 4.0, 7.0, 4.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(11.0),
                                              color: isPhotos
                                                  ? Colors.green.shade300
                                                  : Colors.white),
                                          child: Text(
                                            'Photos',
                                            style: TextStyle(
                                                color: isPhotos
                                                    ? Colors.white
                                                    : Colors.black87,
                                                fontFamily: 'WorkSans',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // v: Reviews list
                                /*  Container(
                                  height: 250.0,
                                  child: isReviews
                                      ? ListView(
                                          children: [
                                            if (isReviews &&
                                                tappedPlaceDetail['reviews'] !=
                                                    null)
                                              ...tappedPlaceDetail['reviews']!
                                                  .map((e) {
                                                return _buildReviewItem(e);
                                              })
                                          ],
                                        )
                                      : _buildPhotoGallery(
                                          tappedPlaceDetail['photos'] ?? []),
                                ) */
                                Container(
                                  height: 250.0,
                                  child: isReviews
                                      ? _buildReviewItem()
                                      : Container(),
                                )
                              ],
                            ),
                          ),
                        ))
                    : Container()
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FabCircularMenu(
          alignment: Alignment.bottomLeft,
          fabColor: Colors.blue.shade50,
          fabOpenColor: Colors.red.shade100,
          ringDiameter: 250.0,
          ringWidth: 60.0,
          ringColor: Colors.blue.shade50,
          fabSize: 60.0,
          children: [
            _vSearchIconBtn(),
            _vNavigationIconBtn(),
          ]),
    );
  }

  void _setMarker(point) {
    var counter = markerIdCounter++;

    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker);

    setState(() {
      _markers.add(marker);
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$polylineIdCounter';

    polylineIdCounter++;

    _polylines.add(Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points.map((e) => LatLng(e.latitude, e.longitude)).toList()));
  }

  Future<void> _setCircle(LatLng point) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: 12.8)));
    setState(() {
      _circles.add(Circle(
          circleId: CircleId('raj'),
          center: point,
          fillColor: Colors.blue.withOpacity(0.1),
          radius: radiusValue,
          strokeColor: Colors.blue,
          strokeWidth: 1));
      getDirections = false;
      searchToggle = false;
      radiusSlider = true;
    });
  }

  // _setNearMarker(LatLng point, String label, List types, String status) async {
  _setNearMarker(
      LatLng point, String label, String types, String status) async {
    var counter = markerIdCounter++;

    final Uint8List markerIcon;

    /* if (types.contains('restaurants')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/restaurants.png', 75);
    } else if (types.contains('food')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/food.png', 75);
    } else if (types.contains('school')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/schools.png', 75);
    } else if (types.contains('bar')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/bars.png', 75);
    } else if (types.contains('lodging')) {
      markerIcon = await getBytesFromAsset('assets/mapicons/hotels.png', 75);
    } else if (types.contains('store')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/retail-stores.png', 75);
    } else if (types.contains('locality')) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else {
      markerIcon = await getBytesFromAsset('assets/mapicons/places.png', 75);
    } */

    if (types == acRepair) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else if (types == paintings) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else if (types == electronics) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else if (types == cleaning) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else if (types == beauty) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else if (types == plumbing) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else if (types == shifting) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else if (types == barber) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else if (types == tutor) {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    } else {
      markerIcon =
          await getBytesFromAsset('assets/mapicons/local-services.png', 75);
    }

    final Marker marker = Marker(
        markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.fromBytes(markerIcon));

    setState(() {
      _markers.add(marker);
    });
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

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      cardTapped = false;
      photoGalleryIndex = 1;
      showBlankCard = false;
      goToTappedPlace();
      // fetchImage();
    }
  }

  //Fetch image to place inside the tile in the pageView
  void fetchImage() async {
    if (_pageController.page !=
        null) if (allFavoritePlaces[_pageController.page!.toInt()]
            ['photos'] !=
        null) {
      setState(() {
        placeImg = allFavoritePlaces[_pageController.page!.toInt()]['photos'][0]
            ['photo_reference'];
      });
    } else {
      placeImg = '';
    }
  }

  // _buildReviewItem(review) {
  _buildReviewItem() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _vMockReviews(
              reviewerName: "User 039",
              ratings: 3.4,
              reviewText:
                  "The service is smooth and straightforward. My advisor was helpful",
              imageUri: "assets/images/provider4.jpeg"),
          _vMockReviews(
              reviewerName: "User 021",
              ratings: 4.5,
              reviewText:
                  "My provider was helpful. The service is smooth and straightforward. I would recommend deal direct",
              imageUri: "assets/images/provider1.jpg"),
          _vMockReviews(
              reviewerName: "User 034",
              ratings: 3.4,
              reviewText:
                  "I would recommend deal direct. The service is smooth and straightforward.",
              imageUri: "assets/images/provider3.jpeg"),
          _vMockReviews(
              reviewerName: "User 028",
              ratings: 4.9,
              reviewText:
                  "My provider was helpful. The service is smooth and straightforward. I would recommend deal direct",
              imageUri: "assets/images/provider5.jpg"),
        ],
      ),
    );
  }

  _vMockReviews({
    required String reviewerName,
    required double ratings,
    required String reviewText,
    required String imageUri,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Row(
            children: [
              Container(
                height: 35.0,
                width: 35.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  /* image: DecorationImage(
                      image: NetworkImage(review['profile_photo_url']),
                      fit: BoxFit.cover), */

                  image: DecorationImage(
                      image: AssetImage(imageUri), fit: BoxFit.fill),
                ),
              ),
              SizedBox(width: 4.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  width: 160.0,
                  child: Text(
                    // review['author_name'],
                    reviewerName,
                    style: TextStyle(
                        fontFamily: 'WorkSans',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 3.0),
                RatingStars(
                  // value: review['rating'] * 1.0,
                  value: ratings,
                  starCount: 5,
                  starSize: 7,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 9.0),
                  valueLabelRadius: 7,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: false,
                  valueLabelVisibility: true,
                  animationDuration: Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                  valueLabelMargin: const EdgeInsets.only(right: 4),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.amber.shade800,
                )
              ])
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              // review['text'],
              reviewText,
              style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        Divider(color: Colors.black26, height: 1.0)
      ],
    );
  }

  _buildPhotoGallery(photoElement) {
    if (photoElement == null || photoElement.length == 0) {
      showBlankCard = true;
      return Container(
        child: Center(
          child: Text(
            'No Photos',
            style: TextStyle(
                fontFamily: 'WorkSans',
                fontSize: 12.0,
                fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      var placeImg = photoElement[photoGalleryIndex]['photo_reference'];
      var maxWidth = photoElement[photoGalleryIndex]['width'];
      var maxHeight = photoElement[photoGalleryIndex]['height'];
      var tempDisplayIndex = photoGalleryIndex + 1;

      return Column(
        children: [
          SizedBox(height: 10.0),
          Container(
              height: 200.0,
              width: 200.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&maxheight=$maxHeight&photo_reference=$placeImg&key=${MyConstants.googleApiKey}'),
                      fit: BoxFit.cover))),
          SizedBox(height: 10.0),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  if (photoGalleryIndex != 0) {
                    photoGalleryIndex = photoGalleryIndex - 1;
                  } else {
                    photoGalleryIndex = 0;
                  }
                });
              },
              child: Container(
                width: 40.0,
                height: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: photoGalleryIndex != 0
                        ? Colors.green.shade500
                        : Colors.grey.shade500),
                child: Center(
                  child: Text(
                    'Prev',
                    style: TextStyle(
                        fontFamily: 'WorkSans',
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Text(
              '$tempDisplayIndex/' + photoElement.length.toString(),
              style: TextStyle(
                  fontFamily: 'WorkSans',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  if (photoGalleryIndex != photoElement.length - 1) {
                    photoGalleryIndex = photoGalleryIndex + 1;
                  } else {
                    photoGalleryIndex = photoElement.length - 1;
                  }
                });
              },
              child: Container(
                width: 40.0,
                height: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
                    color: photoGalleryIndex != photoElement.length - 1
                        ? Colors.green.shade500
                        : Colors.grey.shade500),
                child: Center(
                  child: Text(
                    'Next',
                    style: TextStyle(
                        fontFamily: 'WorkSans',
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ])
        ],
      );
    }
  }

  gotoPlace(double lat, double lng, double endLat, double endLng,
      Map<String, dynamic> boundsNe, Map<String, dynamic> boundsSw) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
        25));

    _setMarker(LatLng(lat, lng));
    _setMarker(LatLng(endLat, endLng));
  }

  Future<void> moveCameraSlightly() async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
            widget.providerDataSetList[_pageController.page!.toInt()].lat! +
                0.0125,
            widget.providerDataSetList[_pageController.page!.toInt()].long! +
                0.005)
        /* LatLng(
          
            allFavoritePlaces[_pageController.page!.toInt()]['geometry']
                    ['location']['lat'] +
                0.0125,
            allFavoritePlaces[_pageController.page!.toInt()]['geometry']
                    ['location']['lng'] +
                0.005) */
        ,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  _nearbyPlacesList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = (_pageController.page! - index);
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: () async {
          logger.d("tapped Slide card ");
          cardTapped = !cardTapped;
          if (cardTapped) {
            /* tappedPlaceDetail = await MapServices()
                .getPlaceById(allFavoritePlaces[index]['place_id']); */
            // tappedProviderDetails = widget.providerDataSetList[index];
            tappedProviderDetails = widget.providerDataSetList[index];
            setState(() {});
          }
          moveCameraSlightly();
        },
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                height: 125.0,
                width: 275.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0)
                    ]),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      /* _pageController.position.haveDimensions
                          ? _pageController.page!.toInt() == index
                              ?  */
                      Container(
                        height: 90.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                          /* image: DecorationImage(
                                        image: NetworkImage(placeImg != ''
                                            ? 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=$placeImg&key=$key'
                                            : 'https://pic.onlinewebfonts.com/svg/img_546302.png'),
                                        fit: BoxFit.cover), */
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.providerDataSetList[index].imgUri!),
                              fit: BoxFit.cover),
                        ),
                      ),
                      /* :  Container(
                        height: 90.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                            color: Colors.blue),
                      ),*/
                      // : Container(),
                      SizedBox(width: 5.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 170.0,
                            // child: Text(allFavoritePlaces[index]['name'],
                            child: Text(widget.providerDataSetList[index].name!,
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontFamily: 'WorkSans',
                                    fontWeight: FontWeight.bold)),
                          ),
                          RatingStars(
                            value:
                                /* widget.providerDataSetList[index].rating!.runtimeType == int
                                    ? allFavoritePlaces[index]['rating'] * 1.0
                                    : allFavoritePlaces[index]['rating'] ?? 0.0, */
                                widget.providerDataSetList[index].rating!,
                            starCount: 5,
                            starSize: 10,
                            valueLabelColor: const Color(0xff9b9b9b),
                            valueLabelTextStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'WorkSans',
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: 12.0),
                            valueLabelRadius: 10,
                            maxValue: 5,
                            starSpacing: 2,
                            maxValueVisibility: false,
                            valueLabelVisibility: true,
                            animationDuration: Duration(milliseconds: 1000),
                            valueLabelPadding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            valueLabelMargin: const EdgeInsets.only(right: 8),
                            starOffColor: const Color(0xffe7e8ea),
                            starColor: Colors.yellow,
                          ),
                          Container(
                            width: 170.0,
                            child: Text(
                              /* allFavoritePlaces[index]['business_status'] ??
                                  'none', */
                              // "Distance : 5 km",
                              "${widget.providerDataSetList[index].liveDistance!.toStringAsFixed(2)} km",
                              style: TextStyle(
                                  /* color: allFavoritePlaces[index]
                                              ['business_status'] ==
                                          'OPERATIONAL'
                                      ? Colors.blue
                                      : Colors.red, */
                                  color: Colors.blue,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> goToTappedPlace() async {
    final GoogleMapController controller = await _controller.future;

    _markers = {};

    // var selectedPlace = allFavoritePlaces[_pageController.page!.toInt()];
    var selectedProvider =
        widget.providerDataSetList[_pageController.page!.toInt()];

    _setNearMarker(
      LatLng(selectedProvider.lat!, selectedProvider.long!),
      selectedProvider.name ?? 'Provider 1',
      selectedProvider.category!,
      'none',
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(
          selectedProvider.lat!,
          selectedProvider.long!,
        ),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  Future<void> gotoSearchedPlace(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    _setMarker(LatLng(lat, lng));
  }

  Widget buildListItem(AutoCompleteResult placeItem, searchFlag) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
        onTapDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTap: () async {
          var place = await MapServices().getPlaceById(placeItem.placeId);
          logger.i(
              "Lat: ${place['geometry']['location']['lat']}, Long:${place['geometry']['location']['lng']}");
          gotoSearchedPlace(place['geometry']['location']['lat'],
              place['geometry']['location']['lng']);
          searchFlag.toggleSearch();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.green, size: 25.0),
            SizedBox(width: 4.0),
            Container(
              height: 40.0,
              width: MediaQuery.of(context).size.width - 75.0,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(placeItem.description ?? ''),
              ),
            )
          ],
        ),
      ),
    );
  }

  _vSearchIconBtn() {
    return IconButton(
        onPressed: () {
          setState(() {
            searchToggle = true;
            radiusSlider = false;
            pressedNear = false;
            cardTapped = false;
            getDirections = false;
          });
        },
        icon: Icon(Icons.search));
  }

  _vNavigationIconBtn() {
    return IconButton(
        onPressed: () {
          setState(() {
            searchToggle = false;
            radiusSlider = false;
            pressedNear = false;
            cardTapped = false;
            getDirections = true;
          });
        },
        icon: Icon(Icons.navigation));
  }

  vCloseBtn() {
    return;
  }

  _vSearchInput(SearchToggle searchFlag, PlaceResults allSearchResults) {
    return TextFormField(
      autofocus: true,
      controller: searchController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        border: InputBorder.none,
        hintText: 'Search',
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                searchToggle = false;

                searchController.text = '';
                _markers = {};
                if (searchFlag.searchToggle) {
                  searchFlag.toggleSearch();
                }
              });
            },
            icon: Icon(Icons.close)),
      ),
      onChanged: (value) {
        _logger.w(_debounce?.isActive ?? false);
        if (_debounce?.isActive ?? false) {
          _debounce?.cancel();
        }
        _debounce = Timer(Duration(milliseconds: 700), () async {
          if (value.length > 2) {
            if (!searchFlag.searchToggle) {
              searchFlag.toggleSearch();
              _markers = {};
            }

            List<AutoCompleteResult> searchResults =
                await MapServices().searchPlacesByName(value);

            allSearchResults.setResults(searchResults);
          } else {
            List<AutoCompleteResult> emptyList = [];
            allSearchResults.setResults(emptyList);
          }
        });
      },
    );
  }

  Future<void> _mDisplayAvailableUsers() async {
    // e: need to get available user details
    /*    var placesResult =
        await MapServices().getPlaceDetails(tappedPoint, radiusValue.toInt());

    List<dynamic> placesWithin = placesResult['results'] as List;

    // logger.d("PlaceDetails: $placesWithin");

    // allFavoritePlaces = placesWithin;
    // allFavoritePlaces = widget.providerDataSetList;


    tokenKey = placesResult['next_page_token'] ?? 'none'; */
    _markers = {
      Marker(
          markerId: MarkerId('marker_id'),
          position: LatLng(widget.currentLocationDetails.lat!,
              widget.currentLocationDetails.long!),
          onTap: () {},
          icon: BitmapDescriptor.fromBytes(
              await getBytesFromAsset('assets/images/ic_my_position.png', 75)))
    };

    /* for (var element in placesWithin) {
      // for (var element in widget.providerDataSetList) {
      _setNearMarker(
        /* LatLng(element['geometry']['location']['lat'],
            element['geometry']['location']['lng']), */
        LatLng(widget.currentLocationDetails.lat!,
            widget.currentLocationDetails.long!),
        // element['name'],
        widget.providerDataSetList[0].name!,
        widget.providerDataSetList[0].category!,
        // element['types'],
        'not available',
      );

      /*  LatLng(element.lat!, element.long!),
          element.name!,
          element.category!,
          element.id ?? "Not available");
      logger.d("Elelments: ${element.toJson()}"); */
    } */
    /*  for (var i = 0; i < widget.providerDataSetList.length; i++) {
      _setNearMarker(
        LatLng(widget.providerDataSetList[i].lat!, widget.providerDataSetList[i].long!),
        // LatLng(allFavoritePlaces[allFavoritePlaces.length - i]['geometry']['location']['lat'],
        //     allFavoritePlaces[allFavoritePlaces.length - i]['geometry']['location']['lng']),
        widget.providerDataSetList[i].name!,
        widget.providerDataSetList[i].category!,
        // element['types'],
        'not available',
      );
    } */
    for (var i = 0; i < widget.providerDataSetList.length; i++) {
      if (i%2 == 0) {
        _setNearMarker(
        LatLng(widget.providerDataSetList[i].lat! ,
            widget.providerDataSetList[i].long! ),
        // LatLng(allFavoritePlaces[allFavoritePlaces.length - i]['geometry']['location']['lat'],
        //     allFavoritePlaces[allFavoritePlaces.length - i]['geometry']['location']['lng']),
        widget.providerDataSetList[i].name!,
        widget.providerDataSetList[i].category!,
        // element['types'],
        'not available',
      );
      } else{
        _setNearMarker(
        LatLng(widget.providerDataSetList[i].lat! ,
            widget.providerDataSetList[i].long! ),
        // LatLng(allFavoritePlaces[allFavoritePlaces.length - i]['geometry']['location']['lat'],
        //     allFavoritePlaces[allFavoritePlaces.length - i]['geometry']['location']['lng']),
        widget.providerDataSetList[i].name!,
        widget.providerDataSetList[i].category!,
        // element['types'],
        'not available',
      );
      }
      
    }
    _markersDupe = _markers;
    pressedNear = true;
    // setState(() {});
  }

  void _mInitOperation() async {
    _pageController = PageController(initialPage: 1, viewportFraction: 0.85)
      ..addListener(_onScroll);
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.currentLocationDetails.lat!,
          widget.currentLocationDetails.long!),
      // zoom: 14.4746,
      zoom: 24,
    );

    tappedPoint = LatLng(widget.currentLocationDetails.lat!,
        widget.currentLocationDetails.long!);

    await _setCircle(tappedPoint);
    await _mDisplayAvailableUsers();
  }

  void _mGotoProfile() {
    Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
      return ProviderProfileScreen(
        providerDataset: tappedProviderDetails,
      );
    })));
  }

  void _mShowDirection() async {
    setState(() {
      searchToggle = false;
      radiusSlider = false;
      pressedNear = false;
      cardTapped = false;
      getDirections = true;
    });
    var directions = await MapServices().getDirectionsByPlaceId(
        originPlaceId: "ChIJk0oxlITHrTARw11nLQBaR30",
        destinationPlaceId: "ChIJVani2A24rTAREzuXbvDGc1g");
    _markers = {};
    _polylines = {};
    logger.d(directions);
    gotoPlace(
        widget.currentLocationDetails.lat!,
        widget.currentLocationDetails.long!,
        directions['end_location']['lat'],
        directions['end_location']['lng'],
        directions['bounds_ne'],
        directions['bounds_sw']);
    _setPolyline(directions['polyline_decoded']);
  }

  void _mInit() {
    radiusValue = widget.searchRange * 1000;
  }
}

/*  List<ServiceProvider> widget.providerDataSetList = [
  ServiceProvider(
    name: "Ashraful Islam",
    category: tutor,
    imgUri: "assets/images/provider1.jpg",
    rating: 4.8,
    numOfReview: 120,
    serviceFee: 450,
    location: "Chittagong University Road, Chittagong",
    lat: 22.4787345,
    long: 91.7942796,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Karimul Haque",
    category: paintings,
    imgUri: "assets/images/provider6.jpeg",
    rating: 3.5,
    numOfReview: 120,
    location: "Chikandandi, Chittagong",
    serviceFee: 450,
    lat: 22.4481407,
    long: 91.8224547,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Ahsan Ullah",
    category: acRepair,
    imgUri: "assets/images/provider1.jpg",
    rating: 4.8,
    numOfReview: 120,
    serviceFee: 450,
    location: "Aman Bazaar, N106, Chittagong",
    lat: 22.4213714,
    long: 91.82010129999999,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Diponkor Sheik",
    category: shifting,
    imgUri: "assets/images/provider4.jpeg",
    rating: 3.5,
    numOfReview: 120,
    location: "Baluchara, Chittagong",
    serviceFee: 450,
    lat: 22.4090162,
    long: 91.8178341,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Shariful Rahman",
    category: shifting,
    imgUri: "assets/images/provider4.jpeg",
    rating: 3.5,
    numOfReview: 120,
    location: "Jobra, Chittagong",
    serviceFee: 450,
    lat: 22.4875834,
    long: 91.8098954,
    phone: "01819682374",
  ),
  ServiceProvider(
    name: "Maruf Kabir",
    category: shifting,
    imgUri: "assets/images/provider4.jpeg",
    rating: 3.5,
    numOfReview: 120,
    location: "Baluchora, Chittagong",
    serviceFee: 450,
    lat: 21.4637269,
    long: 91.9915908,
    phone: "01819682374",
  ),
]; */
