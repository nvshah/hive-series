import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/series.dart';

class NewSeriesForm extends StatefulWidget {
  @override
  _NewSeriesFormState createState() => _NewSeriesFormState();
}

class _NewSeriesFormState extends State<NewSeriesForm> {
  final _formKey = GlobalKey<FormState>();

  String _name;
  String _ratings;
  
  //Add item inside a box
  void addSeries(Series series) {
    //print('Name: ${series.name}, Age: ${series.ratings}');
    //* Since Hive-box is provided at top of this Widget level, it will be accessed here as it is open for this widget too. 
    final seriesBox = Hive.box('series');
    // We are using auto-increment keys
    seriesBox.add(series);  //since we have defined typeAdapter for Series class we can direclty add series object inside add(), other wise we need to convert it to json string
    //seriesBox.add(series.tojson());
  }

  @override
  Widget build(BuildContext context) {
    //Form
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          //Take inputs
          Row(
            children: <Widget>[
              Expanded(
                //Name
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => _name = value,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                //Ratings
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'ratings'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => _ratings = value,
                ),
              ),
            ],
          ),
          //ADD - Series
          RaisedButton(
            child: Text('Add New Series'),
            onPressed: () {
              //save the text fields value at present in form
              _formKey.currentState.save();
              final newSeries = Series(_name, int.parse(_ratings));
              //Add series to box - 'series'
              addSeries(newSeries);
              _formKey.currentState.reset();

            },
          ),
        ],
      ),
    );
  }
}
