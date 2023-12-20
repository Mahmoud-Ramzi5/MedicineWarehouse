import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/apis/phone_api.dart';
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
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GetBuilder<CartController>(
              builder: (controller) => Text(
                'Total Price:${cartController.calculateTotalPrice()}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Api().order(cartController.items).then((dynamic response) {
                  if (response.statusCode == 200) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(response.data['message']),
                          content: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          alignment: Alignment.center,
                        );
                      },
                    );
                  }
                });
                setState(() {
                  cartController.clearCart();
                });
              },
              child: const Text('Confirm Order'),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Your Order'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                cartController.clearCart();
              });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView.builder(
        physics: const PageScrollPhysics(),
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        itemCount: cartController.items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: 100,
                    decoration: const ShapeDecoration(
                        shape: ContinuousRectangleBorder(),
                        color: Colors.green),
                    child: Image.network(
                        'http://10.0.2.2:8000/storage/${cartController.items[index].medicine.imagePath}',
                        fit: BoxFit.cover)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${cartController.items[index].medicine.medicineTranslations["en"]["commercial_name"]}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'Price: ${cartController.items[index].medicine.price}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'Quantity: ${cartController.items[index].medicine.quantityAvailable}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                cartController.incrementQuantity(
                                    cartController.items[index]);
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(),
                            alignment: Alignment.center,
                            height: 30,
                            width: 30,
                            decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.green, width: 2),
                              ),
                            ),
                            child: GetBuilder<CartController>(
                              builder: (controller) => Text(
                                '${cartController.items[index].quantity}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                cartController.decrementQuantity(
                                    cartController.items[index]);
                                if (cartController.items[index].quantity == 0) {
                                  cartController.removeFromCart(
                                      cartController.items[index]);
                                }
                              });
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
              ],
            ),
          );
        },
      ),
    );
  }
}
