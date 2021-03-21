import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.white.withOpacity(.9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/factory.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            //_buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Positioned(
      bottom: 50,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Your Industrial Environmental Controller.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[200],
                height: 1,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (_) => AuthScreen(),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(50),
            //       ),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black26,
            //           offset: Offset(1, 1),
            //           spreadRadius: 1,
            //           blurRadius: 3,
            //         )
            //       ],
            //     ),
            //     width: MediaQuery.of(context).size.width * .85,
            //     height: 60,
            //     child: Center(
            //       child: Text(
            //         "GET STARTED",
            //         style: TextStyle(
            //           color: Palette.primaryColor,
            //           fontWeight: FontWeight.bold,
            //           fontSize: 20,
            //         ),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
