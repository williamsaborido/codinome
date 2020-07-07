import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background'),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset('assets/images/background.jpg').image,
                fit: BoxFit.cover,
              ),
          ),
        ),
        Container(),
        SingleChildScrollView(
          child: Container(
            child: Form(
              key: null, //_formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
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
                          color: Colors.white, //userFocusColor,
                        ),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        cursorColor: Colors.white,
                        focusNode: null, //_userNode,
                        controller: null, //_userController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (val) =>
                            FocusScope.of(context).nextFocus(),
                        validator: (val) {}, //=> _onUserValidate(val),
                        decoration: InputDecoration(
                          labelText: 'Usuário',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintText: 'Digite o usuário',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(Icons.face, color: Colors.white,),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
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
                            color: Colors.grey, //passwordFocusColor,
                          )),
                      child: TextFormField(
                        focusNode: null, //_passwordNode,
                        controller: null, //_passwordController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: null, //_onLoginPress(),
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Digite a senha',
                          prefixIcon: Icon(Icons.lock_outline),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text('Login'),
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Background'),
    );
  }
}
