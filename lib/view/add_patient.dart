import 'dart:convert';

import 'package:ehr_mobile/model/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';

import 'edit_demographics.dart';

class AddPatient extends StatefulWidget {
  @override
  State createState() {
    return _AddPatient();
  }
}

class _AddPatient extends State<AddPatient> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final MethodChannel addPatient =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  String lastName, firstName, nationalId, nationalIdNumber;

  var birthDate, displayDate;
  bool showError = false;
  int _gender = 0;
  String gender = "";
  String _identifier;
  List<DropdownMenuItem<String>> _identifierDropdownMenuItem;
  List _identifierList = [
    "Select Identifier",
    "Passport",
    "Birth Certificate",
    "National Id",
    "Driver's Licence"
  ];
  String _nationalIdError = "National Id number is invalid";

  @override
  void initState() {
    displayDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    birthDate = DateTime.now();

    _identifierDropdownMenuItem = getIdentifierDropdownMenuItems();
    _identifier = _identifierDropdownMenuItem[0].value;
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
        displayDate = DateFormat("yyyy/MM/dd").format(picked);
      });
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

  List<DropdownMenuItem<String>> getIdentifierDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String identifier in _identifierList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: identifier, child: Text(identifier)));
    }
    return items;
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
<<<<<<< HEAD
<<<<<<< HEAD
            title: new Text("Impilo Mobile",   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
<<<<<<< HEAD
=======
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
>>>>>>> 507c6527e093e614d968a933c189ddd693e5b403
=======
            title: new Text("Add New Patient"),
>>>>>>> parent of 507c652... UI Update 11/11/2019
=======
            title: new Text("Add New Patient"),
>>>>>>> parent of 507c652... UI Update 11/11/2019
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
<<<<<<< HEAD
<<<<<<< HEAD
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Add New Patient", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
<<<<<<< HEAD
                   _buildButtonsRow(),
=======
                  // _buildButtonsRow(),
>>>>>>> 507c6527e093e614d968a933c189ddd693e5b403
=======
                   _buildButtonsRow(),
>>>>>>> parent of 507c652... UI Update 11/11/2019
=======
                   _buildButtonsRow(),
>>>>>>> parent of 507c652... UI Update 11/11/2019
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
                                  //   _buildTabBar(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: new ConstrainedBox(
                                        constraints: new BoxConstraints(
                                          minHeight:
                                              viewportConstraints.maxHeight -
                                                  48.0,
                                        ),
                                        child: new IntrinsicHeight(
                                          child: Column(
                                            children: <Widget>[
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          16.0,
                                                                      horizontal:
                                                                          60.0),
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  return value
                                                                          .isEmpty
                                                                      ? 'Enter National Id number'
                                                                      : null;
                                                                },
                                                                onSaved:
                                                                    (value) =>
                                                                        setState(
                                                                            () {
                                                                  nationalId =
                                                                      value;
                                                                }),
                                                                decoration: InputDecoration(
                                                                    labelText: _identifier ==
                                                                            "Select Identifier"
                                                                        ? "ID Number e.g 22-345276T67"
                                                                        : _identifier +
                                                                            " Number",
                                                                    border:
                                                                        OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    !showError
                                                        ? SizedBox.shrink()
                                                        : Text(
                                                            _nationalIdError ??
                                                                "",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          16.0,
                                                                      horizontal:
                                                                          60.0),
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  return value
                                                                          .isEmpty
                                                                      ? 'Enter Last Name'
                                                                      : null;
                                                                },
                                                                onSaved:
                                                                    (value) =>
                                                                        setState(
                                                                            () {
                                                                  lastName = value;                                           }),
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                        'Last Name',
                                                                    border:
                                                                        OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
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
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          16.0,
                                                                      horizontal:
                                                                          60.0),
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  return value
                                                                          .isEmpty
                                                                      ? 'Enter First Name'
                                                                      : null;
                                                                },
                                                                onSaved:
                                                                    (value) =>
                                                                        setState(
                                                                            () {
                                                                  firstName =
                                                                      value;
                                                                }),
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                        'First Name',
                                                                    border:
                                                                        OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 16.0,
                                                              horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Text('Sex'),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('Male'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue:
                                                                  _gender,
                                                              activeColor:
                                                                  Colors.blue,
                                                              onChanged:
                                                                  _handleGenderChange),
                                                          Text('Female'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue:
                                                                  _gender,
                                                              activeColor:
                                                                  Colors.blue,
                                                              onChanged:
                                                                  _handleGenderChange)
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 16.0,
                                                              horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        0.0),
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      TextEditingController(
                                                                          text:
                                                                              displayDate),
                                                                  validator:
                                                                      (value) {
                                                                    return value
                                                                            .isEmpty
                                                                        ? 'Enter some text'
                                                                        : null;
                                                                  },
                                                                  decoration: InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(0.0)),
                                                                  labelText: "Date of birth"),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                          IconButton(
                                                              icon: Icon(Icons
                                                                  .calendar_today),
                                                              color:
                                                                  Colors.blue,
                                                              onPressed: () {
                                                                _selectDate(
                                                                    context);
                                                              })
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 35.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0 ),
                                                      child: RaisedButton(
                                                        elevation: 4.0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(5.0)),
                                                        color: Colors.blue,
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: Text(
                                                          "Register Patient",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                        onPressed: () async {
                                                          if (_formKey
                                                              .currentState
                                                              .validate()) {
                                                            _formKey
                                                                .currentState
                                                                .save();

//                           Patient patient= Patient.basic(nationalId, firstName, lastName, gender);
//                           await registerPatient(patient);
                                                            setState(() {
                                                              nationalIdNumber =
                                                                  nationalId.replaceAll(
                                                                      new RegExp(
                                                                          r'[^\w\s]+'),
                                                                      '');
                                                            });
                                                            RegExp regex =
                                                                new RegExp(
                                                                    r'((\d{8,10})([a-zA-Z])(\d{2})\b)');
                                                            if (regex.hasMatch(
                                                                nationalIdNumber)) {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => EditDemographics(
                                                                          lastName,
                                                                          firstName,
                                                                          birthDate,
                                                                          gender,
                                                                          nationalId)));
                                                            } else {
                                                              showError = true;
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 25.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "Add Patient",
            selected: true,
          ),

          new RoundedButton(
            text: "Continue Registration",
          ),

          new RoundedButton(
            text: "Close",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> registerPatient(Person person) async {
    String response;
    try {
      String jsonPatient = jsonEncode(person);
      response = await addPatient.invokeMethod('registerPatient', jsonPatient);
    } catch (e) {
      print('Something went wrong...... cause $e');
    }
  }
}
