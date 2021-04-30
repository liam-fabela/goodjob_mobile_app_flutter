import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
//const LatLng SOURCE_LOCATION = LatLng(8.499010,124.629230);
//const LatLng DEST_LOCATION = LatLng(8.512330, 124.617950);




class DynamicMap extends StatefulWidget {
  final double latSource;
  final double lngSource;
  final double latDest;
  final double lngDest;
  DynamicMap(this.latSource,this.lngSource, this.latDest, this.lngDest);
  @override
  _DynamicMapState createState() => _DynamicMapState();
}

class _DynamicMapState extends State<DynamicMap> {

   LatLng sourceLocation;
   LatLng destinationLocation;

   Completer<GoogleMapController> _controller = Completer();
   Set<Marker> _markers = {};
   Set<Polyline> _polylines = {};
   List<LatLng> polylineCoordinates = [];
   PolylinePoints polylinePoints = PolylinePoints();
   String googleAPIKey = "";

   BitmapDescriptor sourceIcon;
   BitmapDescriptor destinationIcon;

  
  @override
  void initState() {
   sourceLocation = LatLng(widget.latSource, widget.lngSource);
   destinationLocation = LatLng(widget.latDest, widget.lngDest);
   setSourceAndDestinationIcons();
    super.initState();
  }

  void setSourceAndDestinationIcons()async{
     sourceIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/pin_small.png');
     destinationIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/images/pin2_small.png');
     
   }

   void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
    setPolylines();
   }

   void setMapPins(){
    _markers.add(Marker(markerId: MarkerId('sourcePin'), position:  sourceLocation, icon: sourceIcon));
     _markers.add(Marker(markerId: MarkerId('destPin'), position:  destinationLocation, icon: destinationIcon));
    
   }

    setPolylines()async{
     List<PointLatLng> result =  await polylinePoints?.getRouteBetweenCoordinates(googleAPIKey,  sourceLocation.latitude,  sourceLocation.longitude, 
     destinationLocation.latitude,  destinationLocation.longitude);

     if(result.isNotEmpty){
       result.forEach((PointLatLng point){
         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
       });
     }
     setState(() {
       Polyline polyline = Polyline(
         polylineId: PolylineId("poly"),
         color: Color.fromARGB(255,40,122,198),
         points: polylineCoordinates
       );
       _polylines.add(polyline);
     });
   }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
      zoom: CAMERA_ZOOM,
      bearing: CAMERA_BEARING,
      tilt: CAMERA_TILT,
      target: sourceLocation
    );
    return Scaffold(
      appBar: AppBar(title: Text('Route Map'),),
      body: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          onMapCreated: onMapCreated,

      ),
    );
  }
}




class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
