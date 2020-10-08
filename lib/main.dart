import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Series Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
          //opening a box takes very little amount of time
          future: Hive.openBox('series'),
          builder: (ctxt, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return Container();
            } else {
              //although opening a box takes a very short time,
              //we still need to return something before future completes
              return Scaffold();
            }
          }),
    );
  }
}
