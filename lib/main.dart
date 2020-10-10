import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import './models/series.dart';
import './pages/series_page.dart';

void main() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  // Door for Hive
  Hive.init(appDocumentDir.path);
  //Registering Series Class for Hive Box-storage facilitation
  //starting from 0 & then 1,2,... goes on for other type id
  //? What is typeId ? -> typeId unique identifier to identify type
  Hive.registerAdapter(SeriesAdapter(), 0);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Concepts',
      home: FutureBuilder(
        //Open Hive Box to store data further
        future: Hive.openBox('contacts'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Text(snapshot.error.toString());
            else
              return SeriesPage();
          }
          // Although opening a Box takes a very short time,
          // we still need to return something before the Future completes.
          else
            return Scaffold();
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}