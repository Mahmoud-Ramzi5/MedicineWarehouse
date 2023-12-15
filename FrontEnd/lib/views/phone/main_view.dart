import 'package:flutter/material.dart';
import 'package:test1/views/phone/cart_view.dart';
import 'package:test1/views/phone/home_view.dart';
import 'package:test1/views/phone/search_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(color: Colors.green),
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Icon(
                Icons.search,
              ),
              text: 'Search',
            ),
            Tab(
              icon: Icon(
                Icons.shopping_cart_checkout,
              ),
              text: 'Cart',
            ),
          ],
        ),
        //appBar: AppBar(),
        body: TabBarView(
          children: [HomeView(), SearchView(), CartView()],
        ),
      ),
    );
  }
}
