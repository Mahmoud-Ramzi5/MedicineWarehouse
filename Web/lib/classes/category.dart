class Category {
  final int id;
  final String enCategoryName;

  Category({
    required this.id,
    required this.enCategoryName,
  });
  Category.fromJson(Map<String, dynamic> json)
      : id = json["id"] as int,
        enCategoryName = json["en_category_name"] as String;
}
