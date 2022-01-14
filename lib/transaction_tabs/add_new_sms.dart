import 'package:flutter/material.dart';

class AddNewSMS extends StatefulWidget {
  const AddNewSMS({Key? key}) : super(key: key);

  @override
  State<AddNewSMS> createState() => _AddNewSMS();
}

class _AddNewSMS extends State<AddNewSMS> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("SMS"),
    );
  }
}
