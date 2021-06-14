import 'package:flutter/material.dart';
import 'package:product_flavors/app_config.dart';
import 'package:product_flavors/home_page.dart';

// void main_common() {}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    return _buildApp(config!.appDisplayName);
  }

  Widget _buildApp(String appName) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primaryColor: const Color(0xFF43a047),
        // ignore: deprecated_member_use
        accentColor: const Color(0xFFffcc00),
        primaryColorBrightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}
