import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  final gallery;
  Detail({this.gallery});
  @override
  Widget build(BuildContext context) {
    bool hasName = this.gallery != null && this.gallery["name"] != null;
    bool hasCover = this.gallery != null && this.gallery["cover"] != null;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Hero(
          tag: 'title',
          child: Material(
              color: Colors.transparent,
              child: Text(hasName ? this.gallery["name"] : "detail",
                  style: TextStyle(color: Colors.white, fontSize: 20))),
        ),
      ),
      body: Container(
          color: Colors.orange,
          child: Center(
              child: hasCover
                  ? Hero(
                      tag: 'cover',
                      child: Image.network(this.gallery["cover"],
                          fit: BoxFit.cover))
                  : Text("cover not found"))),
    );
  }
}
