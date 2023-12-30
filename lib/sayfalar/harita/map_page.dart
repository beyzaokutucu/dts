import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final LatLng _center = LatLng(39.94026774501402, 32.861662432551384);
  List<Marker> _markers = [];
  Set<Polygon> _polygons = {};
  List<LatLng> _polyCoords = [];

  @override
  void initState() {
    _polyCoords.add(_center);
    _polyCoords.add(LatLng(40.13270125933104, 30.00176511704922));
    _polygons.add(
      Polygon(
        zIndex: 100,
        consumeTapEvents: true,
        visible: true,
        geodesic: true,
        strokeWidth: 5,
        strokeColor: Colors.red,
        holes: [
          [_center]
        ],
        points: [
          LatLng(39, 32),
          LatLng(39.5, 32.2),
          LatLng(39.9, 32.5),
          LatLng(39.9, 33.5),
        ],
        fillColor: Colors.red.withOpacity(0.4),
        onTap: () {
          print("Polygon tapped");
        },
        polygonId: PolygonId('warningArea'),
      ),
    );

    _markers.addAll([
      Marker(
        markerId: MarkerId("markerAnkara"),
        draggable: true,
        position: _center,
        infoWindow: InfoWindow(
          title: "Ankara",
          onTap: () {
            print("Info window tapped");
          },
          snippet: "This is a nice city",
        ),
        onTap: () {
          print("Marker tapped");
        },
      ),
      Marker(
        markerId: MarkerId("markerBilecik"),
        position: LatLng(40.13270125933104, 30.00176511704922),
        onDrag: (latLng) {
          print(latLng);
        },
      ),
    ]);

    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map Page"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 12,
        ),
        markers: Set<Marker>.of(_markers),
        polygons: _polygons,
      ),
    );
  }
}
