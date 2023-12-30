import 'package:flutter/material.dart';
import 'package:test1/views/web/web_add_medicine_view.dart';
import 'package:test1/views/web/web_home_view.dart';
import 'package:test1/views/web/web_logout_view.dart';
import 'package:test1/views/web/web_orders_view.dart';
import 'package:test1/views/web/web_reports_view.dart';
import 'package:test1/views/web/web_search_view.dart';

class WebMainView extends StatefulWidget {
  const WebMainView({super.key});

  @override
  State<WebMainView> createState() => _WebMainViewState();
}

class _WebMainViewState extends State<WebMainView> {
  int index = 0;

  dynamic buildPages() {
    switch (index) {
      case 0:
        return const WebHomeView();
      case 1:
        return const WebSearchView();
      case 2:
        return const AddMedicineView();
      case 3:
        return const WebOrdersView();
      case 4:
        return const WebReportsView();
      case 5:
        return const WebLogoutView();
      default:
        return const WebHomeView();
    }
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
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              this.index = index;
            }),
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
                  'Logout',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: buildPages()),
        ],
      ),
    );
  }
}
