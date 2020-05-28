import 'package:codinome/Helpers/database_helper.dart';
import 'package:codinome/Helpers/dialog_helper.dart';
import 'package:codinome/Helpers/router_helper.dart';
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
  final GlobalKey<FormState> _key;

  _UserCreateBody(this._key);

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final _dbHelper = DatabaseHelper();

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
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    controller: _nameController,
                    focusNode: _nameFocus,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Informe o usuário';
                      } else {
                        return _validateUser(val)
                            ? null
                            : 'Usuário $val já existe';
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
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => (_okClick(context)),
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    validator: (val) {
                      if (val.isEmpty) {
                        return 'Informe a senha';
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
      if (_nameController.text.isEmpty) {
        _nameFocus.requestFocus();
        return;
      }

      if (_passwordController.text.isEmpty) {
        _passwordFocus.requestFocus();
        return;
      }
    }

    await _AddUser(
      context,
      User(
        name: _nameController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  Future _AddUser(BuildContext context, User user) async {
    try {

      await _dbHelper.CreateAsync('user', user.toJson());

      await Router.Pop(context, data: user);

      await _dbHelper.DisposeAsync();
    } catch (ex) {
      print(ex);
    }
  }

  _validateUser<bool>(String val) {

    var result = false;
    _dbHelper.ExistsAsync('user', 'name', val).then((value) => result = !value);
    return result;
  }

}
