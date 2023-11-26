import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/constants/routes.dart';

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
        centerTitle: true,
      ),
      body: Form(
        key: _formField,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _phoneNumber,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    }
                    if (value.characters.length != 9) {
                      return "Invalid number";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: '+963',
                    hintStyle: TextStyle(fontSize: 20),
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone_android),
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _email,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'email',
                    hintText: '(optional)',
                    hintStyle: TextStyle(fontSize: 20),
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _pharmacyName,
                  autocorrect: false,
                  enableSuggestions: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Pharmacy Name',
                    labelStyle: TextStyle(fontSize: 20),
                    prefixIcon: Icon(Icons.local_pharmacy),
                    border: OutlineInputBorder(),
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _pharmacyAddress,
                  autocorrect: false,
                  enableSuggestions: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Pharmacy address',
                    labelStyle: TextStyle(fontSize: 20),
                    prefixIcon: Icon(Icons.location_on),
                    border: OutlineInputBorder(),
                    iconColor: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _password,
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: passwordToggle,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    }
                    if (value.characters.length < 4) {
                      return "Password too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 20),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    iconColor: Colors.green,
                    suffixIcon: InkWell(
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
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _confirmPassword,
                  autocorrect: false,
                  enableSuggestions: false,
                  obscureText: passwordToggle,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required field";
                    } else if (value != _password.text) {
                      return "Password does not match required password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(fontSize: 20),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    iconColor: Colors.green,
                    suffixIcon: InkWell(
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
