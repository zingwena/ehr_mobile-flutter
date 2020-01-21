import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/sexualhistoryform.dart';
import 'package:ehr_mobile/view/hiv_services_index_contact_page.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/recency.dart';
import 'package:ehr_mobile/view/hts_screening.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/art_initiation.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/vitals/visit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';
import 'htsreg_overview.dart';
import 'rounded_button.dart';
import 'home_page.dart';

import 'hts_testscreening.dart';
import 'hts_registration.dart';

import 'reception_vitals.dart';
import 'package:ehr_mobile/model/artRegistration.dart';

class PostTestOverview extends StatefulWidget {
  final PostTest postTest;
  final String personId;
  final String visitId;
  final Person person;
  final String htsId;
  final bool consenttoIndex;
  final bool patient_aware_of_status;
  final bool patient_on_art;
  final String result;
  final HtsRegistration htsRegistration;

  PostTestOverview(this.postTest, this.personId, this.visitId, this.person,
      this.htsId, this.consenttoIndex, this.patient_aware_of_status, this.patient_on_art, this.result, this.htsRegistration);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostTestOverviewState();
  }
}

class PostTestOverviewState extends State<PostTestOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const artChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');

  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _entrypoint;

  bool showInput = true;
  bool showInputTabOptions = true;
  var dateOfTest;
  String indexTestId;
  String results_received;
  String post_test_counselled;
  String patient_aware_of_status;
  String patient_on_art_string;
  String consent_to_index_testing;

  String facility_name;

  @override
  void initState() {
    dateOfTest =
        DateFormat("yyyy/MM/dd").format(widget.postTest.datePostTestCounselled);
    print(_patient.toString());

    if(widget.postTest.postTestCounselled == true){
      post_test_counselled = 'YES';
    }else{
      post_test_counselled = 'NO';
    }
    if(widget.postTest.resultReceived == true){
      results_received = "YES";

    }else{
      results_received = "NO";
    }
    if(widget.patient_aware_of_status == true){
      patient_aware_of_status = "YES";
    }else{
      patient_aware_of_status = "NO";
    }
    if(widget.patient_on_art == true){
      patient_on_art_string = "YES";

    }else{
      patient_on_art_string = "NO";

    }

    if(widget.consenttoIndex == true){
      consent_to_index_testing = "YES";

    }else{
      consent_to_index_testing = "NO";
    }

  getFacilityName();
    super.initState();
  }


  Future<void> getEntryPoint(String entrypointId) async {
    String entrypoint;

    try {
      entrypoint = await htsChannel.invokeMethod('getEntrypoint', entrypointId);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _entrypoint = entrypoint;
    });
  }

  Future<void>getFacilityName()async{
    String response;
    try{
      response = await retrieveString(FACILITY_NAME);
      setState(() {
        facility_name = response;
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
  }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.personId, widget.visitId,
          widget.htsRegistration, widget.htsId),
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
            height: 220.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title:new Text(
              facility_name!=null?facility_name: 'Impilo Mobile',   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.person_pin,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            "admin",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                color: Colors.white),
                          ),
                        ),
                      ])),
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
                    child: Text(
                      "Post Test Overview",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                  ),

                  Container(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.person_outline,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            widget.person.firstName +
                                " " +
                                widget.person.lastName,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.verified_user,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        ),
                      ])),
                  //_buildButtonsRow(),
                  Expanded(
                    child: WillPopScope(
                      onWillPop: () {
                        if (!showInput) {
                          setState(() {
                            showInput = true;
                            showInputTabOptions = true;
                          });
                          return Future(() => false);
                        } else {
                          return Future(() => true);
                        }
                      },
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
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        16.0),
                                                            child: TextField(
                                                              controller:
                                                                  TextEditingController(
                                                                      text:
                                                                          dateOfTest),
                                                              decoration: InputDecoration(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      color: Colors
                                                                          .blue),
                                                                  labelText:
                                                                      "Date Post Counselled",
                                                                  hintText:
                                                                      "Date Post Counselled"),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: nullHandler(widget
                                                                      .postTest
                                                                      .finalResult)),
                                                              decoration: InputDecoration(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      color: Colors
                                                                          .blue),
                                                                  labelText:
                                                                      "Final Result",
                                                                  hintText:
                                                                      "Final Result"),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right:
                                                                16.0),
                                                            child: TextField(
                                                              controller:
                                                              TextEditingController(
                                                                  text:
                                                                  results_received),
                                                              decoration: InputDecoration(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      color: Colors
                                                                          .blue),
                                                                  labelText:
                                                                  "Results Received ?",
                                                                  hintText:
                                                                  "Results Received ?"),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right:
                                                                16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: nullHandler(post_test_counselled)),
                                                              decoration: InputDecoration(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      color: Colors
                                                                          .blue),
                                                                  labelText:
                                                                  "Post Test Counselled ?",
                                                                  hintText:
                                                                  "Post Test Counselled ?"),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right:
                                                                16.0),
                                                            child: TextField(
                                                              controller:
                                                              TextEditingController(
                                                                  text:
                                                                  patient_aware_of_status),
                                                              decoration: InputDecoration(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      color: Colors
                                                                          .blue),
                                                                  labelText:
                                                                  "Patient aware of their status ? ",
                                                                  hintText:
                                                                  "Patient aware of their status ?"),
                                                            ),
                                                          ),
                                                        ),
                                                        widget.postTest.finalResult == 'POSITIVE' ?Expanded(
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right:
                                                                16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: nullHandler(patient_on_art_string)),
                                                              decoration: InputDecoration(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      color: Colors
                                                                          .blue),
                                                                  labelText:
                                                                  "Is patient on ART ?",
                                                                  hintText:
                                                                  "Is patient on ART ? "),
                                                            ),
                                                          ),
                                                        ): SizedBox(height: 0.0, width: 0.0),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                       widget.consenttoIndex == true ? Expanded(
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right:
                                                                16.0),
                                                            child: TextField(
                                                              controller:
                                                              TextEditingController(
                                                                  text:
                                                                  consent_to_index_testing),
                                                              decoration: InputDecoration(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .date_range,
                                                                      color: Colors
                                                                          .blue),
                                                                  labelText:
                                                                  "Consent to index testing ? ",
                                                                  hintText:
                                                                  "Consent to index testing ? "),
                                                            ),
                                                          ),
                                                        ): SizedBox(height: 0.0, width: 0.0),

                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 25.0,
                                                    ),
                                                    SizedBox(
                                                      height: 25.0,
                                                    ),
                                                    SizedBox(
                                                      height: 25.0,
                                                    ),

                                                    _recencyTesting(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recencyTesting() {
    if (widget.result == 'POSITIVE' || widget.result == 'Positive') {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: RaisedButton(
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.blue,
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Recency Testing",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecencyTest(
                        widget.personId,
                        widget.visitId,
                        widget.person,
                        widget.htsId,
                        indexTestId,
                        widget.htsRegistration)));
          },
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: RaisedButton(
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.blue,
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Close ",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Overview(widget.person)));
          },
        ),
      );
    }
  }

  Widget _IndexButton() {
    if (widget.consenttoIndex == true) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: RaisedButton(
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          color: Colors.blue,
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Index Testing",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            IndexTest indexTest = IndexTest(
                widget.personId, widget.postTest.datePostTestCounselled);
            saveIndexTest(indexTest);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HIVServicesIndexContactList(
                        widget.person,
                        null,
                        widget.visitId,
                        widget.htsId,
                        null,
                        widget.personId,
                        indexTestId)));
          },
        ),
      );
    } else {
      return SizedBox(
        height: 10.0,
      );
    }
  }

  Future<void> saveIndexTest(IndexTest indexTest) async {
    var response;
    print(
        'GGGGGGGGGGGGGGGGGGGGGGGGG HERE IS THE INDEX ' + indexTest.toString());
    try {
      response =
          await htsChannel.invokeMethod('saveIndexTest', jsonEncode(indexTest));
      print('LLLLLLLLLLLLLLLLLLLLLLL hre is the indextest id' + response);
      setState(() {
        indexTestId = response;
      });
    } catch (e) {}
  }
}
