import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';

class SelectCategoriesView extends StatefulWidget {
  const SelectCategoriesView({super.key});

  @override
  State<SelectCategoriesView> createState() => _SelectCategoriesViewState();
}

class _SelectCategoriesViewState extends State<SelectCategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Category')),
      body: FutureBuilder(
          future: Api().fetchCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final categories = snapshot.data;
              return ListView.builder(
                itemCount: categories?.length,
                physics: const PageScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(categories![index].enCategoryName),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
