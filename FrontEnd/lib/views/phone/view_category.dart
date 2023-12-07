import 'package:flutter/material.dart';
import 'package:test1/apis/phone_api.dart';

class ViewCategoty extends StatefulWidget {
  final int id;
  const ViewCategoty({super.key, required this.id});

  @override
  State<ViewCategoty> createState() => _ViewCategotyState();
}

class _ViewCategotyState extends State<ViewCategoty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: Api().fetchMedicineByCategory(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final medicines = snapshot.data;
            return ListView.builder(
              itemCount: medicines?.length,
              physics: const PageScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      height: 30,
                      decoration: const ShapeDecoration(
                          shape: StadiumBorder(), color: Colors.green),
                      alignment: Alignment.center,
                      child: Text(
                          '${medicines?[index].medicineTranslations['en']['commercial_name']}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
