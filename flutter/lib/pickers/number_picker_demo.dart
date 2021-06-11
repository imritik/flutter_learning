import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerDemo extends StatefulWidget {
  @override
  _NumberPickerDemoState createState() => _NumberPickerDemoState();
}

class _NumberPickerDemoState extends State<NumberPickerDemo> {
  int _currentIntValue = 10;
  NumberPicker integerNumberPicker;

  static const List<String> iceCreamToppings = <String>[
    'Hot Fudge',
    'FUDGE'
        'Sprinkles',
    'SPRINK'
        'Caramel',
    'CARM'
        'Oreos',
    'OREO'
  ];

  List<String> selectedIceCreamToppings = [
    iceCreamToppings[0],
    iceCreamToppings[2],
  ];

  _handleValueChanged(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
      } else {}
    }
  }

  /// This decides which day will be enabled
  /// This will be called every time while displaying day in calender.
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 10))))) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    integerNumberPicker = new NumberPicker(
        minValue: 10,
        maxValue: 100,
        value: _currentIntValue,
        step: 10,
        onChanged: _handleValueChanged);

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Picker demo'),
          centerTitle: true,
        ),
        body: new Center(
          child: new Column(children: <Widget>[
            integerNumberPicker,
            OutlinedButton(
              child: new Text('Int Value: $_currentIntValue'),
              onPressed: () {},
            ),
            OutlinedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: child,
                      );
                    },
                    selectableDayPredicate: _decideWhichDayToEnable,
                  );
                },
                child: Text("Custom Date picker")),
            OutlinedButton(
                onPressed: () {
                  // var age = 25;

                  showMaterialNumberPicker(
                      context: context,
                      title: 'Pick Your Age',
                      maxNumber: 100,
                      minNumber: 14,
                      selectedNumber: 25,
                      onChanged: (value) {
                        // print("fdfdf");
                      });
                },
                child: Text("Material Number picker")),
            OutlinedButton(
                onPressed: () {
                  showMaterialCheckboxPicker(
                      context: context,
                      title: 'Pick Your Toppings',
                      items: iceCreamToppings,
                      selectedItems: selectedIceCreamToppings,
                      onChanged: (value) {
                        // print("fdfdf");
                      });
                },
                child: Text("Material Checkbox picker"))
          ]),
        ));
  }
}
