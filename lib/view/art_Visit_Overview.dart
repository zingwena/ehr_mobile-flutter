import 'dart:convert';
import 'package:ehr_mobile/model/artdto.dart';
import 'package:ehr_mobile/model/artvisit.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/artInitiation.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/art_initiationoverview.dart';

import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/art_initiation.dart';

import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/view/tb_screening.dart';
import 'package:ehr_mobile/vitals/visit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';
import 'rounded_button.dart';
import 'home_page.dart';

import 'hts_testscreening.dart';
import 'hts_registration.dart';

import 'reception_vitals.dart';
import 'package:ehr_mobile/model/artRegistration.dart';

class ArtVisitOverview extends StatefulWidget {
  final ArtVisit artVisit;
  final String personId;
  final String visitId;
  final Person person;
  final HtsRegistration htsRegistration;
  final String htsId;

  ArtVisitOverview(this.artVisit, this.personId, this.visitId, this.person, this.htsRegistration, this.htsId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArtVisitOverviewState();
  }
}

class ArtVisitOverviewState extends State<ArtVisitOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  static const dataChannel =  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');

  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _entrypoint;
  bool showInput = true;
  bool showInputTabOptions = true;
  ArtInitiation artInitiation;
  var dateOfEnrollment, dateOfHivTest, dateHivConfirmed, dateOfRetest;
  Age age;
  String facility_name;

  @override
  void initState() {
  /*  dateOfEnrollment = DateFormat("yyyy/MM/dd").format(widget.artRegistration.dateEnrolled);
    dateOfHivTest = DateFormat("yyyy/MM/dd").format(widget.artRegistration.dateOfHivTest);
    dateHivConfirmed =  DateFormat("yyyy/MM/dd").format(widget.artRegistration.dateHivConfirmed);
    dateOfRetest =   DateFormat("yyyy/MM/dd").format(widget.artRegistration.dateRetested);*/
    print(_patient.toString());
    //  getEntryPoint(widget.htsRegistration.entryPointId);
    getAge(widget.person);
    getFacilityName();
    super.initState();
  }

  Future<void>getAge(Person person)async{
    String response;
    try{
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
        print("THIS IS THE AGE RETRIEVED"+ age.toString());
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
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


  Future<void> getEntryPoint(String entrypointId) async {
    String entrypoint;

    try {
      entrypoint =
      await htsChannel.invokeMethod('getEntrypoint', entrypointId);


    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _entrypoint = entrypoint;
    });


  }

  Future<void> getArtInitiation(String patientId) async {
    var  art_initiation;
    try {
      art_initiation = await htsChannel.invokeMethod('getArtInitiationRecord', patientId);
      setState(() {
        artInitiation = ArtInitiation.fromJson(jsonDecode(art_initiation));
        print("HERE IS THE ART INITIATION AFTER ASSIGNMENT >>>>>>>>>>>>>" + artInitiation.toString());

      });

      print('ART INITIATION IN THE FLUTTER THE RETURNED ONE '+ artInitiation.toString());
    } catch (e) {
      print("channel failure: '$e'");
    }


  }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId),
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
            title:new Text(
              facility_name!=null?facility_name: 'Impilo Mobile',   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
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
                    child: Text("ART Visit OverView", style: TextStyle(
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
                                Icons.date_range, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Age -"+age.years.toString()+"years", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person, size: 25.0, color: Colors.white,),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Sex :"+ widget.person.sex, style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.verified_user, size: 25.0, color: Colors.white,),
                            ),
                          ])
                  ),
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
                                //  _buildTabBar(),
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
                                                                    text: nullHandler(
                                                                        widget.artVisit.visitType)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Art Visit Type',
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
                                                                        widget.artVisit.functionalStatus)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Functional Status',
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
                                                                        widget.artVisit.visitStatus)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Visit Status',
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
                                                                        widget.artVisit.lactatingStatus)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Lactating Status',
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
                                                                        widget.artVisit.familyPlanningStatus)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Family Planning Status',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),/*
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        widget.artRegistration.reTested.toString())),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Retested before ART',
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
                                                                        dateOfRetest)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Date of retest',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),


                                                        ],
                                                      ),*/

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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[

          new RoundedButton(text: "ART Visit ", selected: true),
          new RoundedButton(text: "TB Screening", onTap: (){
            Navigator.push(context,MaterialPageRoute(
                builder: (context)=>  TbScreening()
            ));

          }
          ),
          new RoundedButton(text: "Close",)
        ],
      ),
    );
  }

}






