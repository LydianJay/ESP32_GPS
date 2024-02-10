import 'package:flutter/material.dart';
import 'package:gpsapp/view/mapview.dart';
import 'package:gpsapp/view/mainview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBFU-rBRWteNKGOuwwVXJwxS6HZI1QepJU",
      appId: "1:791787814827:android:9c4be49d22d20e95df9cee",
      messagingSenderId: "791787814827",
      projectId: "gpsapp-413714",
      databaseURL:
          "https://gpsapp-413714-default-rtdb.asia-southeast1.firebasedatabase.app",
    ),
  );
  //await Firebase.initializeApp();
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
    return MaterialApp(
      initialRoute: '/mainview',
      routes: {
        '/mainview': (context) => const MainView(),
      },
    );
  }
}
