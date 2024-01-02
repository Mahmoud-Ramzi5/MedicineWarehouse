import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        title: Text("11".tr),
      ),
      body: Form(
        key: _formField,
        child: SingleChildScrollView(
          physics: const PageScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CustomTextWidget(
                  controller: _phoneNumber,
                  hintText: "3".tr,
                  labelText: '+963',
                  icon: const Icon(Icons.phone_android),
                  obsecureText: false,
                  inputType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "4".tr;
                    } else if (value.characters.length != 9) {
                      return "5".tr;
                    } else if (!value.startsWith('9')) {
                      return "6.tr";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextWidget(
                  controller: _email,
                  hintText: "12".tr,
                  labelText: "13".tr,
                  icon: const Icon(Icons.email),
                  obsecureText: false,
                  inputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      if (!value.contains('@')) {
                        return "14".tr;
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
                  labelText: "15".tr,
                  icon: const Icon(Icons.local_pharmacy),
                  inputType: TextInputType.text,
                  obsecureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "4".tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextWidget(
                  controller: _pharmacyAddress,
                  labelText: "16".tr,
                  icon: const Icon(Icons.location_on),
                  inputType: TextInputType.text,
                  obsecureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "4".tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextWidget(
                  controller: _password,
                  labelText: "7".tr,
                  icon: const Icon(Icons.lock),
                  obsecureText: passwordToggle,
                  inputType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "4".tr;
                    } else if (value.characters.length < 4) {
                      return "8".tr;
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
                  labelText: "17".tr,
                  icon: const Icon(Icons.lock),
                  obsecureText: passwordToggle2,
                  inputType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "4".tr;
                    } else if (value.characters.length < 4) {
                      return "8".tr;
                    } else if (value != _password.text) {
                      return "18".tr;
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
                                Future.delayed(
                                  const Duration(seconds: 3),
                                  () {
                                    Navigator.of(context).pushNamed(loginRoute);
                                  },
                                );
                                return AlertDialog(
                                  title: Text("21".tr),
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
                                  title: Text("22".tr),
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
                    Text(
                      "23".tr,
                      style: const TextStyle(fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          loginRoute,
                        );
                      },
                      child: Text(
                        "2".tr,
                        style: const TextStyle(
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
