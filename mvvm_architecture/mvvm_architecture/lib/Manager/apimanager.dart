import 'package:flutter/material.dart';
import 'package:mvvm_architecture/Service/apiservice.dart';
import 'package:mvvm_architecture/Store/api_store.dart';

class ApiManager {
  static getData(VoidCallback callBack(bool success, response)) {
    ApiStore.getData((success, response) => callBack(true, response));
  }

  static postData(VoidCallback callBack(bool success)) {
    ApiStore.postData((success) => callBack(true));
  }
}
