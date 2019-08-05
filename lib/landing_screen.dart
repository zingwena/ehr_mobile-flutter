import 'package:flutter/material.dart';

import 'package:cbs_app/view/home_page.dart';
import 'package:cbs_app/view/data_syncronization.dart';
import 'package:cbs_app/login_screen.dart';

// import 'package:fresh_app/utils/navigation_router.dart';


class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => new _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: loginBody(),
      ),
    );
  }

  loginBody() =>
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields()],
        ),
      );

  loginHeader() =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image(image: AssetImage('images/mhc.png'),),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Welcome To EHR Mobile",
            style: TextStyle(fontWeight: FontWeight.w300, color: Colors.grey.shade600, fontSize: 30),
          ),
          SizedBox(
            height: 10.0,
          ),

          SizedBox(
            height: 10.0,
          ),
        ],
      );

  loginFields() =>
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[


            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                elevation: 4.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                color: Colors.teal,
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "For the first time at EHR : Synchronize Data",
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DataSyncronization()),),
              ),
            ),

            SizedBox(
              height: 30.0,
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                elevation: 4.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                color: Colors.blue,
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Login to perfom day to day operations",
                  style: TextStyle(color: Colors.white),
                ),

                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginScreen()),),
              ),
            ),

            SizedBox(
              height: 30.0,
            ),


          ],
        ),
      );


}












