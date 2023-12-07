import 'package:test1/classes/medicine.dart';

class CartItem {
  final Medicine medicine;
  int quantity;

  CartItem({required this.medicine, required this.quantity});

  void incrementQuantity() {
    if (quantity < medicine.quantityAvailable) {
      quantity++;
    }
  }

  void decrementQuantity() {
    if (quantity > 0) {
      quantity--;
    }
  }
}
