import 'package:flutter/material.dart';

class Router {

  Router();

  static Future PushTo(Widget page, BuildContext context) async{
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static Future Pop(context, {dynamic data}) async {
    return await Navigator.pop(context, data);
  }

  static Future PushReplace(Widget page, BuildContext context) async{
    return await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

}