import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:industrial_iot_app/widgets/temp_rt_setup/temperature.dart';

class TemperatureRTChart extends StatefulWidget {
  @override
  _TemperatureRTChartState createState() => _TemperatureRTChartState();
}

class _TemperatureRTChartState extends State<TemperatureRTChart> {
  List<LineSeries<Temperature, String>> _seriesBarData;
  List<Temperature> mydata;

  _generateData(mydata) {
    //ignore: deprecated_member_use
    _seriesBarData = List<LineSeries<Temperature, String>>();
    _seriesBarData.add(
      LineSeries(
        dataSource: mydata,
        xValueMapper: (Temperature temp, _) {
          return temp.timestamp.toString();
        },
        yValueMapper: (Temperature temp, _) => temp.temperature,
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
          .collection('temperature')
          .orderBy('timestamp', descending: true)
          .limit(5)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Temperature> temperatures = snapshot.data.docs
              .map((documentSnapshot) =>
                  Temperature.fromMap(documentSnapshot.data()))
              .toList();
          return _buildChart(context, temperatures);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Temperature> temperature) {
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
