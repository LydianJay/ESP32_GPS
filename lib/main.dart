import 'package:flutter/material.dart';
import 'package:gpsapp/view/mapview.dart';

void main() {
  runApp(const GPSApp());
}

class GPSApp extends StatefulWidget {
  const GPSApp({super.key});

  @override
  State<GPSApp> createState() => _GPSAppState();
}

class _GPSAppState extends State<GPSApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapView(),
    );
  }
}
