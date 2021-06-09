import 'dart:convert';

import 'package:flutter_mvvm/models/post.dart';
import 'package:flutter_mvvm/notifiers/post_notifier.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String API_ENDPOINT =
      "https://jsonplaceholder.typicode.com/posts";

  static getPosts(PostsNotifier postNotifier) async {
    List<Post> postList = [];
    http.get(API_ENDPOINT).then((response) {
      if (response.statusCode == 200) {
        List posts = jsonDecode(response.body);
        posts.forEach((element) {
          postList.add(Post.fromMap(element));
        });
        postNotifier.setPostList(postList);
      }
    });
  }

  static Future<bool> addPost(Post post, PostsNotifier postNotifier) async {
    bool result = false;
    await http
        .post(API_ENDPOINT,
            headers: {"Content-type": "application/json; charset=UTF-8"},
            body: json.encode(post.toMap()))
        .then((response) {
      if (response.statusCode == 201) {
        result = true;
        postNotifier.addPostToList(post);
      }
    });
    return result;
  }

  static Future<bool> updatePost(Post post, PostsNotifier postNotifier) async {
    bool result = false;
    var id = post.id;
    await http
        .put(API_ENDPOINT + '/$id',
            headers: {"Content-type": "application/json; charset=UTF-8"},
            body: json.encode(post.toMap()))
        .then((response) {
      if (response.statusCode == 200) {
        result = true;
        getPosts(postNotifier);
      }
    });
    return result;
  }

  static Future<bool> deletePost(int id, PostsNotifier postNotifier) async {
    bool result = false;
    await http
        .delete(
      API_ENDPOINT + '/$id',
    )
        .then((response) {
      if (response.statusCode == 200) {
        result = true;
        getPosts(postNotifier);
      }
    });
    return result;
  }
}
