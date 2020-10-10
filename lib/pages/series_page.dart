import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
          title: Text('Series'),
        ),
        body: Column(
          children: <Widget>[
            //List of Series
            Expanded(child: _buildListView()),
            //New Series
            NewSeriesForm(),
          ],
        ));
  }

  //Build List of Series
  Widget _buildListView() {
    return WatchBoxBuilder(
      //first we need to get the series-box, and as we have defined the box at top of the 1st level,
      //We will be able to open that box over here
      box: Hive.box('series'),
      builder: (ctxt, seriesBox) {
        return ListView.builder(
          itemCount: seriesBox.length,
          itemBuilder: (BuildContext context, int idx) {
            //final series = seriesBox.get(idx) as Series;   // problematic when using put() or something deleted from Box
            final series = seriesBox.getAt(idx) as Series;
            //ROW
            return ListTile(
              title: Text(series.name),
              subtitle: Text(series.ratings.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //UPDATE/Refresh
                  IconButton(
                    icon: Icon(Icons.refresh, color: Colors.indigo,),
                    onPressed: (){
                      return seriesBox.putAt(idx, Series('${series.name}*', series.ratings + 1));
                    },
                  ),
                  //DELETE
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red,),
                    onPressed: () => seriesBox.deleteAt(idx),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
