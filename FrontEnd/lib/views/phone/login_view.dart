import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/customWidgets/text_forn_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final _formField = GlobalKey<FormState>();
  late final TextEditingController _phoneNumber;
  late final TextEditingController _password;
  bool passwordToggle = true;
  late bool rememberMe = true;

  @override
  void initState() {
    _phoneNumber = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formField,
        child: SingleChildScrollView(
          physics: const PageScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextWidget(
                  controller: _phoneNumber,
                  labelText: 'Phone Number',
                  icon: const Icon(Icons.phone_android),
                  obsecureText: false,
                  hintText: '+963',
                  inputType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    } else if (value.characters.length != 9) {
                      return "Invalid number";
                    } else if (!value.startsWith('9')) {
                      return 'Phone Number must start with 9';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextWidget(
                  controller: _password,
                  labelText: 'Password',
                  icon: const Icon(Icons.lock),
                  obsecureText: passwordToggle,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    } else if (value.characters.length < 4) {
                      return "Password too short";
                    }
                    return null;
                  },
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
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formField.currentState!.validate() == true) {
                      Api()
                          .login(int.parse(_phoneNumber.text), _password.text,
                              rememberMe)
                          .then(
                        (dynamic response) {
                          final body = json.decode(response.body);
                          if (response.statusCode == 200) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      mainRoute, (route) => false);
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
                                        for (var value in body["errors"].values)
                                          for (var error in value) Text(error),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Icon(Icons.cancel_outlined,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Remember me",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(
                          () {
                            rememberMe = !rememberMe;
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not Registered ?',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          registerRoute,
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
