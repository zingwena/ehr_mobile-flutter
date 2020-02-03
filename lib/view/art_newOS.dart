import 'dart:convert';


import 'package:ehr_mobile/landing_screen.dart';
import 'package:ehr_mobile/model/country.dart';
import 'package:ehr_mobile/model/person.dart';

import 'package:ehr_mobile/view/patient_address.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'patient_address.dart';
//import 'rounded_button.dart';
//import 'package:ehr_mobile/login_screen.dart';

class ArtNewOI extends StatefulWidget {


  ArtNewOI();

  @override
  State createState() {
    return _ArtNewOI();
  }
}

class _ArtNewOI extends State<ArtNewOI> {
  static const platform = MethodChannel('example.channel.dev/people');
  static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');

  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();


  DateTime birthDate;
  bool _formValid=false;
  bool showError=false;
  String clinicalStage = "";
  int _gender = 0;
  String gender = "";

  @override
  void initState() {

    super.initState();
  }

  void _handleGenderChange(int value) {
    setState(() {
      _gender = value;

      switch (_gender) {
        case 1:
          gender = "MALE";
          break;
        case 2:
          gender = "FEMALE";

          break;
      }
    });
  }

  String nullValidator(var cell) {
    return cell == null ? "" : cell;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.blue],
              ),
            ),
            height: 210.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: new Text("Impilo Mobile",   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.person_pin, size: 25.0, color: Colors.white,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("admin", style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0,color: Colors.white ),),
                        ),
                      ])
              ),
            ],
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Art New OIs", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                 // _buildButtonsRow(),
                  Expanded(
                    child: new Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                        child: new LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return Column(
                              children: <Widget>[
                                //_buildLinkBar(),
                                Container(
                                  height: 2.0,
                                  color: Colors.blue,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: new ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minHeight: viewportConstraints.maxHeight - 48.0,
                                      ),
                                      child: new IntrinsicHeight(
                                          child: Column(
                                            children: <Widget>[
                                              Form(key: _formKey,

                                                child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 35.0,
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Zoster'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Thrush - Vaginal'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Dementia / Encephalitis'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Pneumonia'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Cough'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Fever'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Hypertension'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Diabetes Mellitus'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Mental Disorders'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Thrush - Oral'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Ulcers - Genital'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('IRIS'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Ulcers - Oral'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Difficult Breathing'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('TB'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Cancer'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Hepatitis'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Weight Loss'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _gender,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleGenderChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 30.0,
                                                        ),

                                                        Container(
                                                          width: double.infinity,
                                                          padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0) ,
                                                          child: RaisedButton(
                                                            elevation: 8.0,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(5.0)),
                                                            color: Colors.blue,
                                                            padding: const EdgeInsets.all(20.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Text('Proceed to Contact Details', style: TextStyle(color: Colors.white),),
                                                                Icon(Icons.navigate_next, color: Colors.white, ),
                                                              ],
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                _formValid = true;
                                                              });


                                                              if (_formValid) {
                                                                _formKey.currentState.save();

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            LandingScreen()));
                                                              }

                                                            },
                                                          ),
                                                        ),

                                                        SizedBox(
                                                          height: 20.0,
                                                        ),

                                                      ],
                                                    ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        length: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



}

