import 'dart:convert';

class Categories {
  final int id;
  final String enCategoryName;
  final String arCategoryName;

  Categories({
    required this.id,
    required this.enCategoryName,
    required this.arCategoryName,
  });
  Categories.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        enCategoryName = json['en_category_name'] as String,
        arCategoryName = json['ar_Category_name'] as String;
}
