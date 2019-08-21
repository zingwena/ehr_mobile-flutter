import 'dart:convert';

import 'package:ehr_mobile/model/token.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DataSyncronization extends StatefulWidget {
  @override
  _DataSyncronizationState createState() => new _DataSyncronizationState();
}

class _DataSyncronizationState extends State<DataSyncronization> {
  static const MethodChannel platform = MethodChannel('Authentication');
  Token token;

  String url, username, password;

  final _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Builder(builder: (BuildContext context) {
        return Center(
          child: dataSyncBody(),

        );
      }),
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
          Image(
            image: AssetImage('images/mhc.png'),
            width: 150,
            height: 150,
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
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty) {
                    return "required";
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
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty) {
                    return "required";
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
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
              child: TextFormField(
                maxLines: 1,
                validator: (value) {
                  if (value.isEmpty) {
                    return "required";
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
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
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
              width: double.infinity,
              child: RaisedButton(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.teal,
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_key.currentState.validate()) {
                      DateTime date = DateTime.now();

                      _key.currentState.save();

//             String result;
//             try {
//
//           result= await platform.invokeMethod("DataSync", [url, username, password]);
//           print("======================result"+result.toString());
//
//             }catch(e){
//               print(e);
//             }
                      fetchPost();

//           result= await platform.invokeMethod("DataSync", [url, username, password]);
//           if(result.contains("Welcome")){
//                Navigator.push(
//               context, MaterialPageRoute(builder: (context) => SearchPatient()));
//                          print("Response ================="+result.toString());
//
//           }
//
//          else {
//
//                Scaffold.of(context).showSnackBar(
//            SnackBar(
//              content: Text('Have a snack!'),
//            ),
//          );
//
//          }
//             }catch(e){
//               print(e);
//             }
//

                    }
                  }),
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ));

  Future<String> fetchPost() async {
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
          context, MaterialPageRoute(
          builder: (context) => SearchPatient()));


      String result = await platform.invokeMethod("DataSync", [ehr_url, token.id_token]);

    } else {
      print(response.body);
      // If that response was not OK, throw an error.
      Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Authentication failed'),
            ),
          );

      throw Exception('Failed to authenticate');
    }
  }
}

//https://apps.mohcc.gov.zw/impilo-ZW060383/api/authenticate
