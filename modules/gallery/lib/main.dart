import 'package:flutter/material.dart';
import 'package:gallery/routes.dart';
import 'package:gallery/gallery_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Module: gallery'),
      initialRoute: '/',
      onGenerateRoute: GalleryRouteGenerator.generateRoute,
    );
  }
}
