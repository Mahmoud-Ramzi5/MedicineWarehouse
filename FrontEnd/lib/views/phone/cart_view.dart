import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/controller/medicine_controller.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.centerLeft,
        height: 80,
        color: Colors.green,
        child: const Text(
          'Total Price:100000',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: const Text('Confirm Order'),
      ),
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      body: ListView.builder(
        physics: const PageScrollPhysics(),
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Medicine name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Price:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GetBuilder<MedicineController>(
                  builder: (controller) => Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.increment();
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        height: 30,
                        width: 30,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.green, width: 2),
                          ),
                        ),
                        child: Text(
                          '${controller.counter}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.decrement();
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
