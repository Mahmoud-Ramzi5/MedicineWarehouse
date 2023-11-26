class Medicine {
  final int id;
  final String expiryDate;
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
  Medicine.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        expiryDate = json['Expiry_date'] as String,
        quantityAvailable = json['Quantity_available'] as int,
        price = json['Price'] as int,
        enCommercialName = json['En_Commercial_name'] as String,
        arCommercialName = json['Ar_Commercial_name'] as String,
        enScientificName = json['En_Scientific_name'] as String,
        arScientificName = json['Ar_Scientific_name'] as String,
        enManufactureCompany = json['En_Manfacture_company'] as String,
        arManufactureCompany = json['Ar_Manfacture_company'] as String,
        catgoriesId = json['Categories_id'] as int;
}
