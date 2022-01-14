import 'package:cashflow_management/transactions.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'add_transaction.dart';
import 'dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CashFlow Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) =>
            const MyHomePage(title: '25FTW - Cashflow Management'),
        '/transaction': (context) => const TransactionPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int index_ = 1;

  // final navigationKey = GlobalKey<CurvedNavigationBar>;

  final screens = [
    const TransactionPage(),
    const AddTransactionPage(),
    const DashboardPage()
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: screens[index_],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.green.shade100,
        index: index_,
        animationDuration: const Duration(milliseconds: 300),
        items: const <Widget>[
          Icon(Icons.compare_arrows, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.add_chart, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            index_ = index;
          });
          // if (index == 0) {
          //   Navigator.pushNamed(context, '/transaction');
          // }
        },
        height: 60,
        buttonBackgroundColor: Colors.greenAccent,
      ),
    );
  }
}
