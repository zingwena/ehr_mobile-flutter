import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/cbsquestion.dart';
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
  final String result;
  final HtsRegistration htsRegistration;

  PostTestOverview(this.postTest, this.personId, this.visitId, this.person, this.htsId, this.consenttoIndex, this.result, this.htsRegistration);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostTestOverviewState();
  }
}

class PostTestOverviewState extends State<PostTestOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');


  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _entrypoint;

  bool showInput = true;
  bool showInputTabOptions = true;
  var dateOfTest;
  String indexTestId;

  @override
  void initState() {
    dateOfTest = DateFormat("yyyy/MM/dd").format(widget.postTest.datePostTestCounselled);
    print(_patient.toString());
    //  getEntryPoint(widget.htsRegistration.entryPointId);
    super.initState();
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

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("admin"), accountEmail: new Text("admin@gmail.com"), currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage('images/mhc.png'))),
            new ListTile( leading: new Icon(Icons.home, color: Colors.blue), title: new Text("Patient Overview "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchPatient()),
            )),
              new ListTile( leading: new Icon(Icons.person, color: Colors.blue), title: new Text("Patient Overview "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Overview(_patient)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Vitals",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(widget.personId, widget.visitId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("HTS"), onTap: () {
              if(widget.htsRegistration == null ){
                print('bbbbbbbbbbbbbb htsreg null in side bar  ');
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>  Registration(widget.visitId, widget.personId, widget.person)
                ));
              } else {
                print('bbbbbbbbbbbbbb htsreg  not null in side bar ');

                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=> HtsRegOverview(widget.htsRegistration, widget.personId, widget.htsId, widget.visitId, widget.person)
                ));
              }
            }),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("ART",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArtReg(widget.personId, widget.visitId, widget.person, widget.htsRegistration)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Sexual History",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CbsQuestions(widget.personId, widget.htsId, null, widget.visitId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Sexual History",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CbsQuestions(widget.personId, widget.htsId, widget.htsRegistration, widget.visitId, widget.person)),
            )),

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
            title:  new Column(children: <Widget>[
              new Text("Post Test Overview"),
              new Text("Patient Name : " + " "+ widget.person.firstName + " " + widget.person.lastName)

            ],)
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
                  //_buildButtonsRow(),
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
                                                                    text: dateOfTest),
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons.date_range, color: Colors.blue),
                                                                    labelText: "Date Post Counselled",
                                                                    hintText: "Date Post Counselled"
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
                                                                        widget.postTest.finalResult)),
                                                                decoration: InputDecoration(
                                                                    icon: new Icon(Icons.date_range, color: Colors.blue),
                                                                    labelText: "Final Result",
                                                                    hintText: "Final Result"
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 25.0,
                                                      ),

                                                      SizedBox(
                                                        height: 25.0,
                                                      ),
                                                   /*   Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                        child: RaisedButton(
                                                          elevation: 4.0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.blue,
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Text(
                                                            "Sexual History",
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          onPressed: () {

                                                            Navigator.push(context,MaterialPageRoute(
                                                                builder: (context)=> CbsQuestions(widget.personId, widget.htsId, null, widget.visitId, widget.person)
                                                            ));
                                                          },
                                                        ),
                                                      ),*/
                                                      SizedBox(
                                                        height: 25.0,
                                                      ),
                                                     /* Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                        child: RaisedButton(
                                                          elevation: 4.0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.blue,
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Text(
                                                            "Hts screening",
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          onPressed: () {

                                                            Navigator.push(context,MaterialPageRoute(
                                                                builder: (context)=> Hts_Screening(widget.personId, widget.htsId, null, widget.visitId, widget.person)
                                                            ));
                                                          },
                                                        ),
                                                      ),*/
                                                      SizedBox(
                                                        height: 25.0,
                                                      ),
                                                      _recencyTesting(),
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
  Widget _recencyTesting(){
    if(widget.result == 'POSITIVE' || widget.result == 'Positive'){
      return   Container(                                      width: double.infinity,
                                                        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                        child: RaisedButton(
                                                          elevation: 4.0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.blue,
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Text(
                                                            "Recency Testing",
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          onPressed: () {

                                                                Navigator.push(context,MaterialPageRoute(
                                                                    builder: (context)=> RecencyTest(widget.personId, widget.visitId, widget.person, widget.htsId , indexTestId, widget.htsRegistration)
                                                                ));

                                                          },
                                                        ),
                                                      );
    }
    else{

      return Container(                                      width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: RaisedButton(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          color: Colors.blue,
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Close ",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {

            Navigator.push(context,MaterialPageRoute(
                builder: (context)=> Overview( widget.person)
            ));

          },
        ),
      );

    }
  }

/*  Widget _IndexButton() {

    if(widget.consenttoIndex == true){
      return   Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: RaisedButton(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          color: Colors.blue,
          padding: const EdgeInsets.all(20.0),
          child: Text(
            "Index Testing",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            IndexTest indexTest = IndexTest(widget.personId, widget.postTest.datePostTestCounselled);
            saveIndexTest(indexTest);
            Navigator.push(context,MaterialPageRoute(
                builder: (context)=> HIVServicesIndexContactList(widget.person, widget.visitId, widget.htsId, null, widget.personId, indexTestId)
            ));
          },
        ),
      );

    }else{
      return SizedBox(
        height: 10.0,
      );
    }

  }*/

  Future<void>saveIndexTest(IndexTest indexTest)async{
    var response ;
    print('GGGGGGGGGGGGGGGGGGGGGGGGG HERE IS THE INDEX '+ indexTest.toString());
    try{
      response = await htsChannel.invokeMethod('saveIndexTest', jsonEncode(indexTest));
      print('LLLLLLLLLLLLLLLLLLLLLLL hre is the indextest id'+ response );
      setState(() {
        indexTestId = response;
      });

    }catch(e){

    }

  }

}






