import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapLocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapLocation();
  }
}

class _MapLocation extends State<MapLocation> {
  Future<LatLng> getLocation() async {
    double latitude = 0;
    double longitude = 0;
    var location = new Location();
    var current = await location.getLocation();
    latitude = current["latitude"];
    longitude = current["longitude"];
    LatLng center = LatLng(latitude, longitude);
    return center;
  }

  GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapTypeButtonPressed() {
    if (_currentMapType == MapType.normal) {
      mapController.updateMapOptions(
        GoogleMapOptions(mapType: MapType.satellite),
      );
      _currentMapType = MapType.satellite;
    } else {
      mapController.updateMapOptions(
        GoogleMapOptions(mapType: MapType.normal),
      );
      _currentMapType = MapType.normal;
    }
  }

  void _onAddMarkerButtonPressed() {
    mapController.addMarker(
      MarkerOptions(
        position: LatLng(
          mapController.cameraPosition.target.latitude,
          mapController.cameraPosition.target.longitude,
        ),
        infoWindowText: InfoWindowText(
            'Location',
            'latitude - ' +
                mapController.cameraPosition.target.latitude.toString() +
                ' longitude - ' +
                mapController.cameraPosition.target.longitude.toString()),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<LatLng>(
        future: getLocation(),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.red)));
            case ConnectionState.done:
              return MaterialApp(
                home: Scaffold(
                  body: Stack(
                    children: <Widget>[
                      GoogleMap(
                        onMapCreated: _onMapCreated,
                        options: GoogleMapOptions(
                          trackCameraPosition: true,
                          cameraPosition: CameraPosition(
                            target: snapshots.hasData
                                ? snapshots.data
                                : LatLng(0, 0),
                            zoom: 18.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            children: <Widget>[
                              FloatingActionButton(
                                onPressed: _onMapTypeButtonPressed,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                backgroundColor: Colors.green,
                                child: const Icon(Icons.map, size: 36.0),
                              ),
                              const SizedBox(height: 16.0),
                              FloatingActionButton(
                                onPressed: _onAddMarkerButtonPressed,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                backgroundColor: Colors.green,
                                child:
                                    const Icon(Icons.add_location, size: 36.0),
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            default:
          }
        });
  }
}
