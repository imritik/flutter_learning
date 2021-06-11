import 'package:flutter/material.dart';
import 'package:mvvm_architecture/Model/PostModel.dart';
import 'package:mvvm_architecture/Service/apiservice.dart';

class ApiStore extends ChangeNotifier {
  static var posts;

  static getData(VoidCallback callBack(bool success, response)) {
    ApiService.getData((success, response) =>
        // posts = mapData(response)
        callBack(true, response));
  }

  static postData(VoidCallback callBack(bool success)) {
    ApiService.postData((success) =>
        // posts = mapData(response)
        callBack(true));
  }
}
