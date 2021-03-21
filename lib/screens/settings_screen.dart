import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:industrial_iot_app/config/palette.dart';
import 'package:industrial_iot_app/widgets/custom_app_bar.dart';
import 'package:industrial_iot_app/widgets/list_settings.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var header = Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Palette.appBar,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/images/user.png",
            height: 32,
            color: Colors.white,
          ),
          SizedBox(height: 15),
          Text(
            'Darwin Machado',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text('darwinstefano12@hotmail.com',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              )),
          SizedBox(height: 10),
        ],
      ),
    );

    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                header,
                ProfileListItem(
                  icon: Icons.account_circle_outlined,
                  text: 'Account',
                  actionBtn: () {},
                ),
                ProfileListItem(
                  icon: Icons.notifications,
                  text: 'Notifications',
                  actionBtn: () {},
                ),
                ProfileListItem(
                  icon: Icons.settings,
                  text: 'General',
                  actionBtn: () {},
                ),
                ProfileListItem(
                  icon: Icons.device_hub,
                  text: 'Devices',
                  actionBtn: () {},
                ),
                ProfileListItem(
                  icon: Icons.help,
                  text: 'Help',
                  actionBtn: () {},
                ),
                ProfileListItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  hasNavigation: false,
                  actionBtn: () => FirebaseAuth.instance.signOut(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
