import 'package:flutter/material.dart';
import 'package:test1/classes/medicine.dart';

class MedicineDetailsView extends StatefulWidget {
  final Medicine medicine;
  const MedicineDetailsView({super.key, required this.medicine});

  @override
  State<MedicineDetailsView> createState() => _MedicineDetailsViewState();
}

class _MedicineDetailsViewState extends State<MedicineDetailsView> {
  // late CartController cartController;
  // late CartItem cartItem;

  @override
  void initState() {
    // cartController = Get.find<CartController>();
    // cartItem = CartItem(medicine: widget.medicine, quantity: 0);
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
                  height: 243,
                  width: 324,
                  color: Colors.green,
                  child: Image.network(
                      'http://10.0.2.2:8000/storage/${widget.medicine.imagePath}',
                      fit: BoxFit.cover)),
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
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: 300,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Categories: ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      for (var category in widget.medicine.categories)
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
              // Container(
              //   margin: const EdgeInsets.all(10),
              //   alignment: Alignment.center,
              //   height: 45,
              //   width: 300,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       IconButton(
              //         onPressed: () {
              //           setState(() {
              //             cartItem.decrementQuantity();
              //           });
              //         },
              //         icon: const Icon(
              //           Icons.remove,
              //           color: Colors.red,
              //           size: 25,
              //         ),
              //       ),
              //       Container(
              //         margin: const EdgeInsets.all(10),
              //         alignment: Alignment.center,
              //         height: 50,
              //         width: 50,
              //         decoration: const ShapeDecoration(
              //           shape: RoundedRectangleBorder(
              //             side: BorderSide(color: Colors.green, width: 2),
              //           ),
              //         ),
              //         child: Text(
              //           '${cartItem.quantity}',
              //           style: const TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       IconButton(
              //         onPressed: () {
              //           setState(() {
              //             cartItem.incrementQuantity();
              //           });
              //         },
              //         icon: const Icon(
              //           Icons.add,
              //           color: Colors.green,
              //           size: 25,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     cartController.addToCart(cartItem);
              //   },
              //   child: const Icon(
              //     Icons.add_shopping_cart_outlined,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
