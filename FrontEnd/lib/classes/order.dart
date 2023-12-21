import 'package:test1/views/web/ordered_medicine.dart';

class Order {
  final int id;
  final String status;
  final bool isPaid;
  final int totalPrice;
  final List<OrderedMedicine> orderedMedicines;

  Order({
    required this.id,
    required this.status,
    required this.isPaid,
    required this.totalPrice,
    required this.orderedMedicines,
  });

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        status = json['status'] as String,
        isPaid = json['is_paid'] as bool,
        totalPrice = json['total_price'] as int,
        orderedMedicines = [
          for (var orderedMedicine in json['ordered_medicines'])
            OrderedMedicine.fromJson(orderedMedicine as Map<String, dynamic>)
        ];
}
