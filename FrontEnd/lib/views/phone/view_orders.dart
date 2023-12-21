import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/constants/routes.dart';

class ViewOrders extends StatefulWidget {
  const ViewOrders({super.key});

  @override
  State<ViewOrders> createState() => _ViewOrdersState();
}

class _ViewOrdersState extends State<ViewOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
        ),
      ),
      body: FutureBuilder(
        future: Api().fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final orders = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Order number: ${orders?[index].id}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Total Price: ${orders?[index].totalPrice}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'Medicines Quantity: ${orders?[index].orderedMedicines.length}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                    orderDetailsRoute,
                                    arguments: orders?[index],
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  physics: const PageScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orders?.length,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
