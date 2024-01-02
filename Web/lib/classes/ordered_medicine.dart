import 'package:warehouseweb/classes/medicine.dart';

class OrderedMedicine {
  final int id;
  final int quantity;
  final Medicine medicine;

  OrderedMedicine({
    required this.id,
    required this.quantity,
    required this.medicine,
  });
  OrderedMedicine.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        quantity = json['quantity'] as int,
        medicine = Medicine.fromJson(json['medicine'] as Map<String, dynamic>);
}
