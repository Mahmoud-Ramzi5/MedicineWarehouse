import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/apis/web_api.dart';
import 'package:test1/views/web/add_medicine.dart';
import 'package:test1/views/web/search_web.dart';
import 'package:test1/views/web/web_login_view.dart';
import 'package:test1/views/web/web_order.dart';

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
              child: const Text('Log Out'),
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
                  updateTitle('Home');
                  break;
                case 1:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Search_webView(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Add_Medicine(),
                    ),
                  );
                  break;
                case 3:
                  updateTitle('Oreders');
                  break;
                case 4:
                  updateTitle('Reports');
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
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search, color: Colors.white),
                label: Text('Search'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.add, color: Colors.white),
                label: Text('Add Medicine'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart, color: Colors.white),
                label: Text('Orders'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.insert_chart, color: Colors.white),
                label: Text('Reports'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text('LogOut'),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (selectedIndex == 0)
                    FutureBuilder(
                      future: WebApi().fetchMedicineWeb(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final medicines = snapshot.data;
                          return SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                                  shape:
                                                      ContinuousRectangleBorder(),
                                                  color: Colors.green),
                                              child: Image.network(
                                                  'http://127.0.0.1:8000/storage/${medicines[index].imagePath}',
                                                  fit: BoxFit.cover)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      '${"34".tr}: ${medicines[index].medicineTranslations["1".tr]["commercial_name"]}',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "${"41".tr}: ${medicines[index].price}",
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "${"39".tr}: ${medicines[index].quantityAvailable}",
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${"35".tr}: ${medicines[index].medicineTranslations["en"]["scientific_name"]}",
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                        "${"36".tr}: ${medicines[index].medicineTranslations["en"]["manufacture_company"]}",
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                        "${"40".tr}: ${medicines[index].expiryDate}",
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Text(
                                                        "${"37".tr}:",
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    for (var category
                                                        in medicines[index]
                                                            .categories)
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Text(
                                                          '${category["38".tr]} ',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              )
                                            ],
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
                  if (selectedIndex == 3)
                    FutureBuilder(
                      future: WebApi().fetchweborders(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          final weborders = snapshot.data;
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                physics: const PageScrollPhysics(),
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return OrderCard(webOrder: weborders![index]);
                                },
                                itemCount: weborders?.length ?? 0,
                              ),
                            ),
                          );
                        }
                      },
                    )
                  else
                    Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void updateTitle(String title) {
    setState(() {
      selectedTitle = title;
    });
  }
}

class OrderCard extends StatefulWidget {
  final WebOrder webOrder;

  const OrderCard({Key? key, required this.webOrder}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  int selectedStatus = 1;
  int paymentStatus = 4;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Orders'),
          Text('Order ID: ${widget.webOrder.id}'),
          Text('Ordered Medicines: ${widget.webOrder.orderedMedicines}'),
          Text('Price: ${widget.webOrder.totalPrice}'),
          Text('status:${widget.webOrder.status}'),
          Row(
            //if(widget.webOrder.status == "SENT")
            children: [
              Row(
                children: [
                  //  if(widget.webOrder.status == "PREPARING"){
                  Checkbox(
                    value: selectedStatus == 1,
                    onChanged: (isChecked) {
                      setState(
                        () {
                          if (selectedStatus != 2 &&
                              selectedStatus != 3 &&
                              isChecked!) {
                            selectedStatus = 1;
                            WebApi().orderstauts(widget.webOrder.id,
                                "PREPARING", widget.webOrder.paid);
                          }
                        },
                      );
                    },
                  ),
                  const Text('PREPARING'),
                  Checkbox(
                    value: selectedStatus == 2,
                    onChanged: (isChecked) {
                      setState(
                        () {
                          if (selectedStatus == 1 && isChecked!) {
                            selectedStatus = 2;
                            WebApi().orderstauts(widget.webOrder.id, "SENT",
                                widget.webOrder.paid);
                          }
                        },
                      );
                    },
                  ),
                  const Text('SENT'),
                  Checkbox(
                    value: selectedStatus == 3,
                    onChanged: (isChecked) {
                      setState(
                        () {
                          if (selectedStatus == 2 && isChecked!) {
                            selectedStatus = 3;
                            WebApi().orderstauts(widget.webOrder.id, "RECEIVED",
                                widget.webOrder.paid);
                          }
                        },
                      );
                    },
                  ),
                  const Text('RECEIVED'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: paymentStatus == 4,
                    onChanged: (isChecked) {
                      setState(
                        () {
                          if (selectedStatus != 2 &&
                              selectedStatus != 3 &&
                              isChecked!) {
                            paymentStatus = 4;
                          }
                        },
                      );
                    },
                  ),
                  const Text('UnPaid'),
                  Checkbox(
                    value: paymentStatus == 5,
                    onChanged: (isChecked) {
                      setState(() {
                        if (paymentStatus == 4 && isChecked!) {
                          paymentStatus = 5;
                        }
                      });
                    },
                  ),
                  const Text('Paid'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
