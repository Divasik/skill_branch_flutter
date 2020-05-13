import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/material.dart';

import 'screens/feed_screen.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FullScreenImage(altDescription: 'Текст ',
          name: 'Kirill Adechenko', userName: 'kaparray', photo: kFlutterDash,)
    );
  }
}