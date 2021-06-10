// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:numberpicker/numberpicker.dart';

// class NumberPickerDemo extends StatefulWidget {
//   @override
//   _NumberPickerDemoState createState() => _NumberPickerDemoState();
// }

// class _NumberPickerDemoState extends State<NumberPickerDemo> {
//   int _currentIntValue = 10;
//   double _currentDoubleValue = 3.0;
//   NumberPicker integerNumberPicker;
//   NumberPicker decimalNumberPicker;

//   _handleValueChanged(num value) {
//     if (value != null) {
//       if (value is int) {
//         setState(() => _currentIntValue = value);
//       } else {
//         setState(() => _currentDoubleValue = value);
//       }
//     }
//   }

//   _handleValueChangedExternally(num value) {
//     if (value != null) {
//       if (value is int) {
//         setState(() => _currentIntValue = value);
//         integerNumberPicker.animateInt(value);
//       } else {
//         setState(() => _currentDoubleValue = value);
//         decimalNumberPicker.animateDecimalAndInteger(value);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // integerNumberPicker=new NumberPicker.integer
//   }
// }
