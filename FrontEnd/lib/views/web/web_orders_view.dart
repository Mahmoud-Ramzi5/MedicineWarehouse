import 'package:flutter/material.dart';
import 'package:test1/apis/web_api.dart';

class WebOrdersView extends StatefulWidget {
  const WebOrdersView({super.key});

  @override
  State<WebOrdersView> createState() => _WebOrdersViewState();
}

class _WebOrdersViewState extends State<WebOrdersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: WebApi().fetchweborders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final weborders = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: const PageScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Order ID: ${weborders?[index].id}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'User ID: ${weborders?[index].userId}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Status: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'PREPARING',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value: "PREPARING" ==
                                          weborders?[index].status,
                                      onChanged: (isChecked) {},
                                    ),
                                    const Text(
                                      'SENT',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value: "SENT" == weborders?[index].status,
                                      onChanged: (value) {
                                        setState(() {
                                          if (weborders?[index].status ==
                                              "PREPARING") {
                                            WebApi().orderstauts(
                                              weborders![index].id,
                                              "SENT",
                                              weborders[index].paid,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                    const Text(
                                      'RECEIVED',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value: "RECEIVED" ==
                                          weborders?[index].status,
                                      onChanged: (value) {
                                        setState(() {
                                          if (weborders?[index].status ==
                                              "SENT") {
                                            WebApi().orderstauts(
                                              weborders![index].id,
                                              "RECEIVED",
                                              weborders[index].paid,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Billing Status: ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Paid',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Checkbox(
                                      value: weborders?[index].paid,
                                      onChanged: (value) {
                                        setState(() {
                                          if (!weborders![index].paid) {
                                            WebApi().orderstauts(
                                              weborders[index].id,
                                              weborders[index].status,
                                              true,
                                            );
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      'Ordered Medicines:',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 500,
                                      child: ListView.builder(
                                        physics: const PageScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Text(
                                                '${weborders?[index].orderedMedicines[index].medicine.medicineTranslations["en"]["commercial_name"]}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  'Quantity: ${weborders?[index].orderedMedicines[index].quantity}',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  'Single unit price: ${weborders?[index].orderedMedicines[index].medicine.price}',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        itemCount: weborders?[index]
                                            .orderedMedicines
                                            .length,
                                        shrinkWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: weborders?.length,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
