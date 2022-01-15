import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPage();
}

String mainUrl = "http://10.0.2.2:5000/getLogs";

class Data {
  Map fetchedData = {
    "data": [
      {"notification": "Joining Reward"},
    ]
  };
  late List _data;

//function to fetch the data

  Data() {
    _data = fetchedData["data"];
  }

  String getNotification(int index) {
    return _data[index]["notification"];
  }

  void addElement(String data) {
    _data.add({"notification": data});
  }

  int getLength() {
    return _data.length;
  }
}

class _NotificationsPage extends State<NotificationsPage> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var url = Uri.parse(mainUrl);
            var response = await http.post(url, body: {"username": "doodle1"});
            // ignore: avoid_print
            print('Response status: ${response.statusCode}');
            // ignore: avoid_print
            print('Response body: ${response.body}');

            List parsedBody = json.decode(response.body.toString()) as List;
            for (var key in parsedBody) {
              // print("Key, Val: $key");
              _data.addElement(key);
            }

            setState(() {});
          },
          child: const Icon(Icons.refresh_rounded),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: SizedBox(
        width: 500,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.greenAccent,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: const Icon(
                  Icons.notifications_active_rounded,
                  size: 50,
                  color: Colors.black,
                ),
                title: Text(_data.getNotification(index),
                    style: const TextStyle(color: Colors.black, fontSize: 25)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
