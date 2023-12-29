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
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Card(
                                        elevation: 5,
                                        child: Row(
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.all(10),
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
                                                                FontWeight
                                                                    .bold),
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
                                                                FontWeight
                                                                    .bold),
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
                                                                FontWeight
                                                                    .bold),
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
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
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
                                                            const EdgeInsets
                                                                .all(10),
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
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Text(
                                                          "${"37".tr}:",
                                                          style:
                                                              const TextStyle(
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
                                                                  FontWeight
                                                                      .bold,
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
  OrderCardState createState() => OrderCardState();
}

class OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Order ID: ${widget.webOrder.id}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        'User ID: ${widget.webOrder.userId}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'PREPARING',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: "PREPARING" == widget.webOrder.status,
                      onChanged: (isChecked) {},
                    ),
                    const Text(
                      'SENT',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: "SENT" == widget.webOrder.status,
                      onChanged: (value) {
                        setState(() {
                          if (widget.webOrder.status == "PREPARING") {
                            WebApi().orderstauts(
                              widget.webOrder.id,
                              "SENT",
                              widget.webOrder.paid,
                            );
                          }
                        });
                      },
                    ),
                    const Text(
                      'RECEIVED',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: "RECEIVED" == widget.webOrder.status,
                      onChanged: (value) {
                        setState(() {
                          if (widget.webOrder.status == "SENT") {
                            WebApi().orderstauts(
                              widget.webOrder.id,
                              "RECEIVED",
                              widget.webOrder.paid,
                            );
                          }
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Billing Status: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Paid',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Checkbox(
                      value: widget.webOrder.paid,
                      onChanged: (value) {
                        setState(() {
                          if (!widget.webOrder.paid) {
                            WebApi().orderstauts(
                              widget.webOrder.id,
                              widget.webOrder.status,
                              true,
                            );
                          }
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      'Ordered Medicines:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 500,
                      child: ListView.builder(
                        physics: const PageScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Text(
                                '${widget.webOrder.orderedMedicines[index].medicine.medicineTranslations["en"]["commercial_name"]}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Quantity: ${widget.webOrder.orderedMedicines[index].quantity}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Single unit price: ${widget.webOrder.orderedMedicines[index].medicine.price}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        itemCount: widget.webOrder.orderedMedicines.length,
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
