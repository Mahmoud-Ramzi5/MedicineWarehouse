import 'package:test1/views/web/ordered_medicine.dart';

class WebOrder {
  final int id;
  final bool paid;
  final String status;
  final double totalPrice;
  final int userId;
  final List<OrderedMedicine> orderedMedicines;

//late final String username;

  WebOrder({
    required this.id,
    required this.paid,
    required this.status,
    required this.totalPrice,
    required this.userId,
    required this.orderedMedicines,
    //required this.username,
  });
  WebOrder.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        paid = json['is_paid'] as bool,
        status = json['status'] as String,
        userId = json['user_id'] as int,
        totalPrice = json['total_price'] as double,
        orderedMedicines = [
          for (var orderedMedicine in json['ordered_medicines'])
            OrderedMedicine.fromJson(orderedMedicine as Map<String, dynamic>)
        ];
}
