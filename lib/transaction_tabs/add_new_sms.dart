import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String mainUrl = "http://10.0.2.2:5000/sms";

class AddNewSMS extends StatefulWidget {
  const AddNewSMS({Key? key}) : super(key: key);

  @override
  State<AddNewSMS> createState() => _AddNewSMS();
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(child: Text("Food"), value: "Food"),
    const DropdownMenuItem(child: Text("Clothing"), value: "Clothing"),
    const DropdownMenuItem(child: Text("Transport"), value: "Transport"),
    const DropdownMenuItem(child: Text("Misc"), value: "Misc"),
  ];
  return menuItems;
}

class _AddNewSMS extends State<AddNewSMS> {
  final _formKey = GlobalKey<FormState>();

  String itemName = "";
  String itemSMS = "";
  String itemCategory = "Food";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 30, 0, 10),
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
              padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
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
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 0, 10),
              child: Text(
                "Category",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
                child: DropdownButton(
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                  value: itemCategory,
                  items: dropdownItems,
                  onChanged: (String? value) {
                    // print(value);
                    setState(() {
                      itemCategory = value!;
                    });
                  },
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
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

                    var url = Uri.parse(mainUrl);
                    var response = await http.post(url, body: {
                      "username": "doodle1",
                      "actual_item": itemName,
                      "sms": itemSMS,
                      "category": itemCategory
                    });
                    // ignore: avoid_print
                    print('Response status: ${response.statusCode}');
                    // ignore: avoid_print
                    print('Response body: ${response.body}');
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
      ),
    );
  }
}
