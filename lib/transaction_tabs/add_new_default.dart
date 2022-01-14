import 'package:flutter/material.dart';

class AddNewDefault extends StatefulWidget {
  const AddNewDefault({Key? key}) : super(key: key);

  @override
  State<AddNewDefault> createState() => _AddNewDefault();
}

class _AddNewDefault extends State<AddNewDefault> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Default"),
    );
  }
}
