import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:warehouseweb/apis/web_api.dart';
import 'package:warehouseweb/constants/routes.dart';
import 'package:warehouseweb/customWidgets/text_forn_widget.dart';

class WebLoginView extends StatefulWidget {
  const WebLoginView({super.key});

  @override
  State<WebLoginView> createState() => _WebLoginViewState();
}

class _WebLoginViewState extends State<WebLoginView> {
  late final _formField = GlobalKey<FormState>();
  late final TextEditingController _userName;
  late final TextEditingController _password;
  bool passwordToggle = true;

  @override
  void initState() {
    _userName = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Medicine Warehouse'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // First Column with Container
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.green,
              child: const Text(
                'Your Health is our priority.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),

          // Second Column with Login Form
          Expanded(
            child: Center(
              child: Form(
                key: _formField,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/logo.png",
                        height: 300,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 500,
                        child: CustomTextWidget(
                          controller: _userName,
                          labelText: 'Username',
                          icon: const Icon(Icons.person),
                          obsecureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required field";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 500,
                        child: CustomTextWidget(
                          controller: _password,
                          icon: const Icon(Icons.lock),
                          labelText: 'Password',
                          obsecureText: passwordToggle,
                          inkWell: InkWell(
                            onTap: () {
                              setState(() {
                                passwordToggle = !passwordToggle;
                              });
                            },
                            child: Icon(passwordToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required field";
                            } else if (value.characters.length < 4) {
                              return "Password too short";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formField.currentState!.validate() == true) {
                              WebApi()
                                  .login(
                                _userName.text,
                                _password.text,
                              )
                                  .then(
                                (dynamic response) {
                                  final body = json.decode(response.body);
                                  if (response.statusCode == 200) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  webMainViewRoute,
                                                  (route) => false);
                                        });
                                        return AlertDialog(
                                          title: Text(body["message"]),
                                          content: const Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.green,
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          alignment: Alignment.center,
                                          title: Text(body["message"]),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                for (var value
                                                    in body["errors"].values)
                                                  for (var error in value)
                                                    Text(error),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Icon(
                                                    Icons.cancel_outlined,
                                                    color: Colors.red),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                              );
                            }
                          },
                          child: const Icon(Icons.login),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
