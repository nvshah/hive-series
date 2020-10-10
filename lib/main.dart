import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import './models/series.dart';
import './pages/series_page.dart';

void main() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  // Door for Hive
  Hive.init(appDocumentDir.path);
  //starting from 0 & then 1,2,... goes on for other type id
  //? What is typeId ? -> typeId unique identifier to identify type
  Hive.registerAdapter(SeriesAdapter(), 0);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Tutorial',
      home: SeriesPage(),
    );
  }
}
