import 'package:flutter/material.dart';
import 'dart:convert';

class Galleria extends StatelessWidget {
  const Galleria();

  Widget _buildLoaded(data) {
    var galleries = data['galleries'];
    // return Text(lastGallery["name"]);
    return ListView(children: [
      galleries.entries.map((gallery) {
        Text(gallery["name"]);
      })
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('datas/gallery_source.json'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: Text('Loading...'));
            default:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              else {
                //若_calculation执行正常完成
                const json = const JsonCodec();
                var data = json.decode(snapshot.data.toString());
                return _buildLoaded(data);
              }
          }
        });
  }
}
