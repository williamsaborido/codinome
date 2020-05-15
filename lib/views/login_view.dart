import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode _userNode = FocusNode();
  TextEditingController _userController = TextEditingController();

  FocusNode _passwordNode = FocusNode();
  TextEditingController _passwordController = TextEditingController();

  Color userFocusColor;
  Color passwordFocusColor;

  @override
  void initState() {
    super.initState();
    userFocusColor = Colors.grey;
    passwordFocusColor = Colors.grey;

    _userNode.addListener(() => _onFocusChange());
    _passwordNode.addListener(() => _onFocusChange());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: 100,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      border: Border.all(
                        color: userFocusColor,
                      )),
                  child: TextFormField(
                    focusNode: _userNode,
                    controller: _userController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (val) => FocusScope.of(context).nextFocus(),
                    decoration: InputDecoration(
                      labelText: 'Usuário',
                      hintText: 'Digite o usuário',
                      prefixIcon: Icon(Icons.face),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      border: Border.all(
                        color: passwordFocusColor,
                      )),
                  child: TextFormField(
                    focusNode: _passwordNode,
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite a senha',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Login'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFocusChange(){
    userFocusColor = _userNode.hasFocus ? Colors.blue: Colors.grey;
    passwordFocusColor = _passwordNode.hasFocus ? Colors.blue: Colors.grey;
    setState((){});
  }
}
