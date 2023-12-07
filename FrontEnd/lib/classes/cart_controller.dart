import 'package:get/get.dart';
import 'package:test1/classes/cart_item.dart';

class CartController extends GetxController {
  List<CartItem> items = [];

  void addToCart(CartItem item) {
    items.add(item);
  }

  void removeFromCart(CartItem item) {
    items.remove(item);
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    for (var item in items) {
      totalPrice += item.medicine.price * item.quantity;
    }
    return totalPrice;
  }
}
