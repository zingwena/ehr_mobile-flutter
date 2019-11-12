import 'package:ehr_mobile/view/data_syncronization.dart';
import 'package:ehr_mobile/view/hts_testscreening.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'view/data_syncronization.dart';


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

  loginBody() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[loginHeader(), loginFields()],
        ),
      );

  loginHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Image(
            image: AssetImage('images/mhc.png'),
            width: 150,
            height: 150,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Impilo Mobile",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.grey.shade600,
                fontSize: 30),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
        ],
      );

  loginFields() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: Text(
                "For the first time at EHR",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
              width: double.infinity,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.white,
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Synchronize Data",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.teal,
                      fontWeight: FontWeight.w500),
                ),
                borderSide: BorderSide(
                  color: Colors.teal, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 3.0, //width of the border
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataSyncronization()),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              width: double.infinity,
              child: Text(
                "To perfom day to day operations",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 14.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
              width: double.infinity,
              child: OutlineButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.white,
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
                borderSide: BorderSide(
                  color: Colors.blue, //Color of the border
                  style: BorderStyle.solid, //Style of the border
                  width: 3.0, //width of the border
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      );
}
