class Order {
  final int id;
  final String status;
  final bool isPaid;

  Order({required this.id, required this.status, required this.isPaid});

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        status = json['status'] as String,
        isPaid = json['is_paid'] as bool;
}
