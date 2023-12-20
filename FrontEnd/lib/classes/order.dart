class Order {
  final int id;
  final String status;
  final bool isPaid;
  final double totalPrice;

  Order({
    required this.id,
    required this.status,
    required this.isPaid,
    required this.totalPrice,
  });

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        status = json['status'] as String,
        isPaid = json['is_paid'] as bool,
        totalPrice = json['total_price'] as double;
}
