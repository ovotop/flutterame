import 'package:flutter/material.dart';
class About extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Hero(
          tag: 'about_title',
          child: Material(
            color: Colors.orange,
            child: SizedBox(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("about",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  )
                ),],
              ),
              width: 300,
              height:40,
            ),
          )
        ),
      ),
      body: Center(
        child: Text("about"),
      ),
    );
  }
}