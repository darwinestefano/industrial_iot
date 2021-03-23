import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:industrial_iot_app/widgets/temp_rt_setup/temperature.dart';

class DustEnvRTStatsGrid extends StatefulWidget {
  @override
  _DustEnvRTStatsGridState createState() => _DustEnvRTStatsGridState();
}

class _DustEnvRTStatsGridState extends State<DustEnvRTStatsGrid> {
  //List<Temperature> _se riesData;
  List<Temperature> mydata;
  var minTemp, maxTemp;
  // _generateData(mydata) {
  //   // ignore: deprecated_member_use
  //   //_seriesData = List<Temperature>();
  //   //_seriesData.add(mydata);
  //   oldestUser = mydata.reduce((currentUser, nextUser) =>
  //       currentUser['temperature'] > nextUser['temperature']
  //           ? currentUser
  //           : nextUser);
  // }

  @override
  Widget build(BuildContext context) {
    return _buildStatGrid(context);
  }

  // Widget _buildBody(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance.collection('temperature').snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return LinearProgressIndicator();
  //       } else {
  //         List<Temperature> temperatures = snapshot.data.docs
  //             .map((documentSnapshot) =>
  //                 Temperature.fromMap(documentSnapshot.data()))
  //             .toList();
  //         //print(temperatures);
  //         return _buildStatGrid(context, temperatures);
  //       }
  //     },
  //   );
  // }

  // Widget _buildStatGrid(BuildContext context, List<Temperature> temperature) {
  Widget _buildStatGrid(BuildContext context) {
    //mydata = temperature;
    //print(mydata);
    // maxTemp = mydata.reduce((currentUser, nextUser) =>
    //     currentUser.temperature > nextUser.temperature
    //         ? currentUser
    //         : nextUser);
    // minTemp = mydata.reduce((currentUser, nextUser) =>
    //     currentUser.temperature < nextUser.temperature
    //         ? currentUser
    //         : nextUser);
    //print(oldestUser);
    //_generateData(mydata);
    const MaterialColor white = const MaterialColor(
      0xFFFFFFFF,
      const <int, Color>{
        50: const Color(0xFFFFFFFF),
        100: const Color(0xFFFFFFFF),
        200: const Color(0xFFFFFFFF),
        300: const Color(0xFFFFFFFF),
        400: const Color(0xFFFFFFFF),
        500: const Color(0xFFFFFFFF),
        600: const Color(0xFFFFFFFF),
        700: const Color(0xFFFFFFFF),
        800: const Color(0xFFFFFFFF),
        900: const Color(0xFFFFFFFF),
      },
    );
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                  'Higher Treshold Dust',
                  '35',
                  white,
                  Colors.red,
                ),
                _buildStatCard(
                  'Lower Treshold Dust',
                  '20',
                  white,
                  Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildStatCard(
    String title,
    String count,
    MaterialColor color,
    MaterialColor textColor,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15.00),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 6,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            margin: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/sandstorm.png",
                      height: 40,
                      color: textColor,
                    ),
                    Text(
                      '${count} °C',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
