import 'dart:convert';

import 'package:ehr_mobile/model/token.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import '../login_screen.dart';

class DataSyncronization extends StatefulWidget {
  @override
  _DataSyncronizationState createState() => new _DataSyncronizationState();
}

class _DataSyncronizationState extends State<DataSyncronization> {
  static const MethodChannel platform = MethodChannel('Authentication');
  Token token;

  String url, username, password;
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: dataSyncBody(),
      ),
    );
  }

  dataSyncBody() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[dataSyncHeader(), loginFields()],
        ),
      );

  dataSyncHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Image(
            image: AssetImage('images/mhc.png'),
            width: 120,
            height: 120,
          ),
          SizedBox(
            height: 20.0,
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
            "Data Synchronization Page",
            style: TextStyle(color: Colors.teal, fontSize: 16),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      );

  loginFields() => Form(
        key: _key,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                child: TextFormField(
                  maxLines: 1,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill this field";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      url = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "XXX.XXX.X.XX",
                    labelText: "Facility Server IP",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
                child: TextFormField(
                  maxLines: 1,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill this field";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter Username",
                    labelText: "Username",
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                child: TextFormField(
                  maxLines: 1,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill this field";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Password",
                    labelText: "Password",
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 60.0),
                width: double.infinity,
                child: RaisedButton(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.teal,
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "PULL METADATA",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: ()
  async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        await fetchPost();
                      }
                    }
//                  => Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => LoginScreen()),
//                  ),
                    ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SpinKitHourGlass(color: Colors.teal),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      );

  Future<void> fetchPost() async {
    String ehr_url = url;
    var body = json.encode({"username": username, "password": password});

    final response = await http.post(url + "/api/authenticate",
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      token = Token.fromJson(json.decode(response.body));

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      String result =
          await platform.invokeMethod("DataSync", [ehr_url, token.id_token]);

      print("Response =================" + result.toString());

      await platform.invokeMethod("DataSync", [ehr_url, token.id_token]);
    } else {
      print(response.body);
      // If that response was not OK, throw an error.

      _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text('Authentication failed'),
            ),
          );


      throw Exception('Failed to authenticate');
    }
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Network error please check your connections")));
  }
}
