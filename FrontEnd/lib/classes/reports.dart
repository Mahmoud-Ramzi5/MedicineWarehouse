import 'package:test1/classes/medicine.dart';

class Reports{
 final int income;
final int orderCount;
final Medicine ?mostOrderedMedicine;
final int ?mostOrederdMedicineCount;
final List<Medicine>?expiredMedicines;

  Reports(
    {
    required this.income, 
    required this.orderCount, 
    required this.mostOrderedMedicine, 
    required this.mostOrederdMedicineCount, 
    required this.expiredMedicines,
    }
    );

    Reports.fromJson(Map<String,dynamic> json)
      :income=json['income']as int,
       orderCount=json['order_count']as int,
        mostOrderedMedicine=json['most_ordered_medicine'],
         mostOrederdMedicineCount=json['most_ordered_medicine_count']as int,
        expiredMedicines = [
          for (var expiredMedicine in json['expired_medicines'])
            Medicine.fromJson(expiredMedicine as Map<String, dynamic>)
        ];
}