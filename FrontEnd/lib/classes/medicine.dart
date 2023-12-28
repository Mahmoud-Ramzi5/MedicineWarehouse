class Medicine {
  final int id;
  final String expiryDate;
  final int quantityAvailable;
  final int price;
  final Map<String, dynamic> medicineTranslations;
  final List<dynamic> categories;
  final String imagePath;
  final bool isFavorite;

  Medicine({
    required this.id,
    required this.expiryDate,
    required this.quantityAvailable,
    required this.price,
    required this.medicineTranslations,
    required this.categories,
    required this.imagePath,
    required this.isFavorite,
  });
  Medicine.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        expiryDate = json['expiry_date'] as String,
        quantityAvailable = json['quantity_available'] as int,
        price = json['price'] as int,
        medicineTranslations = {
          for (var translation in json['medicine_translations'])
            translation["lang"]: translation
        },
        categories = json['categories'],
        imagePath = json['image_path'],
        isFavorite = json['is_favorite'] as bool;
}
