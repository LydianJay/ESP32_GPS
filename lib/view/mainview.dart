import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gpsapp/view/mapview.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<double> latValues = [];
  List<double> lonValues = [];
  @override
  void initState() {
    super.initState();
  }

  Future<Widget> generateContent(double scrWidth, double scrHeight) async {
    latValues = [];
    lonValues = [];
    debugPrint('Calling function');
    final latRef = FirebaseDatabase.instance.ref('coords').child('lat');
    final lonRef = FirebaseDatabase.instance.ref('coords').child('lon');
    debugPrint('Get instance');
    final latSnap = await latRef.get();
    final lonSnap = await lonRef.get();
    debugPrint('Instances fetched!');
    if (!latSnap.exists && !lonSnap.exists) {
      return const Text('No data was fetched');
    }

    latSnap.value
        .toString()
        .replaceAll(RegExp(r'\[|\]'), '')
        .split(',')
        .forEach((element) {
      latValues.add(double.parse(element));
    });

    lonSnap.value
        .toString()
        .replaceAll(RegExp(r'\[|\]'), '')
        .split(',')
        .forEach((element) {
      lonValues.add(double.parse(element));
    });

    List<TableRow> rows = [];
    rows.add(const TableRow(children: [Text('Latitude'), Text('Longitude')]));

    for (var i = 0; i < latValues.length; i++) {
      rows.add(
        TableRow(
          children: [
            Text(latValues[i].toString()),
            Text(lonValues[i].toString()),
          ],
        ),
      );
    }
    return Table(
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(),
        1: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(color: Colors.black),
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;

    double scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromARGB(204, 210, 237, 248),
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 57, 156, 173),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    'Coordinates',
                    style: TextStyle(
                        fontFamily: 'Calibre',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder(
                  future: generateContent(scrWidth, scrHeight),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.requireData;
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MapView(
                                    lat: latValues,
                                    lon: lonValues,
                                  )));
                    },
                    icon: const Icon(Icons.map_sharp),
                    label: const Text('Go To Map'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
