import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/classes/medicine.dart';
import 'package:test1/classes/order.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/l10n/local.dart';
import 'package:test1/l10n/local_controller.dart';
import 'package:test1/views/phone/cart_view.dart';
import 'package:test1/views/phone/login_view.dart';
import 'package:test1/views/phone/main_view.dart';
import 'package:test1/views/phone/medicine_details_view.dart';
import 'package:test1/views/phone/order_details_view.dart';
import 'package:test1/views/phone/register_view.dart';
import 'package:test1/views/phone/view_category.dart';
import 'package:test1/views/phone/view_favorites.dart';
import 'package:test1/views/phone/view_orders.dart';
import 'package:test1/views/web/web_search_view.dart';
import 'package:test1/views/web/web_login_view.dart';
import 'package:test1/views/web/web_main.dart';
import 'package:test1/views/web/web_add_medicine_view.dart';
import 'package:test1/views/web/web_main_view.dart';

SharedPreferences? prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyLocalController controller = Get.put(MyLocalController());
    return GetMaterialApp(
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
        searchwebRoute: (context) => const WebSearchView(),
        webMainViewRoute: (context) => const WebMainView(),
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
      locale: Get.deviceLocale,
      translations: MyLocal(),
      home: const WebLoginView(),
    );
  }
}
