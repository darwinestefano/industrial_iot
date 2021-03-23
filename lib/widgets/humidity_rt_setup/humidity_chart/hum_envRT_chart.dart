import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:industrial_iot_app/widgets/humidity_rt_setup/humidity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

class HumidityRTChart extends StatefulWidget {
  @override
  _HumidityRTChartState createState() => _HumidityRTChartState();
}

class _HumidityRTChartState extends State<HumidityRTChart> {
  List<LineSeries<Humidity, String>> _seriesBarData;
  List<Humidity> mydata;

  _generateData(mydata) {
    //ignore: deprecated_member_use
    _seriesBarData = List<LineSeries<Humidity, String>>();
    _seriesBarData.add(
      LineSeries(
        dataSource: mydata,
        xValueMapper: (Humidity temp, _) {
          return temp.timestamp.toString();
        },
        yValueMapper: (Humidity temp, _) => temp.humidity,
        dataLabelSettings: DataLabelSettings(isVisible: true),
        enableTooltip: true,
        sortingOrder: SortingOrder.ascending,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('humidity')
          .orderBy('timestamp', descending: true)
          .limit(5)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Humidity> humidity = snapshot.data.docs
              .map((documentSnapshot) =>
                  Humidity.fromMap(documentSnapshot.data()))
              .toList();
          return _buildChart(context, humidity);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Humidity> temperature) {
    mydata = temperature;
    _generateData(mydata);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 30.00, bottom: 10),
          child: Text(
            'Latest Records',
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
          height: MediaQuery.of(context).size.height * 0.40,
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
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            legend: Legend(isVisible: false),
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: _seriesBarData,
          ),
        ),
      ],
    );
  }
}
