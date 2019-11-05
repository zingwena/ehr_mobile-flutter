import 'dart:convert';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/vitals/blood_pressure.dart';
import 'package:ehr_mobile/vitals/height.dart';
import 'package:ehr_mobile/vitals/pulse.dart';
import 'package:ehr_mobile/vitals/respiratory_rate.dart';
import 'package:ehr_mobile/vitals/temperature.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/view/patient_overview.dart';

import 'package:ehr_mobile/vitals/visit.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/model/person.dart';

import 'package:ehr_mobile/vitals/weight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ReceptionVitals extends StatefulWidget {
  final String personId;
  final String visitId;
  final Person person;
  ReceptionVitals(this.personId, this.visitId, this.person);


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
    setVisit();
    super.initState();
  }


  Future<void> saveVitals(var object, String method) async {
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
      _height.personId = widget.personId;
      _weight.personId = widget.personId;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("admin"), accountEmail: new Text("admin@gmail.com"), currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage('images/mhc.png'))),
            new ListTile(leading: new Icon(Icons.home, color: Colors.blue),title: new Text("Home "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchPatient()),
            )),
              new ListTile(leading: new Icon(Icons.person, color: Colors.blue),title: new Text("Patient Overview "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Overview(widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Vitals",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(widget.personId, widget.visitId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("HTS", style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Registration(widget.visitId,widget.personId, widget.person)),
            )),
            new ListTile( leading: new Icon(Icons.book, color: Colors.blue),title: new Text("ART",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArtReg(widget.personId, widget.visitId, widget.person)),
            ))

          ],
        ),
      ),
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
            title: new Text("Vitals",
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .padding
                      .top + 40.0),
              child: new Column(
                children: <Widget>[
              /*    _buildButtonsRow(),*/
                  Expanded(

                    child: new Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                        child: new LayoutBuilder(
                          builder:
                              (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return Column(
                              children: <Widget>[
                                //   _buildTabBar(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: new ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minHeight: viewportConstraints
                                            .maxHeight - 48.0,
                                      ),
                                      child: new IntrinsicHeight(
                                        child: Column(
                                            children: <Widget>[
                                              Form(
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(16.0),
                                                    child: Column(
                                                      children: <Widget>[

                                                        Form(
                                                          key: _formKey,
                                                          child: Row(
                                                            children: <Widget>[

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                                                                  child: Text("Blood Pressure",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.blue.shade600,
                                                                        fontSize: 16, fontWeight: FontWeight.w500),),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      right: 16.0),
                                                                  child: TextFormField(
                                                                    onSaved: (value) {
                                                                      setState(() {
                                                                        _bloodPressure.systolic = value;
                                                                      });
                                                                    },
                                                                    validator: (
                                                                        value) {
                                                                      return value
                                                                          .isEmpty
                                                                          ? "Please fill this field"
                                                                          : null;
                                                                    },
                                                                    keyboardType: TextInputType.number,
                                                                    decoration: InputDecoration(
                                                                      labelText: 'systolic',

                                                                    ),
                                                                    style: TextStyle(
                                                                      color: Colors.grey.shade700,
                                                                    ),
                                                                  ),
                                                                ),

                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only( right: 16.0),
                                                                  child: TextFormField(
                                                                    onSaved: (value) {
                                                                      setState(() {_bloodPressure
                                                                            .diastolic = value;
                                                                      });
                                                                    },
                                                                    keyboardType: TextInputType.number,
                                                                    validator: (value) {
                                                                      return value
                                                                          .isEmpty
                                                                          ? "Please fill this field"
                                                                          : null;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                      labelText: 'diastolic',

                                                                    ),
                                                                    style: TextStyle(
                                                                      color: Colors.grey.shade700,
                                                                    ),
                                                                  ),
                                                                ),

                                                              ),
                                                              IconButton(
                                                                icon: Icon(
                                                                    (isPressed == true)
                                                                        ? Icons.done_outline
                                                                        : Icons.save,
                                                                    color: Colors.blue),
                                                                onPressed: () {
                                                                  if (_formKey.currentState
                                                                      .validate()) {
                                                                    _formKey
                                                                        .currentState
                                                                        .save();
                                                                    isPressed = true;
                                                                    saveVitals(
                                                                        _bloodPressure,
                                                                        'bloodPressure');
                                                                  }
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        Form(
                                                          key: _formKeyTemperature,
                                                          child: Row(
                                                            children: <Widget>[

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                                                                  child: Text(
                                                                    "Temperature",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.blue.shade600,
                                                                        fontSize: 16, fontWeight: FontWeight.w500),),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      right: 16.0),
                                                                  child: TextFormField(
                                                                    onSaved: (
                                                                        value) {
                                                                      _temperature.value = value;
                                                                    },
                                                                    validator: (
                                                                        value) {
                                                                      return value
                                                                          .isEmpty
                                                                          ? "Please fill this field"
                                                                          : null;
                                                                    },
                                                                    keyboardType: TextInputType.number,
                                                                    decoration: InputDecoration(
                                                                      labelText: 'temperature',

                                                                    ),
                                                                    style: TextStyle(
                                                                      color: Colors.grey.shade700,
                                                                    ),
                                                                  ),
                                                                ),


                                                              ),

                                                              IconButton(
                                                                icon: Icon(
                                                                    (isPressed1 == true)
                                                                        ? Icons.done_outline
                                                                        : Icons.save,
                                                                    color: Colors.blue),
                                                                onPressed: () {
                                                                  if (_formKeyTemperature
                                                                      .currentState
                                                                      .validate()) {
                                                                    _formKeyTemperature
                                                                        .currentState
                                                                        .save();
                                                                    isPressed1 = true;

                                                                    saveVitals( _temperature, 'temperature');
                                                                  }
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        Form(
                                                          key: _formKeyPulse,
                                                          child: Row(
                                                            children: <Widget>[

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                                                                  child: Text(
                                                                    "Pulse",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.blue.shade600,
                                                                        fontSize: 16, fontWeight: FontWeight.w500),),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      right: 16.0),
                                                                  child: TextFormField(
                                                                    keyboardType: TextInputType.number,
                                                                    onSaved: (value) {
                                                                      _pulse
                                                                          .value = value;
                                                                    },
                                                                    validator: (value) {
                                                                      return value
                                                                          .isEmpty
                                                                          ? "Please fill this field"
                                                                          : null;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                      labelText: 'pulse',

                                                                    ),
                                                                    style: TextStyle(
                                                                      color: Colors.grey.shade700,
                                                                    ),
                                                                  ),
                                                                ),


                                                              ),

                                                              IconButton(
                                                                icon: Icon(
                                                                    (isPressed2 ==
                                                                        true)
                                                                        ? Icons
                                                                        .done_outline
                                                                        : Icons
                                                                        .save,
                                                                    color: Colors.blue),
                                                                onPressed: () {
                                                                  if (_formKeyPulse
                                                                      .currentState
                                                                      .validate()) {
                                                                    _formKeyPulse
                                                                        .currentState
                                                                        .save();
                                                                    isPressed2 = true;

                                                                    saveVitals( _pulse, 'pulse');
                                                                  }
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        Form(
                                                          key: _formKeyRespiratoryRate,
                                                          child: Row(
                                                            children: <Widget>[

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                                                                  child: Text(
                                                                    "Respiratory Rate",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.blue.shade600,
                                                                        fontSize: 16, fontWeight: FontWeight.w500),),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      right: 16.0),
                                                                  child: TextFormField(
                                                                    keyboardType: TextInputType.number,
                                                                    onSaved: (
                                                                        value) {
                                                                      _respiratoryRate
                                                                          .value = value;
                                                                    },
                                                                    validator: (
                                                                        value) {
                                                                      return value
                                                                          .isEmpty
                                                                          ? "Please fill this field"
                                                                          : null;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                      labelText: 'rate',
                                                                    ),
                                                                    style: TextStyle(
                                                                      color: Colors.grey.shade700,
                                                                    ),
                                                                  ),
                                                                ),


                                                              ),

                                                              IconButton(
                                                                icon: Icon(
                                                                    (isPressed3 == true)
                                                                        ? Icons.done_outline
                                                                        : Icons.save,
                                                                    color: Colors.blue),
                                                                onPressed: () {
                                                                  if (_formKeyRespiratoryRate
                                                                      .currentState
                                                                      .validate()) {
                                                                    _formKeyRespiratoryRate
                                                                        .currentState
                                                                        .save();
                                                                    isPressed3 =
                                                                    true;
                                                                    saveVitals(
                                                                        _respiratoryRate,
                                                                        'respiratoryRate');
                                                                  }
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        Form(
                                                          key: _formKeyHeight,
                                                          child: Row(
                                                            children: <Widget>[

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                                                                  child: Text(
                                                                    "Height",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.blue.shade600,
                                                                        fontSize: 16, fontWeight: FontWeight.w500),),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(right: 16.0),
                                                                  child: TextFormField(
                                                                    keyboardType: TextInputType.number,
                                                                    onSaved: (
                                                                        value) {
                                                                      setState(() {
                                                                        _height.value =
                                                                            value; });
                                                                    },

                                                                    validator: (
                                                                        value) {
                                                                      return value
                                                                          .isEmpty
                                                                          ? "Please fill this field"
                                                                          : null;
                                                                    },

                                                                    decoration: InputDecoration(
                                                                      labelText: 'height',
                                                                    ),

                                                                    style: TextStyle(
                                                                      color: Colors.grey.shade700,
                                                                    ),
                                                                  ),
                                                                ),


                                                              ),

                                                              IconButton(
                                                                icon: Icon(
                                                                    (isPressed4 == true)
                                                                        ? Icons.done_outline
                                                                        : Icons.save,
                                                                    color: Colors.blue),
                                                                onPressed: () {
                                                                  if (_formKeyHeight
                                                                      .currentState
                                                                      .validate()) {
                                                                    _formKeyHeight
                                                                        .currentState
                                                                        .save();
                                                                    isPressed4 = true;
                                                                    saveVitals(
                                                                        _height,
                                                                        'height');
                                                                  }
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        Form(
                                                          key: _formKeyWeight,
                                                          child: Row(
                                                            children: <Widget>[

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 16.0, top: 20.0),
                                                                  child: Text(
                                                                    "Weight",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        color: Colors.blue.shade600,
                                                                        fontSize: 16, fontWeight: FontWeight.w500),),
                                                                ),
                                                              ),

                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(right: 16.0),
                                                                  child: TextFormField(
                                                                    onSaved: (value) {
                                                                      setState(() {
                                                                        _weight
                                                                            .value = value;
                                                                      });
                                                                    },
                                                                    validator: (
                                                                        value) {
                                                                      return value
                                                                          .isEmpty
                                                                          ? "Please fill this field"
                                                                          : null;
                                                                    },
                                                                    keyboardType: TextInputType.number,
                                                                    decoration: InputDecoration(
                                                                      labelText: 'weight',
                                                                    ),
                                                                    style: TextStyle(
                                                                      color: Colors.grey.shade700,
                                                                    ),
                                                                  ),
                                                                ),


                                                              ),

                                                              IconButton(
                                                                icon: Icon(
                                                                    (isPressed5 == true)
                                                                        ? Icons.done_outline
                                                                        : Icons.save,
                                                                    color: Colors.blue),
                                                                onPressed: () {
                                                                  if (_formKeyWeight
                                                                      .currentState
                                                                      .validate()) {
                                                                    _formKeyWeight
                                                                        .currentState
                                                                        .save();
                                                                    isPressed5 = true;
                                                                    saveVitals(
                                                                        _weight,
                                                                        'weight');
                                                                  }
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        ),


                                                      ],
                                                    )

                                                ),
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                              ,
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "VITALS",
          ),
          new RoundedButton(text: "HTS",
          ),
          new RoundedButton(text: "HomePage",
          ),
        ],
      ),
    );
  }




}


