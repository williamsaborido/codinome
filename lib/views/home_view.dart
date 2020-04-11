import 'package:codinome/Helpers/database_helper.dart';
import 'package:codinome/Helpers/router_helper.dart';
import 'package:codinome/Views/user_home_view.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: _HomeBody(),
    );
  }

  AppBar HomeAppBar() => AppBar(
        title: Text('Codinome'),
        centerTitle: true,
      );
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: MenuItemList(context),
      ),
    );
  }

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
            onTap: () => AddUser(context)),
      ]);
}

void AddUser(BuildContext context) async {
  try {
    DatabaseHelper db = await DatabaseHelper().instance();

    print(
        await db.CreateAsync('user', {'name': 'william', 'password': '1234'}));

    await db.Dispose();

    var snack = SnackBar(
      content: Text('Added'),
      elevation: 10,
    );

    Scaffold.of(context).showSnackBar(snack);
  } catch (ex) {
    print(ex);
  }
}
