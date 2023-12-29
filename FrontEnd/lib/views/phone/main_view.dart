import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const BoxDecoration(color: Colors.green),
          unselectedLabelColor: Colors.black,
          labelStyle:
              const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          tabs: <Widget>[
            Tab(
              icon: const Icon(
                Icons.home,
              ),
              text: "30".tr,
            ),
            Tab(
              icon: const Icon(
                Icons.search,
              ),
              text: "31".tr,
            ),
            Tab(
              icon: const Icon(
                Icons.shopping_cart_checkout,
              ),
              text: "32".tr,
            ),
          ],
        ),
        body: const TabBarView(
          children: [HomeView(), SearchView(), CartView()],
        ),
      ),
    );
  }
}
