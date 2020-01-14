import 'dart:convert';

import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/model/relationship.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/hts_testscreening.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/art_reg.dart';

import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/relationship_listPage.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';
import 'sexualhistoryform.dart';
import 'rounded_button.dart';

class AddRelationshipPage extends StatefulWidget {
  Person person_patient;
  String visitId;
  String patientId;
  Person person_relative;
  HtsRegistration htsRegistration;
  String htsId;
  AddRelationshipPage(this.person_patient, this.visitId, this.patientId, this.person_relative, this.htsId, this.htsRegistration);

  @override
  State createState() {
    return _AddRelationsState();
  }
}

class _AddRelationsState extends State<AddRelationshipPage> {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const patient_channel = MethodChannel('ehr_mobile.channel/patient');

  String visitId;
  String patientId;
  Person patient;
  var selectedDate;
  bool _showError = false;
  bool _relationIsValid = false;
  bool _formIsValid = false;
  String _relationError = "Select Entry Point";
  DateTime date;
  int _nextofkin = 0;
  String nextOfKin = "";
  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  String hts_id;
  String relationship_id;
  HtsRegistration htsRegistration;
  bool showInput = true;
  bool showInputTabOptions = true;
  List<DropdownMenuItem<String>> _dropDownMenuItemsRelations;
  HtsRegistration _htsRegistration;
  List _relations = [
    "CHILD",
    "SPOUSE",
    "PARENT",
    "OTHER",
  ];

  String _currentRelation;

  @override
  void initState() {
    visitId = widget.visitId;
//    patient id
    patientId = widget.patientId;
    getHtsRecord(patientId);
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    _dropDownMenuItemsRelations =
        getDropDownMenuItemsRelations();
    super.initState();
  }

  void _handleNextOfKinChange(int value) {
    setState(() {
      _nextofkin = value;

      switch (_nextofkin) {
        case 1:
          nextOfKin = "PRIMARY";
          break;
        case 2:
          nextOfKin = "SECONDARY";
          break;
      }
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsRelations() {
    List<DropdownMenuItem<String>> items = new List();
    for (String relation in _relations) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: relation, child: Text(relation)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer:   Sidebar(widget.person_patient, widget.patientId, widget.visitId, htsRegistration, hts_id),

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
                    child: Text("Add Relation", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),

                  Container(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person_outline, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(widget.person_patient.firstName + " " + widget.person_patient.lastName, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.verified_user, size: 25.0, color: Colors.white,),
                            ),
                          ])
                  ),
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
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 40.0,
                                                  ),
                                                  Container(
                                                    padding:
                                                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                    width: double.infinity,
                                                    child: OutlineButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5.0)),
                                                      color: Colors.white,
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 8.0, horizontal: 30.0),
                                                        child: DropdownButton(
                                                          isExpanded:true,
                                                          hint: Text('Relation'),
                                                          icon: Icon(Icons.keyboard_arrow_down),
                                                          iconEnabledColor: Colors.black,
                                                          value: _currentRelation,
                                                          items: _dropDownMenuItemsRelations,
                                                          onChanged: changedDropDownItemEntryPoint,
                                                        ),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue, //Color of the border
                                                        style: BorderStyle.solid, //Style of the border
                                                        width: 2.0, //width of the border
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                  !_showError
                                                      ? SizedBox.shrink()
                                                      : Text( _relationError ?? "",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:     Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(30.0),
                                                              child: Text('Next of kin ?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _nextofkin,
                                                            onChanged: _handleNextOfKinChange),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _nextofkin,
                                                            onChanged: _handleNextOfKinChange)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5.0)),
                                                      color: Colors.blue,
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Text(
                                                        "Save",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      onPressed: () async {
                                                        if (_formKey.currentState.validate()) {
                                                          _formKey.currentState.save();
                                                          if (_relationIsValid) {
                                                            setState(() {
                                                              _formIsValid = true;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              _showError = true;
                                                            });
                                                          }
                                                          if (_formIsValid) {
                                                            Relationship relationship = Relationship(widget.person_patient.id, widget.person_relative.id, _currentRelation, nextOfKin);
                                                            saveRelationship(relationship);
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RelationshipListPage(widget.person_patient, widget.visitId, widget.htsId, widget.htsRegistration, widget.person_patient.id)));

                                                          }
                                                        }
                                                      },
                                                    ),
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
            text: "HTS Registration",selected: true,
          ),
          new RoundedButton(
            text: "HTS Pre-Testing",
            /* onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPretest(widget.patientId, hts_id)),
            ),*/
          ),
          new RoundedButton(text: "HTS Testing",
          ),
        ],
      ),
    );
  }

  Future<void> saveRelationship(Relationship relationship) async {
    String _relationship_id;
    try {
      _relationship_id = await patient_channel.invokeMethod('saveRelationship', jsonEncode(relationship));
      setState(() {
        relationship_id = _relationship_id;
      });

    } catch (e) {
      print('--------------something went wrong  $e');
    }
  }

  Future<void> getHtsRecord(String patientId) async {
    var  hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {

      htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
      print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());

    });


  }

  void changedDropDownItemEntryPoint(String selectedEntryPoint) {
    setState(() {
      _currentRelation = selectedEntryPoint;
      _relationError = null;
      _relationIsValid = !_relationIsValid;
    });
  }
}
