import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/vitals/visit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';


import 'art_registration.dart';
import 'art_registration.dart';
import 'rounded_button.dart';
import 'home_page.dart';

import 'hts_testscreening.dart';
import 'hts_registration.dart';

import 'reception_vitals.dart';
import 'package:ehr_mobile/model/address.dart';

class PretestOverview extends StatefulWidget {
  final PreTest preTest;
 final HtsRegistration htsRegistration;
 final String htsId ;
 final String personId;
 final String visitId;
  PretestOverview(this.preTest, this.htsRegistration, this.personId, this.htsId, this.visitId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PretestOverviewState();
  }
}

class PretestOverviewState extends State<PretestOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static final MethodChannel patientChannel = MethodChannel(
      'zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  Person _patient;
  Visit _visit;
  HtsRegistration _htsRegistration;
  Map<String, dynamic> details;
  String _maritalStatus,_educationLevel,_occupation,_nationality, _address, _phonenumber;

  bool showInput = true;
  bool showInputTabOptions = true;
  String visitId="1";
  String htsApproach;
  String _htsModelId;
  bool newTest;
  String _newTest;
  String coupleCounselling;

  bool preTestInformationGiven;
  String _pretestInfoGiven;

  bool optOutOfTest;
  String _optOutOfTest;

  bool newTestPregLact;
  String _newTestPregLact;

  String purposeOfTestId;

  @override
  void initState() {
     getHtsModel(widget.preTest.htsModelId);
     if(widget.preTest.newTest == false){
       _newTest = "NO";
     }else{
       _newTest = "YES";

     }
     if(widget.preTest.preTestInformationGiven){
       _pretestInfoGiven = "YES";

     }else{
       _pretestInfoGiven = "NO";

     }
     if(widget.preTest.newTestPregLact){
       _newTestPregLact = "YES";

     }else{
       _newTestPregLact = "NO";

     }
     if(widget.preTest.optOutOfTest){
       _optOutOfTest = "YES";
     }else{
      _optOutOfTest = "NO";
     }
    super.initState();
  }

  Future<void> getVisit(String patientId) async {
    Visit visit;

    try {
      visit = jsonDecode(
          await platform.invokeMethod('visit', patientId)
      );
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _visit = visit;
    });


  }


  Future<void> getHtsModel(String htsModelId) async {
   String htsModel;

    try {
      htsModel = await htsChannel.invokeMethod('getHtsModel', htsModelId);
      print('KKKKKKKKKKKKKKKK' + htsModel);

    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _htsModelId = htsModel;
    });


  }

  String nullHandler(String value) {
    return value == null ? "" : value;
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
            title: new Text(
                "Pre-Test Overview"
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
                  _buildButtonsRow(),
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

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: widget.preTest.htsApproach),
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                    labelText: "Hts Approach",
                                                                    hintText: "Hts Approach"
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _htsModelId)),
                                                                decoration: InputDecoration(
                                                                    icon: new Icon(Icons.credit_card, color: Colors.blue),
                                                                    labelText: "Hts Model",
                                                                    hintText: "Hts Model"
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _newTest)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'New Test ?',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        widget.preTest.coupleCounselling.toString())),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Couple counselling ?',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _pretestInfoGiven)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Pretest Info given ?',
                                                                  icon: new Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _newTestPregLact)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'New Test for pregnant women ?',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _optOutOfTest)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Opt out of test ?',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                              /*  Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16.0, top: 8.0),
                                              child: FloatingActionButton(
                                                onPressed: () =>
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddPatient()),
                                                    ),
                                                child: Icon(
                                                    Icons.add, size: 36.0),
                                              ),
                                            ), */
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "HTS Registration", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HtsRegOverview(widget.htsRegistration,widget.personId, widget.htsId, widget.visitId
                        )),
          ),
          ),
      //HtsRegOverview(this.htsRegistration, this.personId, this.htsid);

      // HtsRegOverview(this.htsRegistration, this.personId, this.htsid);

      new RoundedButton(text: "HTS Pre-Testing", selected: true,
          ),


          new RoundedButton(text: "Testing", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HtsScreeningTest(widget.personId, widget.visitId)),
          ),),

        ],
      ),
    );
  }


  Future<void> getDetails(String maritalStatusId,String educationLevelId,String occupationId,String nationalityId, String patientId) async{
    String maritalStatus,educationLevel,occupation,nationality, address, patientphonenumber;
    try{

      maritalStatus = await patientChannel.invokeMethod('getPatientMaritalStatus',maritalStatusId);
      educationLevel = await patientChannel.invokeMethod('getEducationLevel',educationLevelId);
      occupation = await patientChannel.invokeMethod('getOccupation',occupationId);
      nationality = await patientChannel.invokeMethod('getNationality',nationalityId);
      address = await patientChannel.invokeMethod('getAddress', patientId);
      patientphonenumber = await patientChannel.invokeMethod('getPhonenumber', patientId);


      print('ADDRESS ADDRESS'+ address);

    }
    catch (e) {
      print(
          'Something went wrong during getting marital status........cause $e');
    }

    setState(() {
      _maritalStatus = maritalStatus;
      _educationLevel = educationLevel;
      _occupation = occupation;
      _nationality = nationality;
      _address = address;
      _phonenumber = patientphonenumber;
    });
    print('9999999999999999999999999999999999999999999999999999 $_phonenumber');

  }


}






