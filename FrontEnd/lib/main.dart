import 'package:flutter/material.dart';
import 'package:test1/classes/medicine.dart';
import 'package:test1/classes/order.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/views/phone/cart_view.dart';
import 'package:test1/views/phone/login_view.dart';
import 'package:test1/views/phone/main_view.dart';
import 'package:test1/views/phone/medicine_details_view.dart';
import 'package:test1/views/phone/order_details_view.dart';
import 'package:test1/views/phone/register_view.dart';
import 'package:test1/views/phone/view_category.dart';
import 'package:test1/views/phone/view_favorites.dart';
import 'package:test1/views/phone/view_orders.dart';
import 'package:test1/views/web/web_login_view.dart';
import 'package:test1/views/web/web_main.dart';
import 'package:test1/views/web/add_medicine.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      mainRoute: (context) => const MainView(),
      cartRoute: (context) => const CartView(),
      viewOrdersRoute: (context) => const ViewOrders(),
      mainwebRoute: (context) => const Web_Main(),
      favoritesRoute: (context) => const ViewFavorites(),
    },
    onGenerateRoute: (settings) {
      if (settings.name == medicineDetailsRoute) {
        final Medicine medicine = settings.arguments as Medicine;
        return MaterialPageRoute(
          builder: (context) {
            return MedicineDetailsView(medicine: medicine);
          },
        );
      }
      if (settings.name == viewCategoriesRoute) {
        final int id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return ViewCategoty(id: id);
          },
        );
      }
      if (settings.name == orderDetailsRoute) {
        final Order order = settings.arguments as Order;
        return MaterialPageRoute(
          builder: (context) {
            return OrderDetailsView(order: order);
          },
        );
      }
    },
    home: const Web_Main(),
  ));
}
