import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/classes/cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late CartController cartController;
  @override
  void initState() {
    cartController = Get.find<CartController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        alignment: Alignment.centerLeft,
        height: 80,
        color: Colors.green,
        child: Text(
          'Total Price:${cartController.calculateTotalPrice()}',
          style: const TextStyle(
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          '${cartController.items[index].medicine.medicineTranslations['en']['commercial_name']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          '${cartController.items[index].medicine.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
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
                        '${cartController.items[index].quantity}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: cartController.items.length,
      ),
    );
  }
}
