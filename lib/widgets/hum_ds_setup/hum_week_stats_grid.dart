import 'package:flutter/material.dart';

class HumidityweekStats extends StatefulWidget {
  @override
  _HumidityweekStatsState createState() => _HumidityweekStatsState();
}

class _HumidityweekStatsState extends State<HumidityweekStats> {
  @override
  Widget build(BuildContext context) {
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
      height: MediaQuery.of(context).size.height * 0.30,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                  'Max Humidity',
                  '31',
                  'assets/images/humidity.png',
                  white,
                  Colors.green,
                ),
                _buildStatCard(
                  'Min Humidity',
                  '20',
                  'assets/images/humidity.png',
                  white,
                  Colors.pink,
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard(
                  'Average Humidity',
                  '23',
                  'assets/images/gauge.png',
                  white,
                  Colors.grey,
                ),
                _buildStatCard(
                  'Sensors Active',
                  '1',
                  'assets/images/sensor.png',
                  white,
                  Colors.grey,
                ),
                // _buildStatCard('Critical Status', '2', white, Colors.red),
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
    String path,
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
                color: Colors.black,
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
            margin: const EdgeInsets.all(7.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Image.asset(
                      path,
                      height: 35,
                      color: textColor,
                    ),
                    Text(
                      count,
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
}
