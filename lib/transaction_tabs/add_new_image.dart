import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';

const mainURL = "http://10.0.2.2:5000/image";

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
                    height: 200,
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
              onPressed: () async {
                var formData = FormData();
                var dio = Dio();
                formData.files.add(MapEntry(
                  "imagefile",
                  await MultipartFile.fromFile(_image!.path,
                      filename: "pic-name.png"),
                ));
                formData.fields.add(const MapEntry("username", "doodle"));
                var response = await dio.post(mainURL, data: formData);
              },
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
