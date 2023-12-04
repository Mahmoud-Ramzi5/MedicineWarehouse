class Category {
  final int id;
  final String enCategoryName;
  final String arCategoryName;

  Category({
    required this.id,
    required this.enCategoryName,
    required this.arCategoryName,
  });
  Category.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int,
        enCategoryName = json["en_category_name"] as String,
        arCategoryName = json["ar_category_name"] as String;
}
