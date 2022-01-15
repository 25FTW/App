import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPage();
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Zeroth'),
  Tab(text: 'First'),
  Tab(text: 'Second'),
];

class _NotificationsPage extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("Hello");
  }
}
