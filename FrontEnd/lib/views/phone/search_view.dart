import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
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
            setState(() {
              searchQuery = value;
            });
          },
        ),
      ),
    );
  }
}
