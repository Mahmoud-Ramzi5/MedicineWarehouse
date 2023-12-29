import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/apis/web_api.dart';
import 'package:test1/classes/medicine.dart';

class Search_webView extends StatefulWidget {
  const Search_webView({super.key});

  @override
  State<Search_webView> createState() => _SearchViewState();
}

class _SearchViewState extends State<Search_webView> {
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
                            '${"34".tr}: ${_medicines[index].medicineTranslations["1".tr]["commercial_name"]}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "${"41".tr}: ${_medicines[index].price}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "${"39".tr}: ${_medicines[index].quantityAvailable}",
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
                            "${"35".tr}: ${_medicines[index].medicineTranslations["en"]["scientific_name"]}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "${"36".tr}: ${_medicines[index].medicineTranslations["en"]["manufacture_company"]}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "${"40".tr}: ${_medicines[index].expiryDate}",
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
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "${"37".tr}:",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          for (var category in _medicines[index].categories)
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                '${category["38".tr]} ',
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
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: SearchBar(
              controller: _search,
              hintText: "31".tr,
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
