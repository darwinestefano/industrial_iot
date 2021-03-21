import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:industrial_iot_app/widgets/temperature_chart/temp_env_chart.dart';

class TemperatureController extends StatefulWidget {
  @override
  _EnvironmentDashboardState createState() => _EnvironmentDashboardState();
}

class _EnvironmentDashboardState extends State<TemperatureController>
    with TickerProviderStateMixin {
  bool isLoading = false;

  CollectionReference temperature =
      FirebaseFirestore.instance.collection('temperature');

  AnimationController progressController;
  Animation<double> tempAnimation;

  @override
  void initState() {
    super.initState();
    dataStream();
  }

  void dataStream() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('temperature')
        .orderBy('timestamp')
        .snapshots()) {
      for (var data in snapshot.docs) {
        int temp = data.data()['temperature'];
        isLoading = true;
        double t = temp.toDouble();
        _dashboardInit(t);
      }
    }
  }

  _dashboardInit(double temp) {
    progressController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    ); //5s

    tempAnimation =
        Tween<double>(begin: temp, end: temp).animate(progressController)
          ..addListener(() {
            if (mounted) {
              setState(() {
                // The state that has changed here is the animation object’s value.
              });
            }
          });
    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15.00),
          child: Text(
            'Current Temperature',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width * 0.90,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
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
          child: isLoading
              ? CustomPaint(
                  foregroundPainter: CircleProgress(tempAnimation.value, true),
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Temperature'),
                          Text(
                            '${tempAnimation.value.toInt()}',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '°C',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Text(
                  'Loading data...',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400],
                  ),
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    progressController.dispose();

    super.dispose();
  }
}
