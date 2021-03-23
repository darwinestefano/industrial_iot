import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:industrial_iot_app/widgets/dust_rt_setup/dust_chart/dust_env_chart.dart';

class DustController extends StatefulWidget {
  @override
  _DustControllerState createState() => _DustControllerState();
}

class _DustControllerState extends State<DustController>
    with TickerProviderStateMixin {
  bool isLoading = false;

  CollectionReference humidity = FirebaseFirestore.instance.collection('dust');

  AnimationController progressController;
  Animation<double> dustAnimation;

  @override
  void initState() {
    super.initState();
    dataStream();
  }

  void dataStream() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('dust')
        .orderBy('datestamp')
        .orderBy('timestamp')
        .snapshots()) {
      for (var data in snapshot.docs) {
        int hum = data.data()['dust'];
        // print(temp);
        isLoading = true;
        double t = hum.toDouble();
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

    dustAnimation =
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
            'Current Dust',
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
                  foregroundPainter:
                      DustCircleProgress(dustAnimation.value, true),
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Dust'),
                          Text(
                            '${dustAnimation.value.toInt()}',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '%',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Text(
                  'Please wait unitl the data has been processed...',
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
