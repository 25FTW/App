import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPage();
}

class Data {
  Map fetchedData = {
    "data": [
      {"id": 111, "name": "abc"},
      {"id": 222, "name": "pqr"},
      {"id": 333, "name": "abc"}
    ]
  };
  late List _data;

//function to fetch the data

  Data() {
    _data = fetchedData["data"];
  }

  int getId(int index) {
    return _data[index]["id"];
  }

  String getName(int index) {
    return _data[index]["name"];
  }

  int getLength() {
    return _data.length;
  }
}

class _TransactionPage extends State<TransactionPage> {
  final Data _data = Data();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.all(5.5),
          itemCount: _data.getLength(),
          itemBuilder: _itemBuilder,
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Card(
        margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        color: Colors.yellow.shade700,
        child: Center(
          child: Column(
            children: [
              Text(
                _data.getName(index),
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
              Text(
                _data.getLength().toString(),
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
