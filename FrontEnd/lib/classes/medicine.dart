class Medicine {
  final int id;
  final int expiryDate;
  final int quantityAvailable;
  final int price;
  final String enCommercialName;
  final String arCommercialName;
  final String enScientificName;
  final String arScientificName;
  final String enManufactureCompany;
  final String arManufactureCompany;
  final int catgoriesId;

  Medicine({
    required this.id,
    required this.expiryDate,
    required this.quantityAvailable,
    required this.price,
    required this.enCommercialName,
    required this.arCommercialName,
    required this.enScientificName,
    required this.arScientificName,
    required this.enManufactureCompany,
    required this.arManufactureCompany,
    required this.catgoriesId,
  });
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        "id": int id,
        "Expiry_date": int expiryDate,
        "Quantity_available": int quantityAvailable,
        "Price": int price,
        "En_Commercial_name": String enCommercialName,
        "Ar_Commercial_name": String arCommercialName,
        "En_Scientific_name": String enScientificName,
        "Ar_Scientific_name": String arSciesntificName,
        "En_Manufacture_company": String enManufactureCompany,
        "Ar_Manufacture_company": String arManufactureCompany,
        "Categories_id": int catgoriesId,
      } =>
        Medicine(
          id: id,
          expiryDate: expiryDate,
          quantityAvailable: quantityAvailable,
          price: price,
          enCommercialName: enCommercialName,
          arCommercialName: arCommercialName,
          enScientificName: enScientificName,
          arScientificName: arSciesntificName,
          enManufactureCompany: enManufactureCompany,
          arManufactureCompany: arManufactureCompany,
          catgoriesId: catgoriesId,
        ),
      _ => throw const FormatException('format exception'),
    };
  }
}
