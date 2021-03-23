import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:industrial_iot_app/config/palette.dart';
import 'package:industrial_iot_app/screens/dust/dust_screen.dart';
import 'package:industrial_iot_app/screens/humidity/humidity_screen.dart';
import 'package:industrial_iot_app/screens/temperature/temperature_screen.dart';
import 'package:industrial_iot_app/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic('temperature');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(screenHeight),
          _buildHeadings(screenHeight, "Environmental "),
          _buildTempHumDustMenu(screenHeight),
          _buildHeadings(screenHeight, "Production Line "),
          _buildProductionLine(screenHeight),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildHeader(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Palette.appBar,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Real-Time IOT Sensors',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'IoT Solution delivers true vision by enabling you not only see visual data from any number of data streams, but also to think, plan and act in ways that benefit your organization',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14.0,
                //fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildHeadings(double screenHeight, String txt) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(18),
        child: RichText(
          text: TextSpan(
            text: txt,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: "Sensors",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTempHumDustMenu(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 10),
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _buildEnvironmentalSensors(
              "assets/images/thermometer.png",
              "TEMPERATURE",
              "Device",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TemperatureDashboard(),
                  ),
                );
              },
            ),
            _buildEnvironmentalSensors(
              "assets/images/humidity.png",
              "HUMIDITY",
              "Device ",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HumidityDashboard(),
                  ),
                );
              },
            ),
            _buildEnvironmentalSensors(
              "assets/images/sandstorm.png",
              "DUST",
              " Device",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DustDashboard(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildEnvironmentalSensors(
    String path, String text1, String text2, Function state) {
  return Column(
    children: <Widget>[
      FlatButton(
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Image.asset(
                path,
                height: 40,
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: "$text1\n",
                  style: TextStyle(
                    color: Palette.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: text2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onPressed: state,
      ),
    ],
  );
}

SliverToBoxAdapter _buildProductionLine(double screenHeight) {
  return SliverToBoxAdapter(
    child: Container(
      height: 125,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 16),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          _buildProductionLineSensors(
              "assets/images/conveyor-belt.png", "LINE I", "Device"),
          _buildProductionLineSensors(
              "assets/images/conveyor-belt.png", "LINE II", "Device "),
          // _buildProductionLineSensors(
          //     "assets/images/sandstorm.png", "DUST", " Device"),
          // _buildPrevention("assets/images/fr_flag.png", "USE", "mask"),
        ],
      ),
    ),
  );
}

Widget _buildProductionLineSensors(String path, String text1, String text2) {
  return Column(
    children: <Widget>[
      Container(
        width: 130,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(1, 1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            SizedBox(width: 10),
            Image.asset(
              path,
              height: 50,
            ),
            SizedBox(width: 10),
            RichText(
              text: TextSpan(
                  text: "$text1\n",
                  style: TextStyle(
                    color: Palette.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: text2,
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ]),
            )
          ],
        ),
        margin: EdgeInsets.only(right: 20),
      ),
    ],
  );
}
