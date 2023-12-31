import 'package:flutter/material.dart';
import 'package:test1/apis/web_api.dart';

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
    DateTime tenYearsBackward = now.subtract(Duration(days: 365 * 10));

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                WebApi().fetchReports(
                    "${firstDate.toLocal().toString()}".split(' ')[0],
                    "${lastDate.toLocal().toString()}".split(' ')[0]);
              },
              child: const Text('Check Report'),
            ),
          ),
        ],
      ),
    );
  }
}
