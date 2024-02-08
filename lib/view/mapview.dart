import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(9.757131, 125.513763),
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: const [
                LatLng(9.787144, 125.499671),
                LatLng(9.786624, 125.499959),
                LatLng(9.784103, 125.501368),
              ],
              color: Colors.red,
              strokeWidth: 5.0,
            ),
          ],
        ),
        const MarkerLayer(
          markers: [
            Marker(
              point: LatLng(9.787144, 125.499671),
              width: 80,
              height: 80,
              child: Icon(Icons.motorcycle),
              rotate: true,
            ),
            Marker(
              point: LatLng(9.786624, 125.499959),
              width: 80,
              height: 80,
              child: Icon(Icons.motorcycle),
              rotate: true,
            ),
            Marker(
              point: LatLng(9.784103, 125.501368),
              width: 80,
              height: 80,
              child: Icon(Icons.motorcycle),
              rotate: true,
            ),
          ],
        ),
        /*CurrentLocationLayer(
          alignPositionOnUpdate: AlignOnUpdate.always,
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
        )*/
      ],
    );
  }
}
