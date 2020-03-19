import 'package:codinomeapp/Helpers/router_helper.dart';
import 'package:flutter/material.dart';

class UserHome extends StatefulWidget{

  @override
  _UserHomeState createState() => _UserHomeState();

}

class _UserHomeState extends State<UserHome> {

  final _users;

  @override
  void setState(fn) {
    super.setState(fn);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: UserHomeAppBar(context),
      body: UserHomeBody(),
    );
  }

  Widget UserHomeBody() =>
      Container();

  AppBar UserHomeAppBar(BuildContext context) =>
      AppBar(
        title: Text('Users'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Router.Pop(context),
          ),
      );
}