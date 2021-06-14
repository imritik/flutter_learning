import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm_architecture/Model/PostModel.dart';

class ApiService {
  static const String API_ENDPOINT =
      "https://jsonblob.com/api/jsonBlob/dea335b4-caa3-11eb-a730-6fb9a48111eb";

  static getData(VoidCallback callBack(bool success, response)) async {
    get(API_ENDPOINT).then((response) {
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        callBack(true, decodedResponse);
      }
    });
  }

  // static Future<List<dynamic>> getFutureData() async {
  //   final response = await get(API_ENDPOINT);
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  static postData(VoidCallback callBack(bool success)) async {
    // List<Post> postList = [];
    await post(API_ENDPOINT, headers: {
      "Content-type": "application/json; charset=UTF-8"
    }, body: {
      "userId": "1",
      "id": "2",
      "title": "qui est esse",
      "body":
          "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
    }).then((response) {
      if (response.statusCode == 201) {
        callBack(true);
      }
    });
  }

  static updateData(VoidCallback callBack(bool success)) async {
    await put(API_ENDPOINT, headers: {
      "Content-type": "application/json; charset=UTF-8"
    }, body: {
      "userId": "1",
      "id": "2",
      "title": "qui est esse",
      "body":
          "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
    }).then((response) {
      if (response.statusCode == 200) {
        callBack(true);
      }
    });
  }

  static deleteData(VoidCallback callBack(bool success)) async {
    delete(API_ENDPOINT).then((success) {
      if (success == true) {
        callBack(true);
      }
    });
  }
}
