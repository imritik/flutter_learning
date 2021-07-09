import 'package:bloc_sqflite/view/notification/notification_demo.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_absolute_path/flutter_absolute_path.dart'; //to find path of file in device

Widget noTodoMessageWidget() {
  // ignore: avoid_unnecessary_containers
  return Container(
    child: const Text(
      "Start adding Todo...",
      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
    ),
  );
}

Widget loadingData() {
  // ignore: avoid_unnecessary_containers
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        // ignore: prefer_const_constructors
        CircularProgressIndicator(),
        const SizedBox(
          height: 10,
        ),
        // ignore: prefer_const_constructors
        Text(
          "Loading ...",
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        )
      ],
    ),
  );
}

showSnackBar(dynamic value, BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(value)));
}

void selectedItem(BuildContext context, int item) async {
  switch (item) {
    case 0:
      //open url
      const url = 'https://flutterdevs.com/';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch url';
      }

      break;
    case 1:
      //open mail
      launch("mailto:intent@test.com?subject=TestEmail&body=Email test body");
      break;

    case 2:
      //open dialer
      const url = "tel:1234567";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      break;

    case 3:
      //share files
      shareFiles();
      break;
    case 4:
      //navigate to notification demo screen
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NotificationDemo()));
      break;
  }
}

void shareContent(String text) {
  Share.share(text, subject: 'Sharing on Email');
}

Future<void> shareFiles() async {
  List<Asset> resultList = <Asset>[];
  List<String> imagesPath = [];
  try {
    resultList = await MultiImagePicker.pickImages(
        maxImages: 100,
        enableCamera: true,
        materialOptions: const MaterialOptions(
            actionBarTitle: 'Flutter App',
            allViewTitle: 'All Photos',
            selectCircleStrokeColor: '#000000'));
  } on Exception catch (e) {
    // ignore: avoid_print
    print(e.toString());
  }
  for (var item in resultList) {
    var path = await FlutterAbsolutePath.getAbsolutePath(item.identifier);
    imagesPath.add(path);
  }
  // print("========${resultList[0].identifier}=========");
  Share.shareFiles(imagesPath,
      text: 'Sharing images', subject: 'Sharing through email');
}

void showErrorAlert(BuildContext context, dynamic err) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(err.message),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                // isLoading = false;
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
