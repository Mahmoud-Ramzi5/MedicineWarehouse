import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(5),
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
            FutureBuilder(
              future: Api().search(_search.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final medicines = snapshot.data;
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
                                        '${medicines[index].medicineTranslations["en"]["commercial_name"]}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                          'Price: ${medicines[index].price}',
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        'Quantity: ${medicines[index].quantityAvailable}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: medicines!.length,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
