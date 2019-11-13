import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/model/artRegistration.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/hts_registration.dart';



import 'edit_demographics.dart';

class ArtReg extends StatefulWidget {
  String personId;
  String visitId;
  Person person;
  HtsRegistration htsRegistration;
  ArtReg(this.personId, this.visitId, this.person, this.htsRegistration);

  @override
  State createState() {
    return _ArtReg();
  }
}

class _ArtReg extends State<ArtReg> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final MethodChannel addPatient =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  String oi_art_number;
  ArtRegistration _artRegistration;
  var dateOfTest,dateOfEnrollment, displayDate;
  DateTime enrollment_date, test_date;
  String _nationalIdError = "National Id number is invalid";

  @override
  void initState() {
    displayDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfEnrollment = DateTime.now();
    dateOfTest = DateTime.now();
    super.initState();
  }

  Future<Null> _selectDateOfHivTest(BuildContext context) async {
    print('KKKKKKKKKKKKKKKKKKKK dat of hiv test picked');
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateOfTest)
      setState(() {
        dateOfTest = picked;
        displayDate = DateFormat("yyyy/MM/dd").format(picked);
      });
  }
  Future<Null> _selectDateOfEnrollment(BuildContext context) async {
    print('KKKKKKKKKKKKKKKKKKKK dat of enrollment picked');

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateOfEnrollment)
      setState(() {
        dateOfEnrollment = picked;
        displayDate = DateFormat("yyyy/MM/dd").format(picked);
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
                      ArtReg(widget.personId, widget.visitId, widget.person, widget.htsRegistration)),
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
            title: new Text("ART Registration"),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
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
                                                                    ? 'Enter Art Number'
                                                                    : null;
                                                              },
                                                              onSaved:
                                                                  (value) =>
                                                                  setState(
                                                                          () {
                                                                        oi_art_number = value;                                           }),
                                                              decoration: InputDecoration(
                                                                  labelText:
                                                                  'Art Number',
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
                                                  SizedBox(
                                                    height: 10.0,
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
                                                                labelText: "Date of HIV Test"),
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
                                                              _selectDateOfHivTest(
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
                                                                labelText: "Date of enrollment"),
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
                                                              _selectDateOfEnrollment(
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
                                                        "Register",
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
                                                          setState(() {
                                                            ArtRegistration artRegistrationDetails = ArtRegistration(widget.personId, dateOfEnrollment, dateOfTest, oi_art_number);
                                                            artRegistration(artRegistrationDetails);
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ArtRegOverview(artRegistrationDetails, widget.personId, widget.visitId, widget.person, widget.htsRegistration)));



                                                          });
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
            text: "ART Registration",
            selected: true,
          ),

          new RoundedButton(
            text: "ART Initiation",
          ),

          new RoundedButton(
            text: "Close",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPatient()),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> artRegistration(ArtRegistration artRegistration) async {
    String art_registration_response;
    try {
      print('pppppppppppppppppppppppppppppppppppp art regmethod');

      art_registration_response = await artChannel.invokeMethod(
          'saveArtRegistration', jsonEncode(artRegistration.toJson()));
      print('pppppppppppppppppppppppppppppppppppp art response'+ art_registration_response);
      setState(() {
        _artRegistration = ArtRegistration.fromJson(jsonDecode(art_registration_response));
        print('FFFFFFFFFFFFFFFFFFFFFFF'+ _artRegistration.toString());
      });

    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }
}
