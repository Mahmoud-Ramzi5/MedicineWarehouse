import 'package:flutter/material.dart';
import 'package:warehouseweb/apis/web_api.dart';
import 'package:warehouseweb/classes/reports.dart';

class WebReportsView extends StatefulWidget {
  const WebReportsView({super.key});

  @override
  State<WebReportsView> createState() => _WebReportsViewState();
}

class _WebReportsViewState extends State<WebReportsView> {
  late DateTime firstDate = DateTime.now();
  late DateTime lastDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isFirstDate) async {
    DateTime now = DateTime.now();
    DateTime tenYearsBackward = now.subtract(const Duration(days: 365 * 10));
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFirstDate ? firstDate : lastDate,
      firstDate: tenYearsBackward,
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        if (isFirstDate) {
          firstDate = picked;
        } else {
          lastDate = picked;
        }
      });
    }
  }

  Future<Reports?> _fetchReports() async {
    // Fetch the reports data using WebApi().fetchReports
    Reports? reports = await WebApi().fetchReports(
      "${firstDate.toLocal().toString()}".split(' ')[0],
      "${lastDate.toLocal().toString()}".split(' ')[0],
    );
    return reports;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please select a Date:',
            style: TextStyle(
              color: Colors.green,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                _selectDate(context, true);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                    text: "${firstDate.toLocal()}".split(' ')[0],
                  ),
                  decoration: const InputDecoration(
                    labelText: 'First Date',
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                _selectDate(context, false);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                    text: "${lastDate.toLocal()}".split(' ')[0],
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Last Date',
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: FutureBuilder<Reports?>(
              future: _fetchReports(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While waiting for the data, show a loading indicator
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // If an error occurred while fetching the data, display an error message
                  return const Text('No data available');
                } else if (snapshot.hasData) {
                  // If data is available, display it
                  Reports? reports = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Reports:',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 500,
                          width: 500,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.green, width: 2),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Income: ${reports?.income}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Number of orders: ${reports?.orderCount}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Most ordered medicine: ${reports!.mostOrderedMedicine?.medicineTranslations["en"]["commercial_name"] ?? ''}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "It was ordered: ${reports.mostOrederdMedicineCount ?? ''}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Expired Medicines:",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Text(
                                        "${index + 1}-${reports.expiredMedicines?[index].medicineTranslations["en"]["commercial_name"] ?? ''}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                    itemCount:
                                        reports.expiredMedicines?.length ?? 0,
                                    shrinkWrap: true,
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  );
                } else {
                  // If no data is available, display a message
                  return const Text('No data available');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
