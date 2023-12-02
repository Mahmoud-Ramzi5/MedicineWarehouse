import 'package:test1/classes/medicine.dart';

class Cart {
  List<Medicine> items = [];

  void addToCart(Medicine medicine) {
    items.add(medicine);
  }

  void removeFromCart(Medicine medicine) {
    items.remove(medicine);
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var medicine in items) {
      totalPrice += medicine.price;
    }
    return totalPrice;
  }
}
