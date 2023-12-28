import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/classes/medicine.dart';

class MedicineDetailsView extends StatefulWidget {
  final Medicine medicine;
  const MedicineDetailsView({super.key, required this.medicine});

  @override
  State<MedicineDetailsView> createState() => _MedicineDetailsViewState();
}

class _MedicineDetailsViewState extends State<MedicineDetailsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("33".tr)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 250,
                width: 300,
                color: Colors.green,
                child: Image.network(
                    'http://10.0.2.2:8000/storage/${widget.medicine.imagePath}',
                    fit: BoxFit.cover),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 40,
                width: 350,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  "${"34".tr}: ${widget.medicine.medicineTranslations["1".tr]["commercial_name"]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 30,
                width: 350,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  "${"35".tr}: ${widget.medicine.medicineTranslations["1".tr]["scientific_name"]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 30,
                width: 350,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  "${"36".tr}: ${widget.medicine.medicineTranslations["1".tr]["manufacture_company"]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: 350,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${"37".tr}:",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      for (var category in widget.medicine.categories)
                        Text(
                          '${category["38".tr]} ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 30,
                width: 350,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  "${"39".tr}: ${widget.medicine.quantityAvailable}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 30,
                width: 350,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  "${"40".tr}: ${widget.medicine.expiryDate}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 30,
                width: 350,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  "${"41".tr}: ${widget.medicine.price}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
