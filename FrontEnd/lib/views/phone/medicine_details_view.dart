import 'package:flutter/material.dart';
import 'package:test1/classes/medicine.dart';

class MedicineDetailsView extends StatefulWidget {
  final Medicine medicine;
  const MedicineDetailsView({super.key, required this.medicine});

  @override
  State<MedicineDetailsView> createState() => _MedicineDetailsViewState();
}

class _MedicineDetailsViewState extends State<MedicineDetailsView> {
  late int medicineQuantity;
  @override
  void initState() {
    medicineQuantity = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Full Details')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 300,
                color: Colors.green,
                child: const Icon(
                  Icons.medication,
                  color: Colors.white,
                  size: 150,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 30,
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Commercial Name: ${widget.medicine.medicineTranslations["en"]["commercial_name"]}',
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
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Scientific Name: ${widget.medicine.medicineTranslations["en"]["scientific_name"]}',
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
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Manufacture: ${widget.medicine.medicineTranslations["en"]["manufacture_company"]}',
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
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Categories: ${widget.medicine.categories["en_Category_name"]}',
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
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Description: ${widget.medicine.categories["en_Description"]}',
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
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Quantity: ${widget.medicine.quantityAvailable}',
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
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Expiry Date: ${widget.medicine.expiryDate}',
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
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Price: ${widget.medicine.price}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.center,
                height: 45,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (medicineQuantity > 0) {
                            medicineQuantity--;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      height: 150,
                      width: 100,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      child: Text(
                        '$medicineQuantity',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (medicineQuantity <
                              widget.medicine.quantityAvailable) {
                            medicineQuantity++;
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
