import 'package:flutter/material.dart';

class AddNewSMS extends StatefulWidget {
  const AddNewSMS({Key? key}) : super(key: key);

  @override
  State<AddNewSMS> createState() => _AddNewSMS();
}

class _AddNewSMS extends State<AddNewSMS> {
  final _formKey = GlobalKey<FormState>();

  String itemName = "";
  String itemSMS = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 0, 10),
            child: Text(
              "Item Name",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextFormField(
              cursorColor: Colors.green,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) => setState(() {
                itemName = value!;
              }),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 0, 10),
            child: Text(
              "SMS",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextFormField(
              cursorColor: Colors.green,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) => setState(() {
                itemSMS = value!;
              }),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  _formKey.currentState?.save();
                  // ignore: avoid_print
                  print("$itemName $itemSMS");
                }
              },
              child: const Text(
                'SUBMIT',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
