import 'package:flutter/material.dart';

class Router {

  Router();

  static Future PushTo(Widget page, BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static Future Pop(context){
    Navigator.pop(context);
  }

  static Future PushReplace( Widget page, BuildContext context){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

}