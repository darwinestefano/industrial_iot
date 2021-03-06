import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:industrial_iot_app/widgets/alert_dialog.dart';
import 'package:industrial_iot_app/widgets/streambuilder_all.dart';
import 'package:industrial_iot_app/widgets/streambuilder_higher.dart';
import 'package:industrial_iot_app/widgets/streambuilder_lower.dart';
import 'package:industrial_iot_app/widgets/temp_rt_setup/temperature.dart';

import 'package:intl/intl.dart';

class TempWeekGridLogs extends StatefulWidget {
  @override
  _TempWeekGridLogsState createState() => _TempWeekGridLogsState();
}

class _TempWeekGridLogsState extends State<TempWeekGridLogs> {
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
            'Past 7 days Records',
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
                        //print("Status on lower: " + status);
                      } else if (valueItem == 'Higher Trashold') {
                        status = 'Higher Trashold';

                        //print("Status on higher: " + status);
                      } else {
                        status = 'All';

                        //print("Status on all: " + status);
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
    limit = now.subtract(const Duration(days: 7));
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    String formattedTime = formatter.format(limit);
    print(formattedTime);
    return formattedTime;
  }

  Widget _display(String state) {
    Query log;

    if (state == 'Lower Trashold') {
      log = FirebaseFirestore.instance
          .collection('temperature')
          .where('datestamp', isGreaterThanOrEqualTo: timeLimit)
          .orderBy('datestamp', descending: true);
      return StreamBuilederLower(log);
    } else if (state == 'Higher Trashold') {
      log = FirebaseFirestore.instance
          .collection('temperature')
          .where('datestamp', isGreaterThanOrEqualTo: timeLimit)
          .orderBy('datestamp', descending: true);
      return StreamBuilederHigher(log);
    } else {
      log = FirebaseFirestore.instance
          .collection('temperature')
          .where('datestamp', isGreaterThanOrEqualTo: timeLimit)
          .orderBy('datestamp', descending: true);
      return StreamBuilederAll(log);
    }
  }
}
