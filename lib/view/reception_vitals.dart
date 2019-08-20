import 'dart:convert';

import 'package:ehr_mobile/vitals/blood_pressure.dart';
import 'package:ehr_mobile/vitals/height.dart';
import 'package:ehr_mobile/vitals/pulse.dart';
import 'package:ehr_mobile/vitals/respiratory_rate.dart';
import 'package:ehr_mobile/vitals/temperature.dart';
import 'package:ehr_mobile/vitals/weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReceptionVitals extends StatefulWidget {
  ReceptionVitals({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReceptionVitalsState createState() => _ReceptionVitalsState();
}

class _ReceptionVitalsState extends State<ReceptionVitals> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  final _formKey = GlobalKey<FormState>();
  BloodPressure _bloodPressure = BloodPressure();
  Temperature _temperature = Temperature();
  Pulse _pulse = Pulse();
  RespiratoryRate _respiratoryRate = RespiratoryRate();
  Height _height = Height();
  Weight _weight = Weight();

  Future<void> saveVitals(var object,String method) async {
    List<dynamic> list;

    try {
      list = jsonDecode(
          await platform.invokeMethod(method, jsonEncode(object))
      );
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Reception Vitals'),
      ),
      backgroundColor: Colors.blue.shade50,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 230,
                            child: Card(
                              margin: new EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                  top: 50.0,
                                  bottom: 5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              elevation: 0.0,
                              child: new Padding(
                                padding: new EdgeInsets.all(25.0),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                      child: new Text(
                                        "Blood Pressure",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: TextFormField(
                                                onSaved: (value) {
                                                  setState(() {
                                                    _bloodPressure.systolic =
                                                        value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'systolic',
                                                  border: OutlineInputBorder(),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            width: 20,
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: TextFormField(
                                                onSaved: (value) {
                                                  setState(() {
                                                    _bloodPressure.diastolic =
                                                        value;
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'diastolic',
                                                  border: OutlineInputBorder(),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            width: 20,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.save),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();

                                              saveVitals(_bloodPressure,'bloodPressure');
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Container(
                            height: 220,
                            child: Card(
                              margin: new EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                  top: 50.0,
                                  bottom: 5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              elevation: 0.0,
                              child: new Padding(
                                padding: new EdgeInsets.all(25.0),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                      child: new Text(
                                        "Temperature",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: TextFormField(
                                                onSaved: (value) {
                                                  _temperature.value = value;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'temperature',
                                                  border: OutlineInputBorder(),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            width: 100,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.save),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();

                                              saveVitals(_temperature,'temperature');
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Container(
                            height: 220,
                            child: Card(
                              margin: new EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                  top: 50.0,
                                  bottom: 5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              elevation: 0.0,
                              child: new Padding(
                                padding: new EdgeInsets.all(25.0),
                                child: new Column(
                                  children: <Widget>[
                                    new Container(
                                      child: new Text(
                                        "Pulse",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: TextFormField(
                                                onSaved: (value) {
                                                  _pulse.value = value;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'pulse',
                                                  border: OutlineInputBorder(),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            width: 100,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.save),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _formKey.currentState.save();

                                              saveVitals(_pulse,'pulse');
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        Container(
                          height: 220,
                          child: Card(
                            margin: new EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                                top: 50.0,
                                bottom: 5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 0.0,
                            child: new Padding(
                              padding: new EdgeInsets.all(25.0),
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    child: new Text(
                                      "Respiratory Rate",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextFormField(
                                              onSaved: (value) {
                                                _respiratoryRate.value = value;
                                              },
                                              decoration: InputDecoration(
                                                labelText: '',
                                                border: OutlineInputBorder(),
                                              ),
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.save),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();

                                            saveVitals(_respiratoryRate,'respiratoryRate');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 230,
                          child: Card(
                            margin: new EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                                top: 50.0,
                                bottom: 5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 0.0,
                            child: new Padding(
                              padding: new EdgeInsets.all(25.0),
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    child: new Text(
                                      "Height",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              onSaved: (value) {
                                                setState(() {
                                                  _height.value = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Height',
                                                border: OutlineInputBorder(),
                                              ),
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          width: 100,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.save),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            saveVitals(_height,'height');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 230,
                          child: Card(
                            margin: new EdgeInsets.only(
                                left: 30.0,
                                right: 30.0,
                                top: 50.0,
                                bottom: 5.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 0.0,
                            child: new Padding(
                              padding: new EdgeInsets.all(25.0),
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    child: new Text(
                                      "Weight",
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              onSaved: (value) {
                                                setState(() {
                                                  _weight.value = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Weight',
                                                border: OutlineInputBorder(),
                                              ),
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          width: 20,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.save),
                                        onPressed: () {
                                      if(_formKey.currentState.validate()){
                                        _formKey.currentState.save();
                                        saveVitals(_weight,'weight');

                                      }
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
