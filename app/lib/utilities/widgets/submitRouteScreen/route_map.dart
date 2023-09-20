
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:followme/utilities/icons/custom_marker_icon.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
import 'package:followme/screens/submit_route_screen.dart';

//import 'package:flutter_icons/flutter_icons.dart';

class RouteSelectionWidget extends StatefulWidget {
  @override
  _RouteSelectionWidgetState createState() => _RouteSelectionWidgetState();
}

var points = <LatLng>[];

class _RouteSelectionWidgetState extends State<RouteSelectionWidget> {
  final PopupController _popupController = PopupController();
  final MapController _mapController = MapController();
  String routeSelection = "Add your route points";
  double addedPoints = 0;
  late Position startingPosition;
  final double _zoom = 7;
  final List<LatLng> _latLngList = [];
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
    return Scaffold(
      appBar: AppBar(
        title: Text(routeSelection),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_forward,
        ),
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubmitRouteScreen(), settings: RouteSettings(
              arguments: points,
            ),
            ),
          );
        },
      ),
      body: FutureBuilder(
          future: _determinePosition(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.hasData) {
              List<LatLng> from = [
                LatLng(snapshot.data!.latitude, snapshot.data!.longitude)
              ];

              return Column(
                children: [
                  Expanded(
                    child: FlutterMap(

                        mapController: _mapController,
                        options: MapOptions(
                          // swPanBoundary: LatLng(13, 77.5),
                          // nePanBoundary: LatLng(13.07001, 77.58),
                          center: LatLng(snapshot.data!.latitude,
                              snapshot.data!.longitude),
                          bounds: LatLngBounds.fromPoints(from),
                          zoom: _zoom,
                          onTap: (latlng) {
                            setState(() {
                              _markers.add(
                                Marker(
                                    point: latlng,
                                    width: 60,
                                    height: 60,
                                    builder: (context) => Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Container(
                                                margin: EdgeInsets.all(5),
                                                // Modify this till it fills the color properly
                                                color: Colors.white, // Color
                                              ),
                                            ),
                                            const Icon(
                                              CustomIcon.location_circled,
                                              size: 60,
                                              color: Colors.orange,
                                            ),
                                          ],
                                        )),
                              );
                              points.add(
                                LatLng(latlng.latitude, latlng.longitude),
                              );
                            });
                          },

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
                          MarkerLayerOptions(
                            markers: _markers,
                          ),
                          PolylineLayerOptions(
                            polylines: [
                              Polyline(points: [
                                for (int i = 0; i < points.length; i++)
                                  points[i]
                              ], strokeWidth: 4.0, color: Colors.orange),
                            ],
                          ),
                        ]),
                  ),

                  Text('Your waypoints'),
                  Expanded(
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: points.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 50,
                              child: Center(
                                  child: Text(
                                      'Lat: ${points[index].latitude.toString()} Long: ${points[index].longitude.toString()}')),
                            );
                          }),
                    ),
                  ),

                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}


/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    // Use location.
    serviceEnabled = true;
  }

  // Test if location services are enabled.
  serviceEnabled = await Permission.locationWhenInUse.serviceStatus.isEnabled;
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
