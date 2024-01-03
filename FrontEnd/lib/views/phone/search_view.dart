import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/classes/medicine.dart';
import 'package:test1/constants/routes.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
    final medicines = await Api().search(value);
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
                      '${medicine.medicineTranslations["1".tr]["commercial_name"]}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${"41".tr}: ${medicine.price}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${"39".tr}: ${medicine.quantityAvailable}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        medicineDetailsRoute,
                        arguments: _medicines[index],
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
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
