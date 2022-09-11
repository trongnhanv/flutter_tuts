import 'dart:math';

import 'package:basic_tuts/udemy/shop_app/providers/auth_provider.dart';
import 'package:basic_tuts/udemy/shop_app/utils/noti_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { login, signup }

class AuthPage extends StatelessWidget {
  static const routeName = 'authPage';
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    transformConfig.translate(-10.0);
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(225, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1]),
          ),
        ),
        SingleChildScrollView(
          child: SizedBox(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 94),
                      transform: transformConfig,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange.shade900,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 8,
                                color: Colors.black26,
                                offset: Offset(0, 10))
                          ]),
                      child: Text(
                        'My Shop',
                        style: TextStyle(
                            color: Theme.of(context).textTheme.headline6!.color,
                            fontSize: 50,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Flexible(
                      child: const AuthCard(),
                      flex: deviceSize.width > 600 ? 2 : 1)
                ]),
          ),
        )
      ]),
    );
  }
}

class AuthCard extends StatefulWidget with NotiWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _form = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  AuthData _authData = const AuthData(email: '', password: '');
  final _pwController = TextEditingController();
  bool _loading = false;
  late Future<void> _future;

  void _submit() {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _loading = true;
    });
    if (_authMode == AuthMode.login) {
      _future = context.read<AuthProvider>().singin(_authData);
    } else {
      _future = context.read<AuthProvider>().signup(_authData);
    }
    _future.catchError((error) {
      widget.showAlertDialog(context,
          title: 'ERROR!', content: error.toString());
    }).whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
  }

  void _switchAuthMode() {
    _form.currentState!.reset();
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final isLoginMode = _authMode == AuthMode.login;
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 8.0,
        child: Container(
          height: !isLoginMode ? 320 : 260,
          constraints: BoxConstraints(
            minHeight: !isLoginMode ? 320 : 260,
          ),
          width: deviceSize.width * 0.75,
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Invalid email';
                      }
                    },
                    onSaved: (value) {
                      _authData = _authData.copyWith(email: value);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _pwController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Passowrd is too short';
                      }
                    },
                    onSaved: (value) {
                      _authData = _authData.copyWith(password: value);
                    },
                  ),
                  if (!isLoginMode)
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid password';
                        }
                        if (value != _pwController.text) {
                          return 'Passowrd do not match!';
                        }
                      },
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  _loading
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            ElevatedButton(
                                onPressed: _submit,
                                child: Text(isLoginMode ? 'Login' : 'Sign Up'),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 30),
                                    textStyle: TextStyle(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .button!
                                            .color))),
                            TextButton(
                                onPressed: _switchAuthMode,
                                child: Text(
                                    (!isLoginMode ? 'Login' : 'Sign Up') +
                                        ' instead'),
                                style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 30),
                                    primary: Theme.of(context).primaryColor))
                          ],
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
