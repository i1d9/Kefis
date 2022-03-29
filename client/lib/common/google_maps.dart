import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{Marker(
      markerId: 1,
      position: LatLng(
        20.0,
        2.0,
      )
    )};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition center = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-1.286389, 36.817223),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: center,
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

        },
      )
    );
  }

  
  
}