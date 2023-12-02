import 'package:get/get.dart';

class MedicineController extends GetxController {
  int counter = 0;
  void increment() {
    counter++;
    update(); // use update() to update counter variable on UI when increment be called
  }

  void decrement() {
    counter--;
    update();
  }
}
