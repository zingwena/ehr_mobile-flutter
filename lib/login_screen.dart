import 'dart:io';

import 'package:ehr_mobile/view/search_patient.dart';
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
      body: Builder(
        builder: (BuildContext context){
               return Center(
          child: loginBody(context),
        );
        }

      ),
    );
  }

  loginBody(BuildContext context) => SingleChildScrollView(
    
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[loginHeader(), loginFields(context)],
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

  loginFields(BuildContext context) => Form(
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
                 validator: (value){
                      if(value.isEmpty){
                        return "required";
                      }
                      else{
                        return null;
                      }},
                onSaved: (value){
                      setState(() {
                        username=value;
                      });
                    },
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
                 validator: (value){
                      if(value.isEmpty){
                        return "required";
                      }
                      else{
                        return null;
                      }},
                onSaved: (value){
                      setState(() {
                        password=value;
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
                onPressed:
                    () async{
                      
                      if(_key.currentState.validate()){
                    _key.currentState.save();
                String result;

                try{
                  result=await platform.invokeMethod("login",[username,password]);
                  
              if(result.contains("Welcome"))
                {

                  // display Search Patient Screen
                       Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPatient()),
               );
                }
                else{
                   Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
            ),
          );
                }
                }
                catch(e){
                     print('Exception : $e ');
                }
                 
                      }
                      
                    }
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
      ),
  );

}
