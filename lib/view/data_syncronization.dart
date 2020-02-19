import 'dart:convert';

import 'package:ehr_mobile/model/token.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/sync/fetch_patient_record.dart';
import 'package:ehr_mobile/sync/pull_meta_data.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../login_screen.dart';

class DataSyncronization extends StatefulWidget {
  @override
  _DataSyncronizationState createState() => new _DataSyncronizationState();
}

class _DataSyncronizationState extends State<DataSyncronization> {
  static const MethodChannel platform = MethodChannel('Authentication');
  Token token;

  String url;
  String ipAndPort;
  String username;
  String password;
  final _key = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {

    progressDialog = new ProgressDialog(context);
    progressDialog.style(
        message: 'Pulling Data from EHR Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.blueAccent, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.blueAccent, fontSize: 19.0, fontWeight: FontWeight.w600)
    );

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
            "Impilo Mobile App",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.grey.shade600,
                fontSize: 30),
          ),
          SizedBox(
            height: 10.0,
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
                      ipAndPort=value;
                      url='$ipAndPort';
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Login', style: TextStyle(color: Colors.white, fontSize: 18),),
                        Icon(Icons.navigate_next, color: Colors.white, ),
                      ],
                    ),
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        progressDialog.show();
                        await fetchPost(progressDialog).then((result){
                          progressDialog.hide().whenComplete((){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          });
                        });
//                            .catchError((error){
//                          progressDialog.hide().whenComplete((){
//                            Alert(
//                              type: AlertType.warning,
//                              context: context,
//                              title: "Login",
//                              desc: "${error.toString().replaceAll("Exception:", "")}",
//                              style: AlertStyle(
//                                isCloseButton: false,
//                                isOverlayTapDismiss: false,),
//                              buttons: [
//                                DialogButton(
//                                  child: Text(
//                                    "OK",
//                                    style: TextStyle(color: Colors.white, fontSize: 20),
//                                  ),
//                                  onPressed: () => Navigator.pop(context),
//                                  color: Color.fromRGBO(0, 179, 134, 1.0),
//                                )
//                              ]
//                            ).show();
//                          });
//                        });
                      }
                    }),
              ),
              SizedBox(
                height: 20.0,
              ),
              SpinKitRipple(color: Colors.teal, size: 90,),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      );

  Future<void> fetchPost(ProgressDialog progressDialog) async {
    String ehr_url = url;
    var body = json.encode({"username": username, "password": password});

    final response = await http.post(url + "/api/authenticate",
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: body).timeout(Duration(seconds: 5),onTimeout:() {
          progressDialog.hide();
          throw Exception('Failed to connect to server');
          //return resp;
    }).catchError((value){
      log.e(value);
      throw Exception('Failed to connect to server, \n Check your IP address and Port');
    });
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      token = Token.fromJson(json.decode(response.body));
      await storeString(AUTH_TOKEN, token.id_token);
      await storeString(SERVER_IP, ehr_url);
      log.i("token-------${token.id_token}");
      String result =
          await platform.invokeMethod("DataSync", [ehr_url, token.id_token]);
      log.i("RESULT-------${result.toString()}");
      var pull=await pullMetaData(progressDialog,'$url/api',token.id_token);
      print("Response =========Meta Data========$pull");
      pull=await pullPatientData(progressDialog);
      print("Response =========Patient Data========$pull");
    } else {
      print(response.body);
      throw Exception('Failed to authenticate');
    }

  }
}
