import 'package:codinome/Helpers/database_helper.dart';
import 'package:codinome/Helpers/router_helper.dart';
import 'package:codinome/Views/user_home_view.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: HomeAppBar(),
      body: HomeBody(),
    );
  }

  AppBar HomeAppBar() => AppBar(
        title: Text('Codinome'),
        centerTitle: true,
      );

  Widget HomeBody() => Container(
        padding: EdgeInsets.all(5),
        child: MenuItemList(_context),
      );

  Widget MenuItemList(BuildContext context) => ListView(children: [
        ListTile(
            leading: Icon(Icons.supervised_user_circle),
            trailing: Icon(Icons.exit_to_app),
            title: Text('Add user'),
            subtitle: Text('Add a new user on the app'),
            onTap: () => Router.PushTo(UserHome(), context)),
        ListTile(
            leading: Icon(Icons.add),
            trailing: Icon(Icons.exit_to_app),
            title: Text('Add user'),
            subtitle: Text('Add a new user on the app'),
            onTap: () => AddUser()),
      ]);
}

void AddUser() async {
  try{

    print(await DatabaseHelper.CreateAsync('user', {'name': 'william', 'password': '1234'}));
  }
  catch(ex){
    print(ex);
  }
}
