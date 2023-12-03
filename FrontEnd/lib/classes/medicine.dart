import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Medicine {
  final int id;
  final String expiryDate;
  final int quantityAvailable;
  final int price;
  final Map<String, dynamic> medicineTranslations;
  final List<dynamic> categories;
  final Image image;

  Medicine({
    required this.id,
    required this.expiryDate,
    required this.quantityAvailable,
    required this.price,
    required this.medicineTranslations,
    required this.categories,
    required this.image,
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
        image = Image.memory(
            base64Decode(
                json['image_path'].replaceAll('\n', '') /*.split('\n).join*/),
            fit: BoxFit.cover);
}
