import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPagePageState createState() => _MapPagePageState();
}

class _MapPagePageState extends State<MapPage> {
  LatLng _initialCameraPosition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  final Map<String, Marker> _markers = {};

  var locations = [
    {
      "name": "Uluru",
      "description": "Also known as Ayers rock",
      "lat": "23.745990",
      "lon": "100.315722"
    },
    {
      "name": "Mt. Everest",
      "description": "Located in the himalayas",
      "lat": "33.745990",
      "lon": "80.315722"
    }
  ];

  void _onMapCreated(GoogleMapController _cntlr) {
    final fakeLocations = locations;
    setState(() {
      _markers.clear();
      for (final office in fakeLocations) {
        final marker = Marker(
          markerId: MarkerId(office['name']),
          position:
              LatLng(double.parse(office['lat']), double.parse(office['lon'])),
          infoWindow:
              InfoWindow(title: office['name'], snippet: office['description']),
        );
        _markers[office['name']] = marker;
      }
      // print(_markers);
    });
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) async {
      //to avoid exception while moving camera
      await _controller.getVisibleRegion();
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MapView")),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialCameraPosition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: _markers.values.toSet(),
            )
          ],
        ),
      ),
    );
  }
}
