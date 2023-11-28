class Medicine {
  final int id;
  final String expiryDate;
  final int quantityAvailable;
  final int price;
  final Map<String, dynamic> medicineTranslations;
  final Map<int, dynamic> categories;

  Medicine({
    required this.id,
    required this.expiryDate,
    required this.quantityAvailable,
    required this.price,
    required this.medicineTranslations,
    required this.categories,
  });
  Medicine.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        expiryDate = json['Expiry_date'] as String,
        quantityAvailable = json['Quantity_available'] as int,
        price = json['Price'] as int,
        medicineTranslations = {
          for (var translation in json['medicine_translations'])
            translation["lang"]: translation
        },
        categories = {
          for (var category in json['categories']) category["id"]: category
        };
}
