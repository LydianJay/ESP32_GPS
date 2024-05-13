import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapView extends StatefulWidget {
  final List<double> lat;
  final List<double> lon;

  const MapView({super.key, required this.lat, required this.lon});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Future<Widget> generatePolyLines() async {
    List<LatLng> coords = [];

    for (var i = 0; i < widget.lat.length; i++) {
      coords.add(LatLng(widget.lat[i], widget.lon[i]));
    }

    return PolylineLayer(
      polylines: [
        Polyline(
          points: coords,
          color: Colors.red,
          strokeWidth: 4.5,
        ),
      ],
    );
  }

  Future<Widget> generatePoints() async {
    List<Marker> listMarkers = [];
    for (var i = 0; i < widget.lat.length; i++) {
      listMarkers.add(
        Marker(
          point: LatLng(widget.lat[i], widget.lon[i]),
          child: const Icon(Icons.car_rental),
          width: 85,
          height: 85,
          rotate: true,
        ),
      );
    }
    return MarkerLayer(markers: listMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(widget.lat.first, widget.lon.first),
        initialZoom: 18.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        FutureBuilder(
          future: generatePolyLines(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.requireData;
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
        FutureBuilder(
          future: generatePoints(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.requireData;
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
        CurrentLocationLayer(
          alignPositionOnUpdate: AlignOnUpdate.once,
          alignDirectionOnUpdate: AlignOnUpdate.never,
          style: const LocationMarkerStyle(
            marker: DefaultLocationMarker(
              child: Icon(
                Icons.navigation,
                color: Colors.white,
              ),
            ),
            markerSize: Size(20, 20),
            markerDirection: MarkerDirection.heading,
          ),
        )
      ],
    );
  }
}
