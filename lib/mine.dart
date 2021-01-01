import 'package:flutter/material.dart';
class Mine extends StatelessWidget{
  const Mine();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(child:Column(
        children: [
          Text("mine"),
          Hero(
            tag: 'about_title',
            child: OutlineButton(
              onPressed: ()=>{
                Navigator.pushNamed(context, "/about")
              }, 
              child: Text("about"),
            ) 
          )
        ]) ,
        height: 100)
    );
  }
}