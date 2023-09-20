import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:followme/consts/colors.dart';
import 'package:followme/controllers/routes_controller.dart';
import 'package:followme/controllers/session_controller.dart';
import 'package:followme/helpers/common/messages.dart';
import 'package:followme/model/route_model.dart';
import 'package:followme/model/session_model.dart';
import 'package:followme/providers/api_provider.dart';
import 'package:followme/screens/login_screen.dart';
import 'package:followme/utilities/icons/custom_marker_icon.dart';
import 'package:followme/utilities/providers/mapScreen/provider.dart';
import 'package:followme/utilities/widgets/progress_widget.dart';
import 'package:followme/utilities/widgets/searchScreen/search_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'mapScreen/route_info_modal_section_1.dart';
import 'mapScreen/route_info_modal_section_2.dart';

class MapWidget extends StatefulWidget {
  MapWidget({required this.routeId, Key? key, this.showSearchBar = false})
      : super(key: key);
  String routeId;
  final bool showSearchBar;

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  final PopupController _popupController = PopupController();
  final MapController _mapController = MapController();
  late Position startingPosition;
  final double _zoom = 7;
  late Future future;
  final List<LatLng> _latLngList = [];
  String markerRouteId="";
  List<Marker> _markers = [];
  @override
  void initState() {
    _markers = _latLngList
        .map((point) => Marker(
              point: point,
              width: 60,
              height: 60,
              builder: (context) => const Icon(
                CustomIcon.location_circled,
                size: 60,
                color: Colors.orange,
              ),
            ))
        .toList();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if (widget.routeId != "" || markerRouteId!="") {
      widget.routeId != "" ? future = RoutesController.getRouteById(widget.routeId) : future = RoutesController.getRouteById(markerRouteId);
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) => buildSheet(context));
      });
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildMap(),
        widget.showSearchBar ? buildFloatingSearchBar(context) : Container(),
      ],
    );
  }

  Widget _buildMap() {
    return Stack(
      children: [
        Scaffold(
            body: FutureBuilder(
                future: _determinePosition(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data[1].length; i++) {
                      double waypointLat = double.parse(
                          Map<String, dynamic>.from(
                                  snapshot.data[1][i].waypoints[0])
                              .values
                              .toList()[0]);
                      double waypointLng = double.parse(
                          Map<String, dynamic>.from(
                                  snapshot.data[1][i].waypoints[0])
                              .values
                              .toList()[1]);
                      Key name = Key(snapshot.data[1][i].name);
                      _markers.add(
                        Marker(
                          point: LatLng(waypointLat, waypointLng),
                          key: name,
                          width: 60,
                          height: 60,
                          builder: (context) => const Icon(
                            CustomIcon.location_circled,
                            size: 60,
                            color: Colors.orange,
                          ),

                        ),
                      );
                    }

                    List<LatLng> from = [
                      LatLng(snapshot.data[0]!.latitude,
                          snapshot.data[0]!.longitude)
                    ];
                    return FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          // swPanBoundary: LatLng(13, 77.5),
                          // nePanBoundary: LatLng(13.07001, 77.58),
                          center: LatLng(snapshot.data[0]!.latitude,
                              snapshot.data[0]!.longitude),
                          bounds: LatLngBounds.fromPoints(from),
                          zoom: _zoom,
                          plugins: [
                            MarkerClusterPlugin(),
                            TappablePolylineMapPlugin(),
                          ],
                        ),
                        layers: [
                          TileLayerOptions(
                            minZoom: 1,
                            maxZoom: 18,
                            backgroundColor: Colors.black,
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            subdomains: ['a', 'b', 'c'],
                          ),
                          MarkerClusterLayerOptions(
                            onMarkerTap:(marker) {
                              setState(() {
                                markerRouteId = marker.key.toString().substring(3,marker.key.toString().length - 3);
                              });
                            },
                            maxClusterRadius: 190,
                            disableClusteringAtZoom: 16,
                            size: Size(50, 50),
                            fitBoundsOptions: FitBoundsOptions(
                              padding: EdgeInsets.all(50),
                            ),
                            markers: [
                              for (int i = 0; i < _markers.length; i++)
                                _markers[i]
                            ],
                            polygonOptions: PolygonOptions(
                                borderColor: Colors.blueAccent,
                                color: Colors.black12,
                                borderStrokeWidth: 3),
                            builder: (context, markers) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle),
                                child: Text('${markers.length}'),
                              );
                            },
                          ),
                        ]);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })),
      ],
    );
  }

  Future<List<RouteModel>> _getRoutes() async {
    SessionModel session = await SessionController.readUserInfo();
    var result = await APIProvider.getRoutes(session.email, session.token);
    if (result == "expired") {
      SessionController.deleteSession();
      Navigator.of(context).pushAndRemoveUntil(
        // the new route
        MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen(),
        ),
        (Route route) => false,
      );
    }
    return result;
  }

  Widget buildSheet(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.8,
        builder: (_, controller) => ChangeNotifierProvider(
          create: (BuildContext context) => MapScreenProvider(),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: FutureBuilder(
                future: future,
                initialData: '',
                builder: (
                  BuildContext context,
                  AsyncSnapshot snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                          child: Center(
                            child: buildProgressOrange(),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      if (snapshot.data == "expired") {
                        SessionController.deleteSession();
                        Navigator.of(context).pushAndRemoveUntil(
                          // the new route
                          MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen(),
                          ),
                          (Route route) => false,
                        );
                        return Container();
                      } else {
                        final routes = snapshot.data[0];
                        return ListView(
                          controller: controller,
                          children: [
                            RouteInfoModalSection1(routes),
                            SizedBox(height: 20),
                            Row(
                              children: const [
                                Icon(Icons.circle,
                                    size: 10.0,
                                    color: FollowMeColors.primaryColor),
                                SizedBox(width: 10),
                                Text(
                                  "Photos",
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            RouteInfoModalSection2(routes)
                          ],
                        );
                      }
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return MessagesHandler.showInSnackBar(
                        "An error occurred", context);
                  }
                },
              )),
        ),
      );
    });
  }
}

class Waypoint {
  late double lat;
  late double lon;
  late String id;
}

Future getAllRoutes() async {
  var session = await SessionController.readUserInfo();
  var result = await RoutesController.getRoutes(session.email, session.token);
  return result;
}

Future<dynamic> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    // Use location.
    serviceEnabled = true;
  }

  // Test if location services are enabled.
  serviceEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;
  if (!serviceEnabled) {

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  var session = await SessionController.readUserInfo();
  var result = await RoutesController.getRoutes(session.email, session.token);
  var currentPosition = await Geolocator.getCurrentPosition();
  List<dynamic> data = [currentPosition, result];

  return data;
}

Widget buildFloatingSearchBar(BuildContext context) {
  final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

  return SearchBar(isPortrait: isPortrait);
}


