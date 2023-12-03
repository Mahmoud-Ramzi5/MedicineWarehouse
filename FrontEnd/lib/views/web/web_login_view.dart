import 'package:flutter/material.dart';
import 'package:test1/customWidgets/text_forn_widget.dart';

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
      body: Center(
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
                    onPressed: () {},
                    child: const Icon(
                      Icons.login,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
