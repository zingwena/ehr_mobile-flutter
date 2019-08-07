import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:cbs_app/view/home_page.dart';
//import 'package:cbs_app/view/add_patient.dart';

// import 'package:fresh_app/utils/navigation_router.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  static const MethodChannel platform= MethodChannel('Authentication');

  String url,username,password;

  final _key=GlobalKey<FormState>();
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
        height: 30.0,
      ),
      Text(
        "EHR Mobile App",
        style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.grey.shade600,
            fontSize: 30),
      ),
      SizedBox(
        height: 10.0,
      ),
      Text(
        "Click Login to Continue",
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
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
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
          child: TextFormField(
            maxLines: 1,

            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter your Username",
              labelText: "Username",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
          child: TextFormField(
            maxLines: 1,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter your Password",
              labelText: "Password",
            ),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.blue,
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "LOG IN",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: null,
//                () =>
//                Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => AddPatient()),
//            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Forgot Password",
          style: TextStyle(color: Colors.blue),
        ),
        SizedBox(
          height: 15.0,
        ),
      ],
    ),
  );
}
