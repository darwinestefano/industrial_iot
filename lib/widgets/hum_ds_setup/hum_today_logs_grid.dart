import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:industrial_iot_app/widgets/streambuilder_all.dart';
import 'package:industrial_iot_app/widgets/streambuilder_higher.dart';

import 'package:industrial_iot_app/widgets/streambuilder_lower.dart';

import 'package:intl/intl.dart';

class HumTodayLogs extends StatefulWidget {
  @override
  _HumTodayLogsState createState() => _HumTodayLogsState();
}

class _HumTodayLogsState extends State<HumTodayLogs> {
  String valueChoose;
  String status = 'All';
  List listItem = ["All", "Lower Trashold", "Higher Trashold"];
  var limit;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.00),
          child: Text(
            'Today Logs',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300],
                width: 1,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: DropdownButton(
              value: valueChoose,
              hint: Text('All'),
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down),
              underline: SizedBox(),
              iconSize: 30,
              isExpanded: true,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              onChanged: (newValue) {
                setState(() {
                  valueChoose = newValue;
                });
              },
              items: listItem.map(
                (valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                    onTap: () {
                      if (valueItem == 'Lower Trashold') {
                        status = 'Lower Trashold';
                      } else if (valueItem == 'Higher Trashold') {
                        status = 'Higher Trashold';
                      } else {
                        status = 'All';
                      }
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ),
        _display(status),
      ],
    );
  }

  String get timeLimit {
    final DateTime now = DateTime.now();
    limit = now.subtract(const Duration(days: 1));
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedTime = formatter.format(limit);

    return formattedTime;
  }

  Widget _display(String state) {
    Query log;

    if (state == 'Lower Trashold') {
      log = FirebaseFirestore.instance
          .collection('humidity')
          .where('datestamp', isGreaterThan: timeLimit)
          .orderBy('datestamp', descending: true);
      return StreamBuilderLower(
        log,
        'humidity',
        "assets/images/humidity.png",
        '%',
      );
    } else if (state == 'Higher Trashold') {
      log = FirebaseFirestore.instance
          .collection('humidity')
          .where('datestamp', isGreaterThan: timeLimit)
          .orderBy('datestamp', descending: true);
      return StreamBuilderHigher(
        log,
        'humidity',
        "assets/images/humidity.png",
        '%',
      );
    } else {
      log = FirebaseFirestore.instance
          .collection('humidity')
          .where('datestamp', isGreaterThan: timeLimit)
          .orderBy('datestamp', descending: true);
      return StreamBuilderAll(
        log,
        'humidity',
        "assets/images/humidity.png",
        '%',
      );
    }
  }
}
