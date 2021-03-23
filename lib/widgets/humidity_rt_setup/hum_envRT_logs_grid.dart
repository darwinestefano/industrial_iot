import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:industrial_iot_app/widgets/alert_dialog.dart';

class HumEnvRTLogsGrid extends StatefulWidget {
  @override
  _HumEnvRTLogsGridState createState() => _HumEnvRTLogsGridState();
}

class _HumEnvRTLogsGridState extends State<HumEnvRTLogsGrid> {
  @override
  Widget build(BuildContext context) {
    Query tempLogs = FirebaseFirestore.instance
        .collection('humidity')
        .orderBy('datestamp', descending: true)
        .orderBy('timestamp', descending: true)
        .limit(5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.00),
          child: Text(
            'Latest Logs',
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
        Container(
          margin: const EdgeInsets.all(8.0),
          height: 380,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 6,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: tempLogs.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'Something went wrong',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  "Please wait unitl the data has been processed...",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400],
                  ),
                );
              }
              return new ListView(
                children: snapshot.data.docs.map(
                  (DocumentSnapshot document) {
                    if (document.data()['humidity'] <= 20) {
                      return _listData(document, Colors.blue);
                    } else if (document.data()['humidity'] >= 35) {
                      return _listData(document, Colors.red);
                    } else {
                      return _listData(document, Colors.grey);
                    }
                  },
                ).toList(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _listData(
    DocumentSnapshot document,
    MaterialColor colorText,
  ) {
    return document.data()['humidity'] <= 20 ||
            document.data()['humidity'] >= 35
        ? new ListTile(
            leading: Image.asset(
              "assets/images/humidity.png",
              color: colorText,
              height: 37,
            ),
            title: new Text(
              '${document.data()['datestamp']} ${document.data()['timestamp']}',
              style: TextStyle(
                color: colorText,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: new Text(
              '${document.data()['humidity']} °C',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: IconButton(
              icon: Image.asset(
                "assets/images/alert.png",
                color: colorText,
                height: 30,
              ),
              color: colorText,
              onPressed: () {
                if (document.data()['humidity'] <= 20) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                            'The Humidity is below the minimum threshold possible. \n Immediate Action Needed!',
                            Colors.blueAccent);
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomAlertDialog(
                            'The Humidity is above the maximum threshold possible. \n Immediate Action Needed!',
                            Colors.redAccent);
                      });
                }
              },
            ),
          )
        : new ListTile(
            leading: Image.asset(
              "assets/images/humidity.png",
              color: colorText,
              height: 37,
            ),
            title: new Text(
              '${document.data()['datestamp']} ${document.data()['timestamp']}',
              style: TextStyle(
                color: colorText,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: new Text(
              '${document.data()['humidity']} °C',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
  }
}
