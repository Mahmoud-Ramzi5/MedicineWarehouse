import 'package:flutter/material.dart';

class SelectCategoriesView extends StatefulWidget {
  const SelectCategoriesView({super.key});

  @override
  State<SelectCategoriesView> createState() => _SelectCategoriesViewState();
}

class _SelectCategoriesViewState extends State<SelectCategoriesView> {
  final List<String> buttonLabels = [
    'Button 1',
    'Button 2',
    'Button 3',
    'Button 4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Category')),
      body: ListView.builder(
        physics: const PageScrollPhysics(),
        shrinkWrap: true,
        itemCount: buttonLabels.length,
        itemBuilder: (context, index) {
          final label = buttonLabels[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(label),
            ),
          );
        },
      ),
    );
  }
}
