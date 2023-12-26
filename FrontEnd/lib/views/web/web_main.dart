import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test1/apis/web_api.dart';
import 'package:test1/classes/medicine.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/views/web/add_medicine.dart';
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
  late final TextEditingController _search;
  String searchQuery = '';
  bool shouldFetchData = true;
  late final WebOrder web_orders;
int selectedStatus = 1;
List<Medicine> _medicines = [];
  @override
  void initState() {
    _search = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _search.dispose();
    shouldFetchData = false;
    super.dispose();
  }

  List<Medicine> filterMedicines(List<Medicine> medicines) {
    if (searchQuery.isEmpty) {
      return medicines;
    } else {
      return medicines
          .where((medicine) => medicine.medicineTranslations["en"]
                  ["commercial_name"]
              .toString()
              .toLowerCase()
              .contains(searchQuery))
          .toList();
    }
  }


Future<void> _onSearchSubmitted(String value) async {
    final medicines = await WebApi().search(value);
    setState(() {
      _medicines = medicines;
    });
  }



  Widget _buildSearchResults() {
    return ListView.builder(
      physics: const PageScrollPhysics(),
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final medicine = _medicines[index];
        return Card(
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.green,
                ),
                child: Image.network(
                  'http://10.0.2.2:8000/storage/${medicine.imagePath}',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${medicine.medicineTranslations["en"]["commercial_name"]}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Price: ${medicine.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Quantity: ${medicine.quantityAvailable}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: _medicines.length,
    );
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
      body: Row(children: [
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
                    builder: (context) => const Add_Medicine(),
                  ),
                );
                break;
              case 2:
                updateTitle('Orders');
                break;
              case 3:
                updateTitle('Reports');
                break;
              case 4:
                updateTitle('Language');
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
              label: Text('Log Out'),
            ),
          ],
        ),
        Expanded(
          child: selectedIndex == 0
              ? FutureBuilder(
                  future: shouldFetchData ? WebApi().fetchMedicineWeb() : null,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final medicines = snapshot.data;
                      final filteredMedicines = filterMedicines(medicines!);
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: SizedBox(
                                  width: 1500,
                                  child: SearchBar(
                                    controller: _search,
                                    hintText: 'Search',
                                    leading: const Icon(Icons.search),
                                    shape: const MaterialStatePropertyAll(
                                      BeveledRectangleBorder(),
                                    ),
                                    textStyle: const MaterialStatePropertyAll(
                                      TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    side: const MaterialStatePropertyAll(
                                      BorderSide(
                                        color: Colors.green,
                                      ),
                                    ),
                                    onSubmitted: (value) {
                                      setState(() {
                                        searchQuery = value;
                                      });
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
                                          margin: const EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 10,
                                          ),
                                          height: 100,
                                          width: 100,
                                          decoration: const ShapeDecoration(
                                            shape: ContinuousRectangleBorder(),
                                            color: Colors.green,
                                          ),
                                          child: Image.network(
                                            'http://127.0.0.1:8000/storage/${medicines[index].imagePath}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    '${medicines[index].medicineTranslations["en"]["commercial_name"]}',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      top: 20,
                                                      bottom: 20,
                                                      left: 10,
                                                      right: 20,
                                                    ),
                                                    child: Text(
                                                      'Price: ${medicines[index].price}',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Quantity: ${medicines[index].quantityAvailable}',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20),
                                                child: Column(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                          medicineDetailsRoute,
                                                          arguments:
                                                              filteredMedicines[
                                                                  index],
                                                        );
                                                      },
                                                      icon: const Icon(
                                                        Icons.arrow_forward_ios,
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
                                itemCount: medicines.length,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                )
:selectedIndex == 2
    ? FutureBuilder(
        future: WebApi().fetchweborders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
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
    : Container(),
        )

      ]),
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
  int paymentStatus=4;

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
      Row(
        children: [
          Radio(
            value: 1,
            groupValue: selectedStatus,
            onChanged: (value) {
              setState(() {
       if (selectedStatus != 2 && selectedStatus != 3) {
                  selectedStatus = value as int;
                }
              });
            },
          ),
          const Text('Preparing'),
          Radio(
            value: 2,
            groupValue: selectedStatus,
            onChanged: (value) {
              setState(() {
                if (selectedStatus == 1 ) {
                  selectedStatus = value as int;
                }
              });
            },
          ),
          const Text('Sending'),
          Radio(
            value: 3,
            groupValue: selectedStatus,
            onChanged: (value) {
              setState(() {
                if (selectedStatus == 2) {
                  selectedStatus = value as int;
                }
              });
            },
          ),
          const Text('Sent'),
        ],
      ),
      Row(
        children: [
          Radio(
            value: 4,
            groupValue: paymentStatus,
            onChanged: (value) {
              setState(() {
                if (selectedStatus != 2 && selectedStatus != 3) {
                  paymentStatus = value as int;
                }
              });
            },
          ),
          const Text('UnPaid'),
          Radio(
            value: 5,
            groupValue: paymentStatus,
            onChanged: (value) {
              setState(() {
                if (paymentStatus==4) {
                  paymentStatus = value as int;
                }
              });
            },
          ),
          const Text('Paid'),
        ],
      ),
    ],
  ),
);

 }
}
