import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/customWidgets/text_forn_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _phoneNumber;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _pharmacyAddress;
  late final TextEditingController _pharmacyName;
  late final TextEditingController _confirmPassword;
  late final _formField = GlobalKey<FormState>();
  bool passwordToggle = true;
  bool passwordToggle2 = true;

  @override
  void initState() {
    _phoneNumber = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _pharmacyAddress = TextEditingController();
    _pharmacyName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _pharmacyAddress.dispose();
    _pharmacyName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formField,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CustomTextWidget(
                  controller: _phoneNumber,
                  hintText: 'Phone Number',
                  labelText: '+963',
                  icon: const Icon(Icons.phone_android),
                  obsecureText: false,
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
                const SizedBox(
                  height: 10,
                ),
                CustomTextWidget(
                  controller: _email,
                  hintText: 'Email',
                  labelText: '(Optional)',
                  icon: const Icon(Icons.email),
                  obsecureText: false,
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      if (!value.contains('@')) {
                        return "Invalid Email";
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextWidget(
                  controller: _pharmacyName,
                  labelText: 'Pharmacy Name',
                  icon: const Icon(Icons.local_pharmacy),
                  obsecureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextWidget(
                  controller: _pharmacyAddress,
                  labelText: 'Pharmacy address',
                  icon: const Icon(Icons.location_on),
                  obsecureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextWidget(
                  controller: _password,
                  labelText: 'Password',
                  icon: const Icon(Icons.lock),
                  obsecureText: passwordToggle,
                  inputType: TextInputType.visiblePassword,
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
                CustomTextWidget(
                  controller: _confirmPassword,
                  labelText: 'Confirm Password',
                  icon: const Icon(Icons.lock),
                  obsecureText: passwordToggle2,
                  inputType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    } else if (value.characters.length < 4) {
                      return "Password too short";
                    } else if (value != _password.text) {
                      return "Password does not match confirm password";
                    }
                    return null;
                  },
                  inkWell: InkWell(
                    onTap: () {
                      setState(() {
                        passwordToggle2 = !passwordToggle2;
                      });
                    },
                    child: Icon(passwordToggle2
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
                          .register(
                        int.parse(_phoneNumber.text),
                        _email.text,
                        _pharmacyName.text,
                        _pharmacyAddress.text,
                        _password.text,
                        _confirmPassword.text,
                      )
                          .then(
                        (dynamic response) {
                          final body = json.decode(response.body);
                          if (response.statusCode == 200) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                Future.delayed(const Duration(seconds: 3), () {
                                  Navigator.of(context).pushNamed(loginRoute);
                                });
                                return AlertDialog(
                                    title: Text(body["message"]),
                                    content: const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ));
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
                                        const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.red,
                                        )
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
                  child: const Icon(Icons.app_registration),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already registered? ',
                      style: TextStyle(fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          loginRoute,
                        );
                      },
                      child: const Text(
                        'Login',
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
