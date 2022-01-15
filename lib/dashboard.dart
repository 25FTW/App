import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'notifications.dart';
import 'dart:convert';
import 'dart:math' as math;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPage();
}

String budgetURL = "http://10.0.2.2:5000/setBudget";
String visualizationURL = "http://10.0.2.2:5000/analysis_monthly";

class Data {
  Map fetchedData = {
    "data": [
      {"value": 10, "title": "Reward"},
    ]
  };
  late List _data;

//function to fetch the data

  Data() {
    _data = fetchedData["data"];
  }

  String getTitle(int index) {
    return _data[index]["title"];
  }

  num getValue(int index) {
    return _data[index]["value"];
  }

  void addElement(String data, String value) {
    _data.add({"name": data, "value": value});
  }

  int getLength() {
    return _data.length;
  }
}

class _DashboardPage extends State<DashboardPage> {
  final Data _data = Data();
  final _formKey = GlobalKey<FormState>();
  num _newFunds = 1000;
  final List<PieChartSectionData> _visualizationData = [];
  bool _initialCycle = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 600,
        child: SingleChildScrollView(
          child: SizedBox(
            height: 600,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 14, 0, 10),
                          child: Text(
                            "User: doodle1",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                          child: Text(
                            "New Budget",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: TextFormField(
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            cursorColor: Colors.green,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onSaved: (value) => setState(() {
                              _newFunds = value! as num;
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                _formKey.currentState?.save();
                                // ignore: avoid_print
                                print(_newFunds);

                                var url = Uri.parse(budgetURL);
                                var response = await http.post(url, body: {
                                  "username": "doodle1",
                                  "actual_item": _newFunds,
                                });
                                // ignore: avoid_print
                                print(
                                    'Response status: ${response.statusCode}');
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 45, 0, 25),
                    child: Text(
                      "Breakdown of your expenditure",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  _initialCycle
                      ? const Text("Loading")
                      : SizedBox(
                          height: 200,
                          child: PieChart(
                              PieChartData(sections: _visualizationData))),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationsPage()));

                  var url = Uri.parse(visualizationURL);
                  var response = await http.post(url, body: {
                    "username": "doodle1",
                    "month": "01",
                    "year": "2022"
                  });
                  // ignore: avoid_print
                  print('Response status: ${response.statusCode}');
                  // ignore: avoid_print
                  print('Response body: ${response.body}');

                  Map<String, dynamic> parsedBody = json.decode(response.body);
                  num _totalFunds = 0;

                  parsedBody.forEach((key, value) {
                    print("Key, Val: $key $value");
                    _totalFunds += value;
                    _data.addElement(value.toString(), key);
                    _visualizationData.add(
                      PieChartSectionData(
                          title: key,
                          value: value,
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(1.0),
                          radius: MediaQuery.of(context).size.width / 4.44),
                    );
                  });

                  setState(() {
                    _initialCycle = false;
                  });
                },
                child: const Icon(Icons.add_alert_rounded),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
//   Widget _itemBuilder(BuildContext context, int index) {
//     return InkWell(
//       child: SizedBox(
//         width: 500,
//         child: Column(
//           children: [
//             (index == 0)
//                 ? Column(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.fromLTRB(15, 30, 0, 10),
//                         child: Text(
//                           "User: doodle1",
//                           style: TextStyle(
//                               fontSize: 30, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                         child: TextFormField(
//                           cursorColor: Colors.green,
//                           // The validator receives the text that the user has entered.
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                           onSaved: (value) => setState(() {
//                             _newFunds = value! as num;
//                           }),
//                         ),
//                       ),
//                     ],
//                   )
//                 : const Text(""),
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0),
//               ),
//               color: Colors.pink,
//               elevation: 10,
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   ListTile(
//                     leading: const Icon(Icons.account_balance_wallet_rounded,
//                         size: 50),
//                     title: Text("Name: ${_data.getName(index)}",
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 25)),
//                     subtitle: Text("Value: ${_data.getValue(index)}",
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 18)),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
