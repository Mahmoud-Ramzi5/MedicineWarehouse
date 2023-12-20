import 'package:test1/classes/medicine.dart';

class web_Orders{
 final int ?id;
 final int ?quantityAvailable;
 final int ?price;
 final Map<String, dynamic> medicineTranslations;
//final int totalprice;
//late final String username;
 final bool paid;
 final String status;
 final int ?user_id;
web_Orders({
    required this.id,
    required this.quantityAvailable,
    required this.price,
    required this.medicineTranslations,
  //required this.username,
   required this.paid,
   required this.status,
   required this.user_id,


  });
  web_Orders.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
      user_id=json['user_id']as int,
          quantityAvailable = json['quantity_allocated'] as int,
        price = json['price'] as int,
        medicineTranslations = {
          for (var translation in json['medicine_translations'])
            translation["lang"]: translation
        },
        paid=json['is_paid']as bool,
        status=json['status']as String;
}

