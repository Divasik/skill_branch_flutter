import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class MyApp extends StatelessWidget {

  final Connectivity _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: buildAppTextTheme()
      ),
      home: Home(_connectivity.onConnectivityChanged),
      );
  }

}