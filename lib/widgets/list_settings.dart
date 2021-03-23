import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function actionBtn;

  ProfileListItem({
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.actionBtn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 6,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.98,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: 20,
              color: Colors.black,
            ),
            SizedBox(width: 20),
            Text(
              this.text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                Icons.keyboard_arrow_right_outlined,
                size: 20,
                color: Colors.black,
              ),
          ],
        ),
        onPressed: actionBtn,
      ),
    );
  }
}
// FirebaseAuth.instance.signOut();
// showDialog(
//             builder: (ctxt) {
//               return AlertDialog(
//                 title: Text('Logout'),
//                 content: Column(
//                   children: <Widget>[
//                     Text('are you sure you want to logout?'),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         RaisedButton(
//                           child: Text("Cancel"),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                         RaisedButton(
//                           child: Text("Logout"),
//                           onPressed: () {
//                             FirebaseAuth.instance.signOut();
//                           },
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               );
//             },
//           );
