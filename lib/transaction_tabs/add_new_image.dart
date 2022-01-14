import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNewImage extends StatefulWidget {
  const AddNewImage({Key? key}) : super(key: key);

  @override
  State<AddNewImage> createState() => _AddNewImage();
}

class _AddNewImage extends State<AddNewImage> {
  File? _image;

  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      _image = imageTemporary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            _image != null
                ? Image.file(
                    _image!,
                    height: 450,
                  )
                : const FlutterLogo(
                    size: 100,
                  ),
            ElevatedButton.icon(
              onPressed: getImageFromGallery,
              icon: const Icon(
                Icons.image,
                size: 30,
              ),
              label: const Text("Upload Image from Gallery"),
            ),
            ElevatedButton.icon(
              onPressed: getImageFromCamera,
              icon: const Icon(
                Icons.camera_alt_rounded,
                size: 30,
              ),
              label: const Text("Take Image From Camera"),
            ),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.upload_rounded,
                size: 30,
              ),
              label: const Text("Upload"),
              onPressed: () {},
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getImage,
      // ),
    );
  }
}
