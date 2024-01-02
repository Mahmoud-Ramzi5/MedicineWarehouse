import 'package:flutter/material.dart';
import 'package:warehouseweb/apis/web_api.dart';
import 'package:warehouseweb/classes/medicine.dart';

class WebSearchView extends StatefulWidget {
  const WebSearchView({super.key});

  @override
  State<WebSearchView> createState() => _WebSearchViewState();
}

class _WebSearchViewState extends State<WebSearchView> {
  late final TextEditingController _search;
  List<Medicine> _medicines = [];

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
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
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
                        'http://127.0.0.1:8000/storage/${_medicines[index].imagePath}',
                        fit: BoxFit.cover)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Search: ${_medicines[index].medicineTranslations["en"]["commercial_name"]}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Price: ${_medicines[index].price}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Quantity: ${_medicines[index].quantityAvailable}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "Scientific Name: ${_medicines[index].medicineTranslations["en"]["scientific_name"]}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Manufacture company: ${_medicines[index].medicineTranslations["en"]["manufacture_company"]}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Expiry Date: ${_medicines[index].expiryDate}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Categories:",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          for (var category in _medicines[index].categories)
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '${category["en_category_name"]} ',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
      itemCount: _medicines.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: SearchBar(
              controller: _search,
              hintText: "Search",
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
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }
}
