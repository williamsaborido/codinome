import 'package:codinome/Helpers/dialog_helper.dart';
import 'package:codinome/Helpers/router_helper.dart';
import 'package:codinome/Models/user_model.dart';
import 'package:codinome/views/login_view.dart';
import 'package:codinome/views/user_create_view.dart';
import 'package:flutter/material.dart';

import 'backgrond_screen.dart';

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

  Widget MenuItemList(BuildContext context) => ListView(
      children: [
        ListTile(
          leading: Hero(
            tag: "UserAdd",
            child: Icon(Icons.supervised_user_circle),
          ),
          trailing: Icon(Icons.exit_to_app),
          title: Text('Add user'),
          subtitle: Text('Add a new user on the app'),
          onTap: () => AddUser(context),
        ),
        ListTile(
          leading: Icon(Icons.add),
          trailing: Icon(Icons.exit_to_app),
          title: Text('Add user'),
          subtitle: Text('Add a new user on the app'),
          onTap: () => Router.PushTo(Login(), context),
        ),
        ListTile(
          leading: Icon(Icons.message),
          trailing: Icon(Icons.exit_to_app),
          title: Text('Add user'),
          subtitle: Text('Add a new user on the app'),
          onTap: () => DialogHelper.Confirm(
                  context: context,
                  message: 'Are you sure to delete this item?')
              .then((result) => print(result)),
        ),
        ListTile(
          leading: Icon(Icons.mode_comment),
          trailing: Icon(Icons.exit_to_app),
          title: Text('Add user'),
          subtitle: Text('Add a new user on the app'),
          onTap: () => DialogHelper.CustomAlertDialog(
            context: context,
            message: 'Are you sure to delete this item?',
            customAlertDialogType: CustomAlertDialogType.OKCancel,
            dismissible: false,
            title: 'Exclusion confirmation',
          ).then((result) => print(result)),
        ),
        ListTile(
          leading: Icon(Icons.image),
          trailing: Icon(Icons.exit_to_app),
          title: Text('Add user'),
          subtitle: Text('Add a new user on the app'),
          onTap: () => Router.PushTo(BackgroundScreen(), context),
        ),
      ]);
}

void ShowMessage(BuildContext context, String message) {
  DialogHelper.ShowSnack(context, message);
}

Future AddUser(BuildContext context) async {
  try {
    var result = await Router.PushTo(UserCreate(), context) as User;

    if (result != null) {
      DialogHelper.ShowSnack(context, '${result.name} foi adicionado');
    }
  } catch (ex) {
    print(ex);
  }
}
