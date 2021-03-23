import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:industrial_iot_app/widgets/alert_dialog.dart';

class StreamBuilderHigher extends StatelessWidget {
  final Query log;
  final String device;
  final String path;
  final String symbol;
  const StreamBuilderHigher(this.log, this.device, this.path, this.symbol);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.40,
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
        stream: log.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              "Please wait until data is processed...",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey[400],
              ),
            );
          }

          return new ListView(
            children: snapshot.data.docs
                .where((DocumentSnapshot document) =>
                    document.data()[device] >= 35)
                .map(
              (DocumentSnapshot document) {
                return _listData(document, Colors.red, context);
              },
            ).toList(),
          );
        },
      ),
    );
  }

  Widget _listData(
    DocumentSnapshot document,
    MaterialColor colorText,
    BuildContext context,
  ) {
    return new ListTile(
      leading: Image.asset(
        path,
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
        '${document.data()[device]} ' + symbol,
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
          if (document.data()[device] <= 20) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomAlertDialog(
                      'The ' +
                          device +
                          ' is below the minimum threshold possible. \n Immediate Action Needed!',
                      Colors.blueAccent);
                });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomAlertDialog(
                    'The ' +
                        device +
                        ' is above the maximum threshold possible. \n Immediate Action Needed!',
                    Colors.redAccent);
              },
            );
          }
        },
      ),
    );
  }
}
