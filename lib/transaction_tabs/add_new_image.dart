import 'package:flutter/material.dart';

class AddNewImage extends StatefulWidget {
  const AddNewImage({Key? key}) : super(key: key);

  @override
  State<AddNewImage> createState() => _AddNewImage();
}

class _AddNewImage extends State<AddNewImage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Image"),
    );
  }
}
