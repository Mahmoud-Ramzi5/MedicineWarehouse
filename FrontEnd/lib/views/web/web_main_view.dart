import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test1/apis/web_api.dart';

class WebMainView extends StatefulWidget {
  const WebMainView({super.key});

  @override
  State<WebMainView> createState() => _WebMainViewState();
}

class _WebMainViewState extends State<WebMainView> {
  Uint8List webImage = Uint8List(8);
  File? pickedImage;

  Future<void> pickImage() async {
    if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        Uint8List imageBytes = await image.readAsBytes();
        setState(() {
          webImage = imageBytes;
          pickedImage = File('a');
        });
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                  height: 200,
                  width: 200,
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
                              fit: BoxFit.fill,
                            )),
              ElevatedButton(
                onPressed: () {
                  WebApi().addMedicine(
                      "5/9/2027",
                      1,
                      1,
                      "enCommercialName",
                      "arCommercialName",
                      "enScientificName",
                      "arScientificName",
                      "enManufactureCompany",
                      "arManufactureCompany",
                      [1, 18],
                      webImage);
                },
                child: const Text(
                  'Upload',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
