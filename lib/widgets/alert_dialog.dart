import 'package:flutter/material.dart';
import 'package:industrial_iot_app/config/palette.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final MaterialAccentColor color;

  CustomAlertDialog(
    this.message,
    this.color,
  );
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.33,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      'ATENTION!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(message,
                        style: TextStyle(fontSize: 18, letterSpacing: 1),
                        textAlign: TextAlign.center),
                    SizedBox(
                      height: 20,
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: color,
                      child: Text(
                        'Okay',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: color,
                  radius: 60,
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.white,
                    size: 100,
                  ),
                )),
          ],
        ));
  }
}
