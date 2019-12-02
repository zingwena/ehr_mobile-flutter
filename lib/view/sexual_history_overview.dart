import 'dart:convert';
import 'package:ehr_mobile/model/CbsQuestions.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/sexualhistory.dart';
import 'package:ehr_mobile/model/sexualhistoryview.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/view/sexual_history_qn.dart';
import 'package:ehr_mobile/vitals/visit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';
import 'art_reg.dart';
import 'rounded_button.dart';
import 'home_page.dart';

import 'hts_testscreening.dart';
import 'hts_registration.dart';

import 'reception_vitals.dart';
import 'package:ehr_mobile/model/address.dart';

class SexualHistoryOverview extends StatefulWidget {
  final Person patient;
  final CbsQuestion cbsQuestion;
  final String htsId;
  final String visitId;
  final String personId;

  SexualHistoryOverview(this.patient, this.cbsQuestion, this.htsId, this.visitId, this.personId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CbsOverview();
  }
}

class _CbsOverview extends State<SexualHistoryOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static final MethodChannel patientChannel = MethodChannel(
      'zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _maritalStatus,_educationLevel,_occupation,_nationality, _address, _phonenumber;
  HtsRegistration htsRegistration;
  String htsId;
  bool showInput = true;
  bool showInputTabOptions = true;
  String visitId;
  String sexuallyactive;
  String victimofsexualause;
  String sexwithmale;
  String sexwithfemale;
  String unprotectedsex;
  String sexwithsexworker;
  String exchangedsexformoney;
  String injectedrecreationaldrugs;
  String beencaredintojail;
  String historyofsti;
  String receivedbloodtrans;
  String unsterilisedinstruments;

  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  List<SexualHistoryView> _entryPointList = List();
  @override
  void initState() {
    _patient = widget.patient;
    getVisit(_patient.id);
    getHtsRecord(_patient.id);
    getSexualHistoryViews(widget.personId);
    print(_patient.toString());
    //getDetails(_patient.maritalStatusId,_patient.educationLevelId,_patient.occupationId,_patient.nationalityId, _patient.id);
    super.initState();
  }

  Future<void> getVisit(String patientId) async {
    String visit;

    try {
      visit =
      await platform.invokeMethod('visit', patientId);

    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      visitId = visit;
    });


  }
  Future<void> getHtsRecord(String patientId) async {
    var  hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      setState(() {

        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
        print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());

      });
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
    } catch (e) {
      print("channel failure: '$e'");
    }



  }
  Future<void> getHtsId(String patientId) async {
    var hts;

    try {
      hts = await htsChannel.invokeMethod('getHtsId', patientId);
      setState(() {
        htsId = hts;
      });

    } catch (e) {
      print("channel failure: '$e'");
    }


  }

  Future<void> getSexualHistoryViews(String patientId) async {
    String response;
    try {
      response =
      await htsChannel.invokeMethod('getSexualHistoryViews', patientId);
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = SexualHistoryView.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
        print("Sexual hitsory list returned in Overview ######################^^^^^^^^^^^^^.>>>>>>>>>>>>>>>>>>>" +
            _entryPointList.toString());
      });
    } catch (e) {
      print("Exception thrown in getsexualhistory view method" + e);
    }
  }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Sidebar(widget.patient, widget.personId, widget.visitId, htsRegistration, widget.htsId),
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
                    child: Text("Sexual History Overview", style: TextStyle(
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
                              child: Text(widget.patient.firstName + " " + widget.patient.lastName, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.verified_user, size: 25.0, color: Colors.white,),
                            ),
                          ])
                  ),
                  Expanded(child: WillPopScope(
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
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      getQuestions(_entryPointList, '', widget.personId)

                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                            ],
                                          )

                                      ),
                                    ),
                                  ),
                                )
                              ]
                              ,
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

  Widget getQuestions(List<SexualHistoryView> sexualhistoryviews, String sexualHistoryId, String personId) {

    return new Column(
        children: sexualhistoryviews
            .map(
                (item) => SexualHistoryQuestionView(item, sexualHistoryId, personId, false)
        )
            .toList());
  }

}






