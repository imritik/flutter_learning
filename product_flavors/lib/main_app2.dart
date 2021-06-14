import 'package:flutter/material.dart';
import 'package:product_flavors/app_config.dart';
import 'package:product_flavors/main.dart';

void main() {
  var configuredApp = AppConfig(
    appDisplayName: "App 2",
    appInternalId: 2,
    child: MyApp(),
  );

  // main_common();

  runApp(configuredApp);
}
