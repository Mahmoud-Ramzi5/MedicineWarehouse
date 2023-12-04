import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:test1/classes/medicine.dart';
import 'package:test1/controller/medicine_controller.dart';

class MedicineDetailsView extends StatelessWidget {
  final Medicine medicine;
  final MedicineController medicineController = Get.put(
    MedicineController(),
    permanent: true,
  );

  MedicineDetailsView({super.key, required this.medicine});

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
                height: 243,
                width: 324,
                color: Colors.green,
                child: medicine.image,
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
                  'Commercial Name: ${medicine.medicineTranslations["en"]["commercial_name"]}',
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
                  'Scientific Name: ${medicine.medicineTranslations["en"]["scientific_name"]}',
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
                  'Manufacture: ${medicine.medicineTranslations["en"]["manufacture_company"]}',
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
                  height: 30,
                  width: 300,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Categories: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      for (var category in medicine.categories)
                        Text(
                          '${category["en_category_name"]} ',
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
                width: 300,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                child: Text(
                  'Quantity: ${medicine.quantityAvailable}',
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
                  'Expiry Date: ${medicine.expiryDate}',
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
                  'Price: ${medicine.price}',
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
                        if (medicineController.counter > 0) {
                          medicineController.decrement();
                        }
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
                      height: 50,
                      width: 50,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green, width: 2),
                        ),
                      ),
                      child: GetBuilder<MedicineController>(
                        builder: (controller) => Text(
                          '${medicineController.counter}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (medicineController.counter <
                            medicine.quantityAvailable) {
                          medicineController.increment();
                        }
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
                  Icons.add_shopping_cart_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
