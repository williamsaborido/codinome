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

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _userExists = false;

  @override
  void initState() {
    super.initState();

    DatabaseHelper.connect()
        .catchError((test, obj) => print('$test: ${obj}'))
        .then((result) {
      print('done');
    });
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                      if (val.isEmpty)
                        return 'Informe o usuário';
                      else if (_userExists){
                        _userExists = false;
                        return 'Usuario ${_nameController.text} já existe';
                      }
                      else
                        return null;
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
      ),
    );
  }

  Future _okClick(BuildContext context) async {
    if (!_formKey.currentState.validate()) {

      if (_nameController.text.isEmpty) {
        _nameFocus.requestFocus();
        return;
      }

      if (_passwordController.text.isEmpty) {
        _passwordFocus.requestFocus();
        return;
      }

      if (_userExists) {
        _nameFocus.requestFocus();
        return;
      }
    } else {
      _formKey.currentState.save();
    }

    if (await DatabaseHelper.ExistsAsync(
        'user', 'name', _nameController.text)) {
      //_nameFocus.requestFocus();
      //DialogHelper.ShowSnack(
      //    context, 'Usuario ${_nameController.text} já existe');
      setState(() {
        _userExists = true;
      });
      return;
    }
    else{
      _userExists = false;
    }

    var user = User(
      name: _nameController.text.trim(),
      password: _passwordController.text.trim(),
    );

    await _AddUser(context, user);

    await Router.Pop(context, data: user);
  }

  Future _AddUser(BuildContext context, User user) async {
    try {
      await DatabaseHelper.CreateAsync('user', user.toJson());

      await DatabaseHelper.DisposeAsync();
    } catch (ex) {
      print(ex);
    }
  }
}
