import 'package:flutter/material.dart';
import 'package:test1/views/web/web_add_medicine_view.dart';
import 'package:test1/views/web/web_home_view.dart';
import 'package:test1/views/web/web_login_view.dart';
import 'package:test1/views/web/web_orders_view.dart';
import 'package:test1/views/web/web_reports_view.dart';
import 'package:test1/views/web/web_search_view.dart';

class WebMainView extends StatefulWidget {
  const WebMainView({super.key});

  @override
  State<WebMainView> createState() => _WebMainViewState();
}

class _WebMainViewState extends State<WebMainView> {
  Widget showLogoutDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Log Out'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const WebLoginView(),
              ),
            );
          },
          child: const Text('Log out'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Scaffold(
        appBar: const TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(color: Colors.green),
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
              ),
              text: "Home",
            ),
            Tab(
              icon: Icon(
                Icons.search,
              ),
              text: "Search",
            ),
            Tab(
              icon: Icon(
                Icons.add,
              ),
              text: "Add Medicine",
            ),
            Tab(
              icon: Icon(
                Icons.shopping_cart,
              ),
              text: "Orders",
            ),
            Tab(
              icon: Icon(
                Icons.insert_chart,
              ),
              text: "Reports",
            ),
            Tab(
              icon: Icon(
                Icons.logout,
              ),
              text: "Logout",
            ),
          ],
        ),
        body: TabBarView(
          children: [
            const WebHomeView(),
            const WebSearchView(),
            const AddMedicineView(),
            const WebOrdersView(),
            const WebReportsView(),
            showLogoutDialog(context),
          ],
        ),
      ),
    );
  }
}
