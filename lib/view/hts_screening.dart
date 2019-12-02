import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/htsscreening.dart' ;
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/person.dart';

import 'package:ehr_mobile/view/hts_pretest_overview.dart';
import 'package:ehr_mobile/view/htsscreeningoverview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../sidebar.dart';
import 'edit_demographics.dart';
import 'hts_testscreening.dart';
import 'rounded_button.dart';

class Hts_Screening extends StatefulWidget {
  final String htsid ;
  final String personId;
  final HtsRegistration htsRegistration;
  final String visitId;
  final Person person;
  Hts_Screening(this.personId, this.htsid, this.htsRegistration, this.visitId, this.person);

  @override
  State createState() {
    return _HtsScreening();
  }
}

class _HtsScreening extends State<Hts_Screening> {
  static const platform = MethodChannel('example.channel.dev/people');

  static const htsChannel = MethodChannel(
      'zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  final _formKey = GlobalKey<FormState>();
  bool testedBefore;
  bool art;
  String result;
  DateTime dateLastTested;
  String artNumber;
  bool beenOnPrep;
  String prepOption;
  String viralLoadDone;
  String cd4Done;
  bool _testedbefore;
  bool _patientonart;
  bool first_patient_on_art;
  int _hts = 0;
  int _art = 0;
  int first_art = 0;
  int _prep = 0;
  int _result = 0;
  int _viralload = 0;
  int _cd4done = 0;
  var birthDate, displayDate;
  var selectedLastNegDate, selectedDateOfEnrollment, selectedDateOfViralLoad, selectedDateOfCd4Count, selectedDateOfLastTest;
  DateTime dateOfLastNeg, dateOfEnrollmentIntoCare, dateOfViralLoad, dateOfCd4Count, dateLastTest;
  HtsScreening htsScreening;


  @override
  void initState() {
    //getHtsRecord(widget.personId);
    selectedLastNegDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    selectedDateOfEnrollment = DateFormat("yyyy/MM/dd").format(DateTime.now());
    selectedDateOfViralLoad =  DateFormat("yyyy/MM/dd").format(DateTime.now());
    selectedDateOfCd4Count = DateFormat("yyyy/MM/dd").format(DateTime.now());
    selectedDateOfLastTest = DateFormat("yyyy/MM/dd").format(DateTime.now());

    dateOfLastNeg = DateTime.now();
    dateOfViralLoad = DateTime.now();
    dateOfEnrollmentIntoCare = DateTime.now();
    dateOfCd4Count = DateTime.now();
    dateLastTest = DateTime.now();
    super.initState();
  }

  Future<void> savehtsscreening(HtsScreening htsScreening) async {
    var response;
    try {
      response = await htsChannel.invokeMethod('saveHtsScreening', jsonEncode(htsScreening));
      setState(() {
        gethtsscreening(widget.personId);

      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<void> gethtsscreening(String personId) async {
    var response;
    try {
      response = await htsChannel.invokeMethod('getHtsScreening', widget.personId);
      setState(() {
        htsScreening = HtsScreening.fromJson(jsonDecode(response));
      });
    } catch (e) {
      print("channel failure getting hts screen record: '$e'");
    }

  }

  Future<Null> _selectNegTestDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedLastNegDate)
      setState(() {
        selectedLastNegDate = DateFormat("yyyy/MM/dd").format(picked);
        dateOfLastNeg = DateFormat("yyyy/MM/dd").parse(selectedLastNegDate);
      });
  }
  Future<Null> _selectDateLastTest(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateOfLastTest)
      setState(() {
        selectedDateOfLastTest = DateFormat("yyyy/MM/dd").format(picked);
        dateLastTest = DateFormat("yyyy/MM/dd").parse(selectedDateOfLastTest);
      });
  }
  Future<Null> _selectDateOfEnrollment(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateOfEnrollment)
      setState(() {
        selectedDateOfEnrollment = DateFormat("yyyy/MM/dd").format(picked);
        dateOfEnrollmentIntoCare = DateFormat("yyyy/MM/dd").parse(selectedDateOfEnrollment);
      });
  }

  Future<Null> _selectDateOfViralLoad(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateOfViralLoad)
      setState(() {
        selectedDateOfViralLoad = DateFormat("yyyy/MM/dd").format(picked);
        dateOfViralLoad = DateFormat("yyyy/MM/dd").parse(selectedDateOfViralLoad);
      });
  }
  Future<Null> _selectDateOfCD4Count(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateOfCd4Count)
      setState(() {
        selectedDateOfCd4Count = DateFormat("yyyy/MM/dd").format(picked);
        dateOfCd4Count = DateFormat("yyyy/MM/dd").parse(selectedDateOfCd4Count);
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsid),
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
                  top: MediaQuery
                      .of(context)
                      .padding
                      .top + 40.0),
              child: new Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("HTS Screening", style: TextStyle(
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
                              child: Text(widget.person.firstName + " " + widget.person.lastName, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.verified_user, size: 25.0, color: Colors.white,),
                            ),
                          ])
                  ),
               //   _buildButtonsRow(),
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
                                //  _buildTabBar(),
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
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .spaceEvenly,
                                                children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(8.0),
                                                              child: Text(
                                                                  'Have you ever been tested before ?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _hts,
                                                            onChanged: _handleHtsChange),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _hts,
                                                            onChanged: _handleHtsChange)
                                                      ],
                                                    ),
                                                  ),
                                                  _testedbefore == true ? Container(
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
                                                                    selectedDateOfLastTest),
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
                                                                        BorderRadius
                                                                            .circular(
                                                                            0.0)),
                                                                    labelText: "Date of last HIV test"),
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
                                                              _selectDateLastTest(
                                                                  context);
                                                            })
                                                      ],
                                                    ),
                                                  ): SizedBox(height: 0.0,),
                                                  SizedBox(height: 10.0,),
                                                  _testedbefore == true? Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(8.0),
                                                              child: Text(
                                                                  'Result when you were tested ?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('Positive'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _result,
                                                            onChanged: _handleResultChange),
                                                        Text('Negative'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _result,
                                                            onChanged: _handleResultChange),
                                                        Text('Inconclusive'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue: _result,
                                                            onChanged: _handleResultChange)
                                                      ],
                                                    ),
                                                  ): SizedBox(height: 0.0,),
                                                  result == 'POSITIVE' || result == 'Positive'? Container(
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
                                                                    selectedLastNegDate),
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
                                                                        BorderRadius
                                                                            .circular(
                                                                            0.0)),
                                                                    labelText: "Date of Last Negative HIV Test"),
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
                                                              _selectNegTestDate(
                                                                  context);
                                                            })
                                                      ],
                                                    ),
                                                  ): SizedBox(height: 0.0,),
                                                  result == 'POSITIVE' || result == 'Positive'?Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(8.0),
                                                              child: Text(
                                                                  'Are you on ART ?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: first_art,
                                                            onChanged: _handlefirstArtChange),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: first_art,
                                                            onChanged: _handlefirstArtChange)
                                                      ],
                                                    ),
                                                  ): SizedBox(height: 0.0),
                                                  first_patient_on_art == true?  Row(
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
                                                                        artNumber =
                                                                            value;
                                                                      }),
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
                                                  ): SizedBox(height: 0.0,),
                                                  first_patient_on_art == true? Container(
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
                                                                    selectedDateOfEnrollment),
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
                                                                        BorderRadius
                                                                            .circular(
                                                                            0.0)),
                                                                    labelText: "Date of enrollment into care"),
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
                                                  ): SizedBox(height: 0.0,),
                                                  result == 'POSITIVE' || result == 'Positive'? Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(8.0),
                                                              child: Text(
                                                                  'Viral Load done?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _viralload,
                                                            onChanged: _handleViralLoadDone),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _viralload,
                                                            onChanged: _handleViralLoadDone),
                                                        Text('UNKNOWN'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue: _viralload,
                                                            onChanged: _handleViralLoadDone)
                                                      ],
                                                    ),
                                                  ): SizedBox(height: 10.0,),
                                                  viralLoadDone == 'DONE'? Container(
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
                                                                    selectedDateOfViralLoad),
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
                                                                        BorderRadius
                                                                            .circular(
                                                                            0.0)),
                                                                    labelText: "Date of Viral Load Count"),
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
                                                              _selectDateOfViralLoad(
                                                                  context);
                                                            })
                                                      ],
                                                    ),
                                                  ): SizedBox(height: 0.0,),
                                                  viralLoadDone == 'DONE'?  Row(
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
                                                                    ? 'Enter Viral Load Count'
                                                                    : null;
                                                              },
                                                              onSaved:
                                                                  (value) =>
                                                                  setState(
                                                                          () {
                                                                        artNumber =
                                                                            value;
                                                                      }),
                                                              decoration: InputDecoration(
                                                                  labelText:
                                                                  'Viral Load',
                                                                  border:
                                                                  OutlineInputBorder()),
                                                            ),
                                                          ),
                                                          width: 100,
                                                        ),
                                                      ),
                                                    ],
                                                  ): SizedBox(height: 0.0,),
                                                  result == "POSITIVE" || result == 'Positive'?Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(8.0),
                                                              child: Text(
                                                                  'Cd4 count done?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _cd4done,
                                                            onChanged: _handleCd4Done),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _cd4done,
                                                            onChanged: _handleCd4Done),
                                                        Text('UNKNOWN'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue: _cd4done,
                                                            onChanged: _handleCd4Done)
                                                      ],
                                                    ),
                                                  ): SizedBox(height: 10.0,),
                                                  cd4Done == 'DONE'? Container(
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
                                                                    selectedDateOfCd4Count),
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
                                                                        BorderRadius
                                                                            .circular(
                                                                            0.0)),
                                                                    labelText: "Date of CD4 Count"),
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
                                                              _selectDateOfCD4Count(
                                                                  context);
                                                            })
                                                      ],
                                                    ),
                                                  ): SizedBox(height: 0.0,),
                                                  cd4Done == 'DONE'?  Row(
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
                                                                    ? 'Enter CD4 Count'
                                                                    : null;
                                                              },
                                                              onSaved:
                                                                  (value) =>
                                                                  setState(
                                                                          () {
                                                                        artNumber =
                                                                            value;
                                                                      }),
                                                              decoration: InputDecoration(
                                                                  labelText:
                                                                  'CD4 Count',
                                                                  border:
                                                                  OutlineInputBorder()),
                                                            ),
                                                          ),
                                                          width: 100,
                                                        ),
                                                      ),
                                                    ],
                                                  ): SizedBox(height: 0.0,),

                                                   Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .all(8.0),
                                                              child: Text(
                                                                  'Have you ever been exposed to ARVs ?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _art,
                                                            onChanged: _handleArtChange),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _art,
                                                            onChanged: _handleArtChange)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical: 0.0,
                                                        horizontal: 30.0),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius
                                                              .circular(5.0)),
                                                      color: Colors.blue,
                                                      padding: const EdgeInsets
                                                          .all(20.0),
                                                      child: Text(
                                                        "Save",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ),
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          _formKey.currentState
                                                              .save();
                                                          HtsScreening htsscreening = new HtsScreening(widget.personId, widget.visitId, _testedbefore, first_patient_on_art, result,dateLastTest, dateOfLastNeg, dateOfEnrollmentIntoCare, artNumber, beenOnPrep, prepOption, viralLoadDone, dateOfViralLoad, cd4Done, dateOfCd4Count);
                                                          savehtsscreening(htsscreening);
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> HtsScreeningOverview(widget.person, htsscreening, widget.htsid, widget.visitId, widget.personId)));

                                                        }
                                                      },
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

  void _handleHtsChange(int value) {
    setState(() {
      _hts = value;

      switch (_hts) {
        case 1:
          _testedbefore = true;
          break;
        case 2:
          _testedbefore = false;
          break;
      }
    });
  }

  void _handleArtChange(int value) {
    setState(() {
      _art = value;

      switch (_art) {
        case 1:
          _patientonart = true;
          break;
        case 2:
          _patientonart = false;
          break;
      }
    });
  }

  void _handlefirstArtChange(int value) {
    setState(() {
      first_art = value;

      switch (first_art) {
        case 1:
          first_patient_on_art = true;
          break;
        case 2:
          first_patient_on_art = false;
          break;
      }
    });
  }

  void _handlePrepchange(int value) {
    setState(() {
      _prep = value;

      switch (_prep) {
        case 1:
          beenOnPrep = true;
          break;
        case 2:
          beenOnPrep = false;
          break;
      }
    });
  }

  void _handleViralLoadDone(int value) {
    setState(() {
      _viralload = value;

      switch (_viralload) {
        case 1:
          viralLoadDone = 'DONE';
          break;
        case 2:
          viralLoadDone = 'NOT_DONE';
          break;
        case 3:
          viralLoadDone = 'UNKNOWN';
      }
    });
  }

  void _handleCd4Done(int value) {
    setState(() {
      _cd4done = value;

      switch (_cd4done) {
        case 1:
          cd4Done = 'DONE';
          break;
        case 2:
          cd4Done = 'NOT_DONE';
          break;
        case 3:
          cd4Done = 'UNKNOWN';
          break;
      }
    });
  }

  void _handleResultChange(int value) {
    setState(() {
      _result = value;

      switch (_result) {
        case 1:
          result = 'POSITIVE';
          break;

        case 2:
          result = 'NEGATIVE';
          break;
        case 3:
          result = 'INCONCLUSIVE';
          break;
      }
    });
  }


}
