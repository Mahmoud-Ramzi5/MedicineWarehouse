import 'package:flutter/material.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/views/web/web_login_view.dart';

class WebLogoutView extends StatefulWidget {
  const WebLogoutView({super.key});

  @override
  State<WebLogoutView> createState() => _WebLogoutViewState();
}

class _WebLogoutViewState extends State<WebLogoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(webMainViewRoute, (route) => false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const WebLoginView(),
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
