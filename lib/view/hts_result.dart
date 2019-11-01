import 'dart:convert';

import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/hts_testing.dart';
import 'package:ehr_mobile/view/hts_testscreening.dart';
import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/search_patient.dart';
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
  String labInvestId;
  Person person;
  String htsId;

  Hts_Result(this.patientId, this.labInvetsTestId, this.visitId, this.labInvestId, this.person, this.htsId);

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
  String _visitId;
  String patientId;
  String labInvetsTestId;
  String result_string;
  HtsRegistration htsRegistration;
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
  String final_result = 'Pending';
  List<DropdownMenuItem<String>> _dropDownMenuItemsEntryPoint;
  List<LaboratoryInvestigationTest> _entryPointList = List();

  String _currentEntryPoint;

  @override
  void initState() {
    _visitId = widget.visitId;
//    patient id
    patientId = widget.patientId;
    labInvetsTestId = widget.labInvetsTestId;
    getFinalResult(widget.labInvestId);
    getFacilities();
   // getLabInvestigationTests();
    getTestKIt(widget.labInvetsTestId);
    getStartTime(widget.labInvetsTestId);
    getHtsRecord(widget.patientId);
    //getEndTime(widget.labInvetsTestId);


    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    super.initState();
  }

  Future<void> getFacilities() async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getLabInvestigations', widget.visitId);
      setState(() {
        {
          _entryPoint = response;
          entryPoints = jsonDecode(_entryPoint);
          _dropDownListEntryPoints = LaboratoryInvestigationTest.mapFromJson(entryPoints);
          _dropDownListEntryPoints.forEach((e) {
            _entryPointList.add(e);
          });
        }
      });
      print("HERE IS THE LIST OF LAB INVESTIGATIONS"+ _entryPointList.toString());

    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }
/*  Future<void> getResultName() async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getLabInvestigations', widget.visitId);
      setState(() {
        {
          _entryPoint = response;
          entryPoints = jsonDecode(_entryPoint);
          _dropDownListEntryPoints = LaboratoryInvestigationTest.mapFromJson(entryPoints);
          _dropDownListEntryPoints.forEach((e) {
            _entryPointList.add(e);
          });
        }
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }*/



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
      drawer:  new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("admin"), accountEmail: new Text("admin@gmail.com"), currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage('images/mhc.png'))),
            new ListTile(leading: new Icon(Icons.home, color: Colors.blue), title: new Text("Home "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchPatient()),
            )),
              new ListTile(leading: new Icon(Icons.person, color: Colors.blue), title: new Text("Patient Overview "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Overview(widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue),title: new Text(" Vitals",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(widget.patientId, widget.visitId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue),title: new Text("HTS",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)),   onTap: () {
              if(htsRegistration == null ){
                print('bbbbbbbbbbbbbb htsreg null in side bar  ');
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>  Registration(widget.visitId, widget.patientId, widget.person)
                ));
              } else {
                print('bbbbbbbbbbbbbb htsreg  not null in side bar ');

                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=> HtsRegOverview(htsRegistration, widget.patientId, widget.htsId, widget.visitId, widget.person)
                ));
              }
            }),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("ART",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArtReg(widget.patientId, widget.visitId, widget.person)),
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
            title: new Column(children: <Widget>[
              new Text("HTS Test Results"),
              new Text("Patient Name : " + " "+ widget.person.firstName + " " + widget.person.lastName)

            ],)
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
                                                                  ("Blood"),
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
                                                          DataColumn(label: Text("Result")),
                                                          DataColumn(label: Text("Start Time")),
                                                          DataColumn(label: Text("End Time"))],
                                                      rows: _entryPointList.map((labinvesttest)=>
                                                       DataRow(
                                                           cells: [
                                                       DataCell(Text(labinvesttest.testkitId)),
                                                       DataCell(Text(labinvesttest.result.name)),
                                                       DataCell(Text(labinvesttest.startTime)),
                                                       DataCell(Text(labinvesttest.endTime))])

                                                      ).toList()


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
                                                                  (final_result),
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
                                                          onPressed: () async {
                                                            if (final_result == 'Pending' || final_result == '') {
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HtsScreeningTest(widget.patientId, widget.visitId, widget.person, widget.htsId)));

                                                            }else{
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientPostTest(this.final_result, this.patientId, this._visitId, widget.person, widget.htsId)));


                                                            }
                                                          }
/*
                                                        onPressed: () =>
                                                            Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Hts_Result()),),*/

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

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
         // Image.asset('assets/macbook.jpg'),
          Text('Hie', style: TextStyle(color: Colors.deepPurple))
        ],
      ),
    );
  }
  @override
  Widget buildlistview(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: _entryPointList.length,
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
  Future<void> getTestKIt(labInvestId) async {
    String testkitId;
    try {
      testkitId = await htsChannel.invokeMethod('getTestKit',labInvestId);
     print('TEST KIT HERE '+ testkit);
    } catch (e) {
      print('--------------something went wrong  $e');
    }
    setState(() {
      testkit = testkitId;
    });
  }
  Future<void> getFinalResult(labInvestId) async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getFinalResult',labInvestId);
      print('Final Result here >>>>>>>>>> '+ response);
    } catch (e) {
      print('--------------something went wrong  $e');
    }
    setState(() {
      if(response == null){
        final_result = '';
      } else{

        final_result = response;

      }
    });
  }
  Future<void> getStartTime(labInvestId) async {
    String starttime;
    try {
      starttime = await htsChannel.invokeMethod('getStartTime',labInvestId);
      print('start time HERE '+ starttime);
    } catch (e) {
      print('--------------something went wrong  $e');
    }
    setState(() {
      startTime = starttime;
    });
  }
  Future<void> getEndTime(labInvestId) async {
    String endtime;
    try {
      endtime = await htsChannel.invokeMethod('getStartTime',labInvestId);
      print('start time HERE '+ endtime);
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








