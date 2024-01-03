import 'package:get/get.dart';
import 'package:test1/classes/cart_item.dart';

class CartController extends GetxController {
  List<CartItem> items = [];

  void incrementQuantity(CartItem item) {
    if (item.quantity < item.medicine.quantityAvailable) {
      item.quantity++;
    }
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity > 0) {
      item.quantity--;
    }
  }

  void addToCart(CartItem item) {
    // Check if the item already exists in the cart
    bool itemExists = false;
    for (var existingItem in items) {
      if (existingItem.medicine.id == item.medicine.id) {
        // Check if adding the quantity exceeds the available quantity
        if (existingItem.quantity + item.quantity >
            item.medicine.quantityAvailable) {
          // Handle the case where the available quantity is exceeded
          // You can show an error message, display a notification, or take any other desired action
          return;
        }

        existingItem.quantity += item.quantity;
        itemExists = true;
        break;
      }
    }

    // If the item doesn't exist, add it to the cart
    if (!itemExists) {
      // Check if adding the quantity exceeds the available quantity
      if (item.quantity > item.medicine.quantityAvailable) {
        // Handle the case where the available quantity is exceeded
        // You can show an error message, display a notification, or take any other desired action
        return;
      }

      items.add(item);
    }
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

  void clearCart() {
    items.clear();
  }
}
