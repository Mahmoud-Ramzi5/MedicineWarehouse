import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/classes/medicine.dart';
import 'package:test1/constants/routes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Medicine> fetchMedicine() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/users/medicines'),
  );

  if (response.statusCode == 200) {
    return Medicine.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load Medicines');
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final TextEditingController _search;
  late Future<Medicine> futureMedicine;
  final items = List.generate(20, (index) => index);
  @override
  void initState() {
    _search = TextEditingController();
    super.initState();
    futureMedicine = fetchMedicine();
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
                            Api()
                                .logout()
                                .then((Map<String, dynamic> response) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  loginRoute, (route) => false);
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
              ListView.builder(
                physics: const PageScrollPhysics(),
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Commercial name:$futureMedicine',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.green,
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Price: $index',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: items.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
