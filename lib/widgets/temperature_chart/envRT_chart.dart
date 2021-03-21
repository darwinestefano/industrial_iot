import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TemperatureEnvRTChart extends StatefulWidget {
  @override
  _TemperatureEnvRTChartState createState() => _TemperatureEnvRTChartState();
}

class _TemperatureEnvRTChartState extends State<TemperatureEnvRTChart> {
  @override
  Widget build(BuildContext context) {
    String datetime;
    List<double> temperature;

    void dataStream() async {
      await for (var snapshot in FirebaseFirestore.instance
          .collection('temperature')
          .orderBy('timestamp')
          .snapshots()) {
        for (var data in snapshot.docs) {
          int temp = data.data()['temperature'];
          datetime = data.data()['timestamp'];
          double t = temp.toDouble();
          temperature.add(t);
        }
      }
    }

    return Container(
      height: 360.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Daily Recordings',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 16.0,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    margin: 10.0,
                    showTitles: true,
                    rotateAngle: 35.0,
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 0:
                          return '${datetime} °C';
                        case 1:
                          return '${datetime} °C';
                        case 2:
                          return '${datetime} °C';
                        case 3:
                          return '${datetime} °C';
                        case 4:
                          return '${datetime} °C';
                        case 5:
                          return '${datetime} °C';
                        case 6:
                          return '${datetime} °C';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(
                      margin: 10.0,
                      showTitles: true,
                      getTitles: (value) {
                        if (value == 0) {
                          return '0';
                        } else if (value % 3 == 0) {
                          return '${value ~/ 3 * 5} °C';
                        }
                        return '';
                      }),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 3 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black12,
                    strokeWidth: 1.0,
                    dashArray: [5],
                  ),
                ),
                borderData: FlBorderData(show: false),
                // barGroups: temperature
                //     .asMap()
                //     .map((key, value) => MapEntry(
                //         key,
                //         BarChartGroupData(
                //           x: key,
                //           barRods: [
                //             BarChartRodData(
                //               y: value,
                //             ),
                //           ],
                //         )))
                //     .values
                //     .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
