import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:gallery/environment_config.dart';

var fontColor = Colors.white;
var cardColor = Colors.orange;

class Galleria extends StatelessWidget {
  const Galleria();
  Widget _buildItem(context, gallery) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/gallery/detail", arguments: gallery);
        },
        child: AspectRatio(
            aspectRatio: 4 / 3,
            child: Card(
                margin: EdgeInsets.all(8),
                color: cardColor,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                      Container(
                          child: Hero(
                              tag: 'title',
                              child: Material(
                                  color: Colors.transparent,
                                  child: Text(gallery["name"],
                                      style: TextStyle(
                                          color: fontColor, fontSize: 20)))),
                          padding: EdgeInsets.only(left: 8)),
                      AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Hero(
                              tag: 'cover',
                              child: Image.network(gallery["cover"],
                                  fit: BoxFit.cover))),
                      Container(
                        child: Text('${gallery["page"].length}P',
                            style: TextStyle(color: fontColor, fontSize: 8)),
                        padding: EdgeInsets.only(right: 8),
                        alignment: Alignment.centerRight,
                      ),
                    ])))));
  }

  Widget _buildLoaded(data) {
    var galleries = data['galleries'];
    return Center(
        child: AspectRatio(
            aspectRatio: 0.8,
            child: Container(
                // decoration: BoxDecoration(color: Colors.red),
                child: ListView.builder(
              itemBuilder: (context, index) {
                var gallery = galleries[index];
                return _buildItem(context, gallery);
              },
              itemCount: galleries.length,
            ))));
  }

  @override
  Widget build(BuildContext context) {
    const isRunAlone = EnvironmentConfig.IS_RUN_ALONE;
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(isRunAlone
            ? 'datas/gallery_source.json'
            : 'packages/gallery/datas/gallery_source.json'),
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
