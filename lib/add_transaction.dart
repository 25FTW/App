import 'package:cashflow_management/transaction_tabs/add_new_default.dart';
import 'package:cashflow_management/transaction_tabs/add_new_image.dart';
import 'package:cashflow_management/transaction_tabs/add_new_sms.dart';
import 'package:flutter/material.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPage();
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'Zeroth'),
  Tab(text: 'First'),
  Tab(text: 'Second'),
];

class _AddTransactionPage extends State<AddTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.add_box,
                color: Colors.black,
              ),
            ),
            Tab(
                icon: Icon(
              Icons.photo_camera,
              color: Colors.black,
            )),
            Tab(
                icon: Icon(
              Icons.add_comment_rounded,
              color: Colors.black,
            )),
          ],
        ),
        body: TabBarView(
          children: [
            AddNewDefault(),
            AddNewImage(),
            AddNewSMS(),
          ],
        ),
      ),
    );
  }
}
