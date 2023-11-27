import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class WebMainView extends StatefulWidget {
  const WebMainView({super.key});

  @override
  State<WebMainView> createState() => _WebMainViewState();
}

class _WebMainViewState extends State<WebMainView> {
  Uint8List webImage = Uint8List(8);
  Future pickImage() async {
    if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = await image.readAsBytes;
        setState(() {
          webImage = selected as Uint8List;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  pickImage();
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }
}
