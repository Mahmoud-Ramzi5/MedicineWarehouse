import 'package:flutter/material.dart';
import 'package:test1/classes/medicine.dart';

class MedicineDetailsView extends StatefulWidget {
  final Medicine medicine;
  const MedicineDetailsView({super.key, required this.medicine});

  @override
  State<MedicineDetailsView> createState() => _MedicineDetailsViewState();
}

class _MedicineDetailsViewState extends State<MedicineDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator()),
          Text(widget.medicine.medicineTranslations["ar"]["commercial_name"]),
        ],
      ),
    );
  }
}
