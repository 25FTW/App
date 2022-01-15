import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'notifications.dart';
import 'dart:convert';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPage();
}

String mainUrl = "http://10.0.2.2:5000/getAllAnalysis";

class Data {
  Map fetchedData = {
    "data": [
      {"name": "Joining Reward", "value": "100"},
    ]
  };
  late List _data;

//function to fetch the data

  Data() {
    _data = fetchedData["data"];
  }

  String getName(int index) {
    return _data[index]["name"];
  }

  String getValue(int index) {
    return _data[index]["value"];
  }

  void addElement(String data, String value) {
    _data.add({"name": data, "value": value});
  }

  int getLength() {
    return _data.length;
  }
}

class _TransactionPage extends State<TransactionPage> {
  final Data _data = Data();
  num _funds = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.all(5.5),
          itemCount: _data.getLength(),
          itemBuilder: _itemBuilder,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var url = Uri.parse(mainUrl);
            var response = await http.post(url, body: {"username": "doodle1"});
            // ignore: avoid_print
            print('Response status: ${response.statusCode}');
            // ignore: avoid_print
            print('Response body: ${response.body}');

            Map<String, dynamic> parsedBody = json.decode(response.body);
            num _totalFunds = 0;

            parsedBody.forEach((key, value) {
              // print("Key, Val: $key $value");
              _totalFunds += value;
              _data.addElement(key, value.toString());
            });
            _funds = _totalFunds;

            setState(() {});

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsPage()));
          },
          child: const Icon(Icons.add_alert_rounded),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: SizedBox(
        width: 500,
        child: Column(
          children: [
            (index == 0)
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
                    child: Text(
                      "Total Spent: $_funds \nTotal Funds: 1000.0",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  )
                : const Text(""),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.pink,
              elevation: 10,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet_rounded,
                        size: 50),
                    title: Text("Name: ${_data.getName(index)}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25)),
                    subtitle: Text("Value: ${_data.getValue(index)}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
