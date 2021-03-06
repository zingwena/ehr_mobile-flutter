import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/view/edit_demographics_index.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../landing_screen.dart';
import 'edit_demographics_relation.dart';
import 'rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';

import 'edit_demographics.dart';

class AddPatientRelation extends StatefulWidget {
  String patient_personId;
  String visitId;
  String htsId;
  HtsRegistration htsRegistration;
  Person person;
  AddPatientRelation(this.patient_personId, this.visitId, this.htsId, this.htsRegistration, this.person);
  @override
  State createState() {
    return _AddPatient();
  }
}

class _AddPatient extends State<AddPatientRelation> {
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
            title: new Text("Impilo Mobile",   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ),

            ),
            actions: <Widget>[


              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
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

              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              icon: Icon(Icons.home), color: Colors.white,
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchPatient()),),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app), color: Colors.white,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LandingScreen()),),
                          ),
                        ),])
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
                    child: Text("Add New Patient Relation", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),

                  _buildButtonsRow(),
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
                                                            groupValue: _gender,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleGenderChange),
                                                        Text('Female'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _gender,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleGenderChange)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                    EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets .all(0.0),
                                                              child: TextFormField(
                                                                controller: TextEditingController(
                                                                    text: displayDate),
                                                                validator: (value) {
                                                                  return value
                                                                      .isEmpty
                                                                      ? 'Enter some text'
                                                                      : null;
                                                                },
                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        icon: Icon(Icons.calendar_today), color: Colors.blue,
                                                                        onPressed: () {_selectDate(context);}),
                                                                    labelText: 'Date of Birth',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 35.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 55.5),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(5.0)),
                                                      color: Colors.blue,
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text('Proceed to Demographics', style: TextStyle(color: Colors.white),),
                                                          Spacer(),
                                                          Icon(Icons.navigate_next, color: Colors.white, ),
                                                        ],
                                                      ),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          _formKey
                                                              .currentState
                                                              .save();

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
                                                                    builder: (context) => EditDemographicsRelation(
                                                                        lastName,
                                                                        firstName,
                                                                        birthDate,
                                                                        gender,
                                                                        nationalId, widget.patient_personId, widget.person, widget.visitId,
                                                                    widget.htsId, widget.htsRegistration)));
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
