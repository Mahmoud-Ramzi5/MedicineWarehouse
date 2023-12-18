import 'package:flutter/material.dart';
import 'package:test1/apis/web_api.dart';
import 'package:test1/classes/medicine.dart';
import 'package:test1/constants/routes.dart';
import 'package:test1/views/web/add_medicine.dart';
import 'package:test1/views/web/web_login_view.dart';

class Web_Main extends StatefulWidget {
  const Web_Main({Key? key}) : super(key: key);

  @override
  State<Web_Main> createState() => _Web_MainState();
}

class _Web_MainState extends State<Web_Main> {
  String selectedTitle = 'Home';
  int selectedIndex = 0;
  late final TextEditingController _search;
  String searchQuery = '';

  @override
  void initState() {
    _search = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.green,
            selectedLabelTextStyle: const TextStyle(color: Colors.black),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white),
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
                icon: Icon(Icons.language, color: Colors.white),
                label: Text('Language'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text('Log Out'),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: WebApi().fetchMedicineWeb(),
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
                                          top: 9,
                                          bottom: 9,
                                          left: 9,
                                        ),
                                        height: 99,
                                        width: 108,
                                        decoration: const ShapeDecoration(
                                          shape: ContinuousRectangleBorder(),
                                          color: Colors.green,
                                        ),
                                        child: Image.network(
                                            'http://127.0.0.1:8000/storage/${filteredMedicines[index].imagePath}',
                                            fit: BoxFit.cover)),
                                    Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                '${filteredMedicines[index].medicineTranslations["en"]["commercial_name"]}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 18,
                                                  bottom: 18,
                                                  left: 9,
                                                  right: 18,
                                                ),
                                                child: Text(
                                                  'Price: ${filteredMedicines[index].price}',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                'Quantity: ${filteredMedicines[index].quantityAvailable}',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 18),
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
                            itemCount: filteredMedicines.length,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
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
