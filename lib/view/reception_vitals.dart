import 'dart:convert';

import 'package:ehr_mobile/vitals/blood_pressure.dart';
import 'package:ehr_mobile/vitals/height.dart';
import 'package:ehr_mobile/vitals/pulse.dart';
import 'package:ehr_mobile/vitals/respiratory_rate.dart';
import 'package:ehr_mobile/vitals/temperature.dart';
import 'package:ehr_mobile/vitals/visit.dart';
import 'package:ehr_mobile/vitals/weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReceptionVitals extends StatefulWidget {
  final String personId;
  ReceptionVitals(this.personId);


  @override
  _ReceptionVitalsState createState() => _ReceptionVitalsState();
}

class _ReceptionVitalsState extends State<ReceptionVitals> {
    static const platform = MethodChannel('ehr_mobile.channel/vitals');
  final _formKey = GlobalKey<FormState>();
  final _formKeyHeight = GlobalKey<FormState>();
  final _formKeyTemperature = GlobalKey<FormState>();
  final _formKeyPulse = GlobalKey<FormState>();
  final _formKeyRespiratoryRate = GlobalKey<FormState>();
  final _formKeyWeight = GlobalKey<FormState>();
  BloodPressure _bloodPressure = BloodPressure();
  Temperature _temperature = Temperature();
  Pulse _pulse = Pulse();
  RespiratoryRate _respiratoryRate = RespiratoryRate();
  Height _height = Height();
  Weight _weight = Weight();

    bool isPressed = false;
    bool isPressed1 = false;
    bool isPressed2 = false;
    bool isPressed3 = false;
    bool isPressed4 = false;
    bool isPressed5 = false;



  @override
  void initState() {

super.initState();
  }



  Future<void> saveVitals(var object,String method) async {


    try {

          await platform.invokeMethod(method, jsonEncode(object));
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  setVisit() {
    setState(() {
      _bloodPressure.personId = widget.personId;
      _temperature.personId = widget.personId;
      _pulse.personId = widget.personId;
      _respiratoryRate.personId = widget.personId;
      _height.personId =  widget.personId;
      _weight.personId = widget.personId;
    });
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
                   Column(
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
                                    Form(
                                      key: _formKey,
                                      child: Row(
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
                                                  validator: (value){
                                                   return value.isEmpty ? "Please fill this field" : null;
                                                  },
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    WhitelistingTextInputFormatter.digitsOnly
                                                  ],
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
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    WhitelistingTextInputFormatter.digitsOnly
                                                  ],
                                                  validator: (value){
                                                    return value.isEmpty ? "Please fill this field" : null;
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
                                            icon: Icon((isPressed == true)? Icons.done_outline :Icons.save,
                                                color: Colors.green),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();
                                                isPressed = true;
                                                saveVitals(_bloodPressure,'bloodPressure');
                                              }
                                            },
                                          )
                                        ],
                                      ),
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
                                    Form(
                                      key: _formKeyTemperature,
                                      child: Row(
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
                                                  validator: (value){
                                                    return value.isEmpty ? "Please fill this field" : null;
                                                  },
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    WhitelistingTextInputFormatter.digitsOnly
                                                  ],
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
                                            icon: Icon((isPressed1 == true)? Icons.done_outline :Icons.save,
                                                color: Colors.green),
                                            onPressed: () {
                                              if (_formKeyTemperature.currentState
                                                  .validate()) {
                                                _formKeyTemperature.currentState.save();
                                                isPressed1 = true;

                                                saveVitals(_temperature,'temperature');
                                              }
                                            },
                                          )
                                        ],
                                      ),
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
                                    Form(
                                      key: _formKeyPulse,
                                      child: Row(
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
                                                  keyboardType:  TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    WhitelistingTextInputFormatter.digitsOnly
                                                  ],
                                                  validator: (value){
                                                    return value.isEmpty ? "Please fill this field" : null;
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
                                            icon: Icon((isPressed2 == true)? Icons.done_outline :Icons.save,
                                                color: Colors.green),
                                            onPressed: () {
                                              if (_formKeyPulse.currentState
                                                  .validate()) {
                                                _formKeyPulse.currentState.save();
                                                isPressed2 = true;

                                                saveVitals(_pulse,'pulse');
                                              }
                                            },
                                          )
                                        ],
                                      ),
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
                                  Form(
                                    key: _formKeyRespiratoryRate,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
                                            child: Padding(
                                              padding: const EdgeInsets.all(0.0),
                                              child: TextFormField(
                                                onSaved: (value) {
                                                  _respiratoryRate.value = value;
                                                },
                                                keyboardType:  TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  WhitelistingTextInputFormatter.digitsOnly
                                                ],
                                                validator: (value){
                                                  return value.isEmpty ? "Please fill this field" : null;
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
                                          icon: Icon((isPressed3 == true)? Icons.done_outline :Icons.save,
                                              color: Colors.green),
                                          onPressed: () {
                                            if (_formKeyRespiratoryRate.currentState
                                                .validate()) {
                                              _formKeyRespiratoryRate.currentState.save();
                                              isPressed3 = true;

                                              saveVitals(_respiratoryRate,'respiratoryRate');
                                            }
                                          },
                                        )
                                      ],
                                    ),
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
                                  Form(
                                    key: _formKeyHeight,
                                    child: Row(
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
                                                keyboardType:  TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  WhitelistingTextInputFormatter.digitsOnly
                                                ],
                                                validator: (value){
                                                  return value.isEmpty ? "Please fill this field" : null;
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
                                          icon: Icon((isPressed4 == true)? Icons.done_outline :Icons.save,
                                              color: Colors.green),
                                          onPressed: () {
                                            if (_formKeyHeight.currentState
                                                .validate()) {
                                              _formKeyHeight.currentState.save();
                                              isPressed4 = true;
                                              saveVitals(_height,'height');
                                            }
                                          },
                                        )
                                      ],
                                    ),
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
                                  Form(
                                    key: _formKeyWeight,
                                    child: Row(
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
                                                validator: (value){
                                                  return value.isEmpty ? "Please fill this field" : null;
                                                },
                                                keyboardType:  TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  WhitelistingTextInputFormatter.digitsOnly
                                                ],
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
                                          icon: Icon((isPressed5 == true)? Icons.done_outline :Icons.save,
                                              color: Colors.green),
                                          onPressed: () {
                                        if(_formKeyWeight.currentState.validate()){
                                          _formKeyWeight.currentState.save();
                                          isPressed5 = true;
                                          saveVitals(_weight,'weight');

                                        }
                                          },
                                        )
                                      ],
                                    ),
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

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
