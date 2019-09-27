import 'dart:convert';

import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/hts_testscreening.dart';
import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'rounded_button.dart';

import 'package:flutter/cupertino.dart';
import 'dart:async';


class Hts_Result extends StatefulWidget {
  String visitId;
  String patientId;
  String labInvetsTestId;
  Hts_Result();

  //Hts_Result (this.visitId, this.patientId);

  @override
  State createState() {
    return _Hts_Result ();
  }
}

class _Hts_Result  extends State<Hts_Result > {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  String visitId;
  String patientId;
  Person patient;
  var selectedDate;
  bool _showError = false;
  bool _entryPointIsValid = false;
  bool _formIsValid = false;
  String _entryPointError = "Select Entry Point";
  DateTime date;
  int _htsType = 0;
  String htsType = "";
  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  String hts_id;
  String testkit;
  String startTime;
  String endTime;
  bool showInput = true;
  bool showInputTabOptions = true;

  List<DropdownMenuItem<String>> _dropDownMenuItemsEntryPoint;
  List<LaboratoryInvestigationTest> _entryPointList = List();

  String _currentEntryPoint;

  @override
  void initState() {
    visitId = widget.visitId;
//    patient id
    patientId = widget.patientId;
    getFacilities();
    getLabInvestigationTests();
    //getTestKIt(widget.labInvetsTestId);
    //getStartTime(widget.labInvetsTestId);
    //getEndTime(widget.labInvetsTestId);

    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    super.initState();
  }

  Future<void> getFacilities() async {
    String response;
    try {
      response = await dataChannel.invokeMethod('getLabInvestigations');
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = EntryPoint.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
        print('################################### LIST OF INVESTIGATIONS'+ _entryPointList.toString());
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
        date = DateFormat("yyyy/MM/dd").parse(selectedDate);
      });
  }

  void _handleHtsTypeChange(int value) {
    print("hts value : $value");
    setState(() {
      _htsType = value;

      switch (_htsType) {
        case 1:
          htsType = "Self";
          print("hts value : $htsType");

          break;
        case 2:
          htsType = "Rapid";
          print("hts value : $htsType");

          break;
      }
    });
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
            title: new Text("HTS Patient Registration"),
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
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "Sample :",
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(0.0),
                                                                child: Text(
                                                                  ("Test"),
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "Investigation:",
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(0.0),
                                                                child: Text(
                                                                  ("HIV"),
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),





                                                    SizedBox(
                                                      height: 20.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                      child: DataTable(
                                                        columns: [
                                                          DataColumn(label: Text("TestKit")),
                                                          DataColumn(label: Text("Time")),
                                                          DataColumn(label: Text("Result"))],
                                                        rows: [
                                                          DataRow(cells: [
                                                            DataCell(Text('testkit')),
                                                            DataCell(Text('startTime')),
                                                            DataCell(Text('endTime')),]),
                                                          DataRow(cells: [DataCell(Text("TestKitEG2")),
                                                            DataCell(Text("DateTime2")),
                                                            DataCell(Text("ResultSet2")),
                                                          ]),],

                                                      ),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "Final Result:",
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(0.0),
                                                                child: Text(
                                                                  ("--"),
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),




                                                    SizedBox(
                                                      height: 30.0,
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
                                                          "Proceed",
                                                          style: TextStyle(color: Colors.white),
                                                        ),

                                                        onPressed: () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => Hts_Result()),),

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
            text: "HTS Registration",
          ),
          new RoundedButton(
            text: "HTS Pre-Testing",
        /*    onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPretest(widget.patientId, hts_id)),
            ),*/
          ),
          new RoundedButton(text: "Hts Result", selected: true,
          ),
        ],
      ),
    );
  }

  Future<void> registration(HtsRegistration htsRegistration) async {
    String id;
    print('*************************htsType ${htsRegistration.toString()}');
    try {
      id = await htsChannel.invokeMethod('htsRegistration', jsonEncode(htsRegistration));
      hts_id = id;

      String patientid = patientId.toString();
      DateTime date = htsRegistration.dateOfHivTest;
      PersonInvestigation personInvestigation = new PersonInvestigation(
          patientid, "36069471-adee-11e7-b30f-3372a2d8551e", date, null);
      await htsChannel.invokeMethod('htsRegistration',jsonEncode(personInvestigation));

      print('---------------------saved file id  $id');
    } catch (e) {
      print('--------------something went wrong  $e');
    }
  }

  Future<void> getLabInvestigationTests() async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getLabInvestigations');
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = LaboratoryInvestigationTest.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
        print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'+ _entryPointList.toString());
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  void changedDropDownItemEntryPoint(String selectedEntryPoint) {
    setState(() {
      _currentEntryPoint = selectedEntryPoint;
      _entryPointError = null;
      _entryPointIsValid = !_entryPointIsValid;
    });
  }
}








