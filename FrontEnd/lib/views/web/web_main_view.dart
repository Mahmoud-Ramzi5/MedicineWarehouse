import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test1/apis/phone_api.dart';
import 'package:test1/apis/web_api.dart';
import 'package:test1/classes/categories.dart';
import 'package:test1/customWidgets/text_forn_widget.dart';
import 'package:numberpicker/numberpicker.dart';

class WebMainView extends StatefulWidget {
  const WebMainView({super.key});

  @override
  State<WebMainView> createState() => _WebMainViewState();
}

class _WebMainViewState extends State<WebMainView> {
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
  int quantity = 0;
  static const patternEnglish = r'^[a-zA-Z\s]+$';
  final englishRegex = RegExp(patternEnglish);
  static const patternArabic = r'^[\u0600-\u06FF\s]+$';
  final arabicRegex = RegExp(patternArabic);
  Categories dropdownValue =
      Categories(id: 0, enCategoryName: 'Option', arCategoryName: 'خيار');
  int selectedNumber = 1;

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
          maxHeight: 243,
          maxWidth: 324,
          imageQuality: 81);
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
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: _formField,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.all(18),
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
                                    padding: const EdgeInsets.all(18.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Choose Quantity',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          NumberPicker(
                            value: selectedNumber,
                            minValue: 1,
                            maxValue: 100,
                            step: 1,
                            onChanged: (value) {
                              setState(() {
                                selectedNumber = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Choose the category',
                                style: TextStyle(
                                  fontSize: 16,
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
                                    categories!.add(dropdownValue);
                                    return DropdownButtonFormField(
                                      value: dropdownValue.id,
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropdownValue =
                                              newValue as Categories;
                                        });
                                      },
                                      items:
                                          categories.map((Categories category) {
                                        return DropdownMenuItem(
                                          value: category.id,
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
                      if (_formField.currentState!.validate() == true) {
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
                          [1, 18],
                          webImage,
                          webImageName,
                        );
                      }
                    },
                    child: const Text(
                      'Add Medicine',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//