import 'package:flutter/material.dart';
import 'package:mvvm_architecture/Manager/apimanager.dart';
import 'package:mvvm_architecture/Model/PostModel.dart';

class ApiViewmodel {
  static List<Post> newPostList = [];

  static loadData() {
    ApiManager.getData((success, response) =>
        // posts = response
        mapData(response));
  }

  static mapData(response) {
    List<Post> postList = [];
    response.forEach((element) {
      newPostList.add(Post.fromMap(element));
    });
    // newPostList = postList;
  }

  static postData() {
    ApiManager.postData((success) {});
  }
}
