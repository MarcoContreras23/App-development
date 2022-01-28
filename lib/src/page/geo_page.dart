import 'dart:async';

import 'package:app_develop/src/page/data_geo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key? key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage>  {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers = new Set<Marker>();
  Location location = new Location();
  late LatLng _latLng;
  late dataGeo datageo;
  double altitud= dataGeo().altitud;
  double long = dataGeo().long;
  

  @override
  void initState() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      //Use current location
      _latLng = LatLng(35.16198 as double, -15.44765 as double);
      print('${currentLocation.latitude} - ${currentLocation.longitude}');

      markers.add(new Marker(
          markerId: MarkerId('geo-location'),
          position: _latLng,
          infoWindow: InfoWindow(title: 'Aca es donde vive miguel')));
      _moverCamara();
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  void _moverCamara() async {
    final GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            bearing: 0,
            tilt: 1.0,
            //target: LatLng(_locationData.latitude, _locationData.longitude),
            target: _latLng,
            //zoom: 17.5),
            zoom: 17.4),
      ),
    );
  }
  
  CameraPosition _kGooglePlex = CameraPosition(
    
    target: LatLng(35.16198, -5.44765),
    zoom: 1.4746,
  );

  @override
  Widget build(BuildContext context) {
    Map params = ModalRoute.of(context)?.settings.arguments as Map;
    double _lat = params['lat'];
    double _long = params['long'];
    markers.add(new Marker(
        markerId: MarkerId('geo-location'),
        position: LatLng(_lat, _long)));

    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps"),
      ),
      body: GoogleMap(
        markers: markers,
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
