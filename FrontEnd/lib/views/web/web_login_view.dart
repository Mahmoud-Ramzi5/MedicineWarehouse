import 'package:flutter/material.dart';

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
                  child: TextFormField(
                    controller: _userName,
                    autocorrect: false,
                    enableSuggestions: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter user name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(fontSize: 20),
                      labelText: 'User Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      iconColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 500,
                  child: TextFormField(
                    controller: _password,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    enableSuggestions: false,
                    obscureText: passwordToggle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter password";
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
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.login,
                    color: Colors.green,
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
