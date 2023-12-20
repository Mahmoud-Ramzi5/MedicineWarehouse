import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:test1/apis/web_api.dart';
import 'package:test1/classes/category.dart' as CC;
import 'package:test1/customWidgets/text_forn_widget.dart';
import 'package:test1/views/web/web_main.dart';

class Add_Medicine extends StatefulWidget {
  const Add_Medicine({super.key});

  @override
  State<Add_Medicine> createState() => _Add_MedicineState();
}

class _Add_MedicineState extends State<Add_Medicine> {
  late final _formField = GlobalKey<FormState>();
  Uint8List webImage = Uint8List(8);
  String webImageName = "default.png";
  File? pickedImage;
  late final TextEditingController _enCommercialName;
  late final TextEditingController _arCommercialName;
  late final TextEditingController _enScientificName;
  late final TextEditingController _arScientificName;
  late final TextEditingController _enManufactureCompany;
  late final TextEditingController _arManufactureCompany;
  late final TextEditingController _priceController;
  late DateTime selectedDate = DateTime(2023, 11, 1);
  static const patternEnglish = r'^[a-zA-Z\s]+$';
  final englishRegex = RegExp(patternEnglish);
  static const patternArabic = r'^[\u0600-\u06FF\s]+$';
  final arabicRegex = RegExp(patternArabic);
  int quantity = 1;
  int categoryId = 1;

  @override
  void initState() {
    super.initState();
    _enCommercialName = TextEditingController();
    _arCommercialName = TextEditingController();
    _enScientificName = TextEditingController();
    _arScientificName = TextEditingController();
    _enManufactureCompany = TextEditingController();
    _arManufactureCompany = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _enCommercialName.dispose();
    _arCommercialName.dispose();
    _enScientificName.dispose();
    _arScientificName.dispose();
    _enManufactureCompany.dispose();
    _arManufactureCompany.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 250,
          maxWidth: 300,
          imageQuality: 80);
      if (image != null) {
        webImageName = image.name;
        Uint8List imageBytes = await image.readAsBytes();
        setState(() {
          webImage = imageBytes;
          pickedImage = File(image.path);
        });
      }
    } else {
      return;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2027),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Medicine'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formField,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.all(20),
                      child: pickedImage == null
                          ? DottedBorder(
                              stackFit: StackFit.expand,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: TextButton(
                                      onPressed: () {
                                        pickImage();
                                      },
                                      child: const Text(
                                        'Choose an image',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : kIsWeb
                              ? Image.memory(
                                  webImage,
                                  fit: BoxFit.fill,
                                )
                              : Image.file(
                                  pickedImage!,
                                ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextWidget(
                      controller: _enCommercialName,
                      labelText: 'English Commercial Name',
                      icon: const Icon(Icons.text_fields),
                      obsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required field";
                        }

                        if (!englishRegex.hasMatch(value)) {
                          return 'English text only';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextWidget(
                      controller: _arCommercialName,
                      labelText: 'Arabic Commercial Name',
                      icon: const Icon(Icons.text_fields),
                      obsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required field";
                        }
                        if (!arabicRegex.hasMatch(value)) {
                          return 'Arabic text only';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextWidget(
                      controller: _enScientificName,
                      labelText: 'English Scientific Name',
                      icon: const Icon(Icons.text_fields),
                      obsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required field";
                        }
                        if (!englishRegex.hasMatch(value)) {
                          return 'English text only';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextWidget(
                      controller: _arScientificName,
                      labelText: 'Arabic Scientific Name',
                      icon: const Icon(Icons.text_fields),
                      obsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required field";
                        }
                        if (!arabicRegex.hasMatch(value)) {
                          return 'Arabic text only';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextWidget(
                      controller: _enManufactureCompany,
                      labelText: 'English Manufacture Company',
                      icon: const Icon(Icons.business),
                      obsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required field";
                        }
                        if (!englishRegex.hasMatch(value)) {
                          return 'English text only';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextWidget(
                      controller: _arManufactureCompany,
                      labelText: 'Arabic Manufacture Company',
                      icon: const Icon(Icons.business),
                      obsecureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required field";
                        }
                        if (!arabicRegex.hasMatch(value)) {
                          return 'Arabic text only';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: 50,
                      child: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: TextEditingController(
                                text:
                                    "${selectedDate.toLocal()}".split(' ')[0]),
                            decoration: const InputDecoration(
                              labelText: 'Expiry Date',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomTextWidget(
                      controller: _priceController,
                      labelText: 'Price',
                      icon: const Icon(Icons.attach_money),
                      obsecureText: false,
                      inputType: TextInputType.number,
                      validator: (value) {
                        // Custom validation to allow only non-negative integers
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid number';
                        }
                        try {
                          int price = int.parse(value);
                          if (price < 0) {
                            return 'Please enter a non-negative number';
                          }
                        } catch (e) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Choose Quantity',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          NumberPicker(
                            value: quantity,
                            minValue: 1,
                            maxValue: 100,
                            step: 1,
                            onChanged: (value) {
                              setState(() {
                                quantity = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Choose the category',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FutureBuilder(
                                future: WebApi().fetchCategories(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else {
                                    final categories = snapshot.data;
                                    return DropdownButtonFormField(
                                      value: categoryId,
                                      onChanged: (newValue) {
                                        setState(() {
                                          categoryId = (newValue as int) + 1;
                                        });
                                      },
                                      items: categories!
                                          .map((CC.Category category) {
                                        return DropdownMenuItem(
                                          value: category.id - 1,
                                          child: Text(category.enCategoryName),
                                        );
                                      }).toList(),
                                      hint: const Text('Select an option'),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formField.currentState!.validate()) {
                        WebApi().addMedicine(
                          _enCommercialName.text,
                          _arCommercialName.text,
                          _enScientificName.text,
                          _arScientificName.text,
                          _enManufactureCompany.text,
                          _arManufactureCompany.text,
                          "${selectedDate.toLocal().toString()}".split(' ')[0],
                          double.parse(_priceController.text),
                          quantity,
                          [categoryId],
                          webImage,
                          webImageName,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Medicine Added Successfully'),
                          ),
                        );

                        // Navigate back to home
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Web_Main(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No Medicine Was Added'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Add Medicine',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
