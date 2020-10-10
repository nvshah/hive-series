import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import './new_series_form.dart';
import '../models/series.dart';

import 'new_series_form.dart';

class SeriesPage extends StatelessWidget {
  const SeriesPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hive Concept'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildListView()),
            NewSeriesForm(),
          ],
        ));
  }

  ListView _buildListView() {
    //first we need to get the series-box, and as we have defined the box at top of the 1st level,
    //We will be able to open that box over here
    final seriesBox = Hive.box('series');
    
    return ListView.builder(
      itemCount: seriesBox.length,
      itemBuilder: (BuildContext context, int idx){
        //final series = seriesBox.get(idx) as Series;   // problematic when using put() or something deleted from Box
        final series = seriesBox.getAt(idx) as Series;

        return ListTile(
          title: Text(series.name),
          subtitle: Text(series.ratings.toString()),
        );

      },
    );
  }
}