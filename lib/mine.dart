import 'package:flutter/material.dart';

class Mine extends StatelessWidget {
  const Mine();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(flex: 1, child: Center(child: Text("mine"))),
      SizedBox(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                  tag: 'about_title',
                  child: OutlineButton(
                    onPressed: () => {Navigator.pushNamed(context, "/about")},
                    child: Text("about"),
                  )),
              OutlineButton(
                onPressed: () =>
                    {Navigator.pushNamed(context, "/gallery/about")},
                child: Text("gallery about"),
              )
            ],
          ))
    ]);
  }
}
