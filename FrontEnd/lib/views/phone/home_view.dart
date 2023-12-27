import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/classes/cart_controller.dart';
import 'package:test1/classes/cart_item.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/l10n/local_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CartController cartController;
  late MyLocalController localController;
  int initIndex = 0;
  @override
  void initState() {
    cartController = Get.put(CartController());
    localController = Get.put(MyLocalController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 120,
              width: 120,
              decoration: const ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text(
                "24".tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              leading: const Icon(
                Icons.shopping_cart,
                color: Colors.green,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(viewOrdersRoute);
              },
            ),
            ListTile(
              title: Text(
                "25".tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              leading: const Icon(
                Icons.star_sharp,
                color: Colors.green,
              ),
              onTap: () {
                Navigator.of(context).pushNamed(favoritesRoute);
              },
            ),
            ListTile(
              title: Text(
                "26".tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.green,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      alignment: Alignment.center,
                      title: Text("26".tr),
                      content: Text("27".tr),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "28".tr,
                            style: const TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Api().logout().then((dynamic response) {
                              final body = json.decode(response.body);
                              if (response.statusCode == 200) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    loginRoute, (route) => false);
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(body["message"]),
                                      content: const Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                          },
                          child: Text(
                            "29".tr,
                            style: const TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text(
                "53".tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              leading: const Icon(
                Icons.language,
                color: Colors.green,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  ToggleSwitch(
                    activeBgColor: const [Colors.green],
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.black,
                    customTextStyles: const [
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                    ],
                    changeOnTap: true,
                    initialLabelIndex: initIndex,
                    totalSwitches: 2,
                    labels: const ["English", "عربي"],
                    onToggle: (index) {
                      initIndex = index!;
                      if (initIndex == 0) {
                        localController.changeLang("en");
                      } else if (initIndex == 1) {
                        localController.changeLang("ar");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: Api().fetchMedicine(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final medicines = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      height: 50,
                      width: 400,
                      child: FutureBuilder(
                        future: Api().fetchCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            final categories = snapshot.data;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories?.length,
                              physics: const PageScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          viewCategoriesRoute,
                                          arguments: categories[index].id);
                                    },
                                    child: Text(
                                      categories![index].categoryName,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  ListView.builder(
                    physics: const PageScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            Container(
                                margin: const EdgeInsets.all(10),
                                height: 100,
                                width: 100,
                                decoration: const ShapeDecoration(
                                    shape: ContinuousRectangleBorder(),
                                    color: Colors.green),
                                child: Image.network(
                                    'http://10.0.2.2:8000/storage/${medicines[index].imagePath}',
                                    fit: BoxFit.cover)),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        '${medicines[index].medicineTranslations["1".tr]["commercial_name"]}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                          "${"41".tr}: ${medicines[index].price}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        "${"39".tr}: ${medicines[index].quantityAvailable}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              medicineDetailsRoute,
                                              arguments: medicines[index],
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.green,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            CartItem cartItem = CartItem(
                                                medicine: medicines[index],
                                                quantity: 1);
                                            cartController.addToCart(cartItem);
                                          },
                                          icon: const Icon(
                                            Icons.add_shopping_cart_outlined,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: medicines!.length,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
