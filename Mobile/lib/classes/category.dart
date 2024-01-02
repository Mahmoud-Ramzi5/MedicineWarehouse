import 'package:get/get.dart';

class Category {
  final int id;
  final String categoryName;

  Category({
    required this.id,
    required this.categoryName,
  });
  Category.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int,
        categoryName = json["38".tr] as String;
}
