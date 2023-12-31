import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/apis/web_api.dart';
import 'package:test1/views/web/web_add_medicine_view.dart';
import 'package:test1/views/web/web_home_view.dart';
import 'package:test1/views/web/web_orders_view.dart';
import 'package:test1/views/web/web_reports_view.dart';
import 'package:test1/views/web/web_search_view.dart';
import 'package:test1/views/web/web_login_view.dart';
import 'package:test1/classes/web_order.dart';

class Web_Main extends StatefulWidget {
  const Web_Main({Key? key}) : super(key: key);

  @override
  State<Web_Main> createState() => _WebMainState();
}

class _WebMainState extends State<Web_Main> {
  String selectedTitle = 'Home';
  int selectedIndex = 0;
  bool shouldFetchData = true;
  late final WebOrder web_orders;
  int selectedStatus = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    shouldFetchData = false;
    super.dispose();
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.green,
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            unselectedLabelTextStyle: const TextStyle(color: Colors.black),
            selectedIndex: selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
              });
              switch (index) {
                case 0:
                const WebHomeView();
                  break;
                case 1:
                  const WebSearchView();
                  break;
                case 2:
                  const AddMedicineView();
                  break;
                case 3:
                  const WebOrdersView();
                  break;
                case 4:
                  const WebReportsView();
                  break;
                case 5:
                  showLogoutDialog(context);
                  break;
              }
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home, color: Colors.white),
                label: Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search, color: Colors.white),
                label: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Add Medicine',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                label: Text(
                  'Orders',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.insert_chart, color: Colors.white),
                label: Text(
                  'Reports',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'Log out',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    ]
    )
    );
  }
}

