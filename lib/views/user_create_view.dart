import 'package:codinome/Helpers/database_helper.dart';
import 'package:codinome/Helpers/dialog_helper.dart';
import 'package:codinome/Models/user_model.dart';
import 'package:flutter/material.dart';

class UserCreate extends StatefulWidget {
  @override
  _UserCreateState createState() => _UserCreateState();
}

class _UserCreateState extends State<UserCreate> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserCreateAppBar(),
      body: _UserCreateBody(_formKey),
    );
  }

  AppBar UserCreateAppBar() => AppBar(
        title: Text('Add User'),
        centerTitle: true,
      );
}

class _UserCreateBody extends StatelessWidget {
  GlobalKey<FormState> _key;

  _UserCreateBody(this._key);

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: _UserCreateForm(context),
      ),
    );
  }

  Widget _UserCreateForm(BuildContext context) => SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(10),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Hero(
                  tag: "UserAdd",
                  child: Icon(
                    Icons.supervised_user_circle,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _nameController,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Informe o nome de usuário';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      hintText: 'Informe o novo login',
                      prefixIcon: Icon(Icons.face),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: _passwordController,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Informe o nome de usuário';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Defina uma senha',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                FlatButton(
                  child: Text('OK?'),
                  onPressed: () => _okClick(context),
                ),
              ],
            ),
          ),
        ),
      );

  Future _okClick(BuildContext context) async {
    if (!_key.currentState.validate()) {
      return;
    }

    await _AddUser(
      context,
      User(
        name: _nameController.text,
        password: _passwordController.text,
      ),
    );
  }

  Future _AddUser(BuildContext context, User user) async {
    try {
      DatabaseHelper dbHelper = await DatabaseHelper().instance();

      User user = User(
        name: _nameController.text,
        password: _passwordController.text,
      );

      var result = await dbHelper.ExistsAsync('user', 'name', user.name);

      if (result) {
        DialogHelper.ShowSnack(context, 'Nome de usuário já existe');
      } else {
        await dbHelper.CreateAsync('user', user.toJson());
      }

      await dbHelper.DisposeAsync();
    } catch (ex) {
      print(ex);
    }
  }
}
