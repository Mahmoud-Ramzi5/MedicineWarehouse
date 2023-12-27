import 'package:get/get.dart';

class Category {
  final int id;
  final String categoryName;
  final String enCategoryName;

  Category({
    required this.id,
    required this.categoryName,
    required this.enCategoryName,
  });
  Category.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int,
        categoryName = json["38".tr] as String,
        enCategoryName = json["en_category_name"] as String;
}
