import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/constants/routes.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final TextEditingController _search;
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
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
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
              title: const Text(
                'Log out',
                style: TextStyle(fontSize: 20),
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
                      title: const Text('Log out'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
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
                          child: const Text(
                            'Yes',
                            style: TextStyle(
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
          ],
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              SearchBar(
                controller: _search,
                hintText: 'Search',
                leading: const Icon(Icons.search),
                shape: const MaterialStatePropertyAll(
                  StadiumBorder(),
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
              ),
              FutureBuilder(
                future: Api().fetchMedicine(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final medicineList = snapshot.data;
                    return ListView.builder(
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
                                  top: 18,
                                  bottom: 18,
                                  left: 18,
                                ),
                                height: 100,
                                width: 100,
                                decoration: const ShapeDecoration(
                                    shape: ContinuousRectangleBorder(),
                                    color: Colors.green),
                                child: const Icon(
                                  Icons.medication,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${medicineList[index].medicineTranslations["en"]["commercial_name"]}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            'Price: ${medicineList[index].price}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          'Quantity: ${medicineList[index].quantityAvailable}',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  medicineDetailsRoute,
                                                  arguments:
                                                      medicineList[index]);
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
                      itemCount: medicineList!.length,
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(170.0),
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
