import 'package:flutter/material.dart';
import 'package:gallery/galleria.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
