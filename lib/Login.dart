import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType {
  login,
  register,
  edit
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _musicFilter = new TextEditingController();
  String _email = "";
  String _password = "";
  String _music = "";
  FormType _form = FormType.login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
    _musicFilter.addListener(_musicListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

   void _musicListen() {
    if (_musicFilter.text.isEmpty) {
      _music = "";
    } else {
      _music = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange () async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Simple Login Example"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    if (_form == FormType.login) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                labelText: 'Email'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
    }else{
      return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(
                labelText: 'Email'
              ),
            ),
          ),
          new Container(
            child: new TextField(
              controller: _passwordFilter,
              decoration: new InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
          ),
          new Container(
            child: new TextField(
              controller: _musicFilter,
              decoration: new InputDecoration(
                labelText: 'Music'
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
    }
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Login'),
              onPressed: _loginPressed,
            ),
            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.'),
              onPressed: _formChange,
            ),
            new FlatButton(
              child: new Text('Forgot Password?'),
              onPressed: _passwordReset,
            )
          ],
        ),
      );
    } else if (_form == FormType.register) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Create an Account'),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }else{
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Edit profile'),
              onPressed: _createAccountPressed,
              //TODO: ojo aquí
            )
          ],
        ),
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed () {
    print('The user wants to login with $_email and $_password');
  }

  void _createAccountPressed () {
    print('The user wants to create an accoutn with $_email and $_password');

  }

  void _passwordReset () {
    print("The user wants a password reset request sent to $_email");
  }
}