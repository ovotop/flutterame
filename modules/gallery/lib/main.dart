import 'package:flutter/material.dart';
import 'package:gallery/galleria.dart';
import 'package:gallery/routes.dart';

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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  void _gotoAbout(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GalleryAbout()));
    Navigator.pushNamed(context, "/gallery/about");
  }

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: Galleria()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._gotoAbout(context);
        },
        child: Text("About"),
      ),
    );
  }
}
