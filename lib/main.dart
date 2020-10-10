import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import './models/series.dart';
import './pages/series_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //need to add this line, otherwise we will get Exception: ServiceBinding.*
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
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      home: FutureBuilder(
        //Open Hive Box to store data further
        //future: Hive.openBox('contacts'),
        future: Hive.openBox(
          'series',
          //Do compaction when deleted number is more than 20
          compactionStrategy: (int total, int deleted) {
            return deleted > 20;
          },
        ),
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
    // //manual compaction
    // Hive.box('series').compact();
    Hive.close();
    super.dispose();
  }
}