import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/cbsquestion.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/recency.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/art_initiation.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/vitals/visit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
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

  PostTestOverview(this.postTest, this.personId, this.visitId, this.person, this.htsId);

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

  @override
  void initState() {

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
              new ListTile(title: new Text("Patient Overview "), onTap: () => Navigator.push(
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
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("HTS",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Registration(widget.visitId,widget.personId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("ART",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArtReg(widget.personId, widget.visitId, widget.person)),
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
                                                                    text: widget.postTest.datePostTestCounselled.toIso8601String()),
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
                                                            "Recency Testing",
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          onPressed: () {

                                                                Navigator.push(context,MaterialPageRoute(
                                                                    builder: (context)=> RecencyTest(widget.personId, widget.visitId, widget.person, widget.htsId)
                                                                ));

                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 25.0,
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
                                                            "Sexual History",
                                                            style: TextStyle(color: Colors.white),
                                                          ),
                                                          onPressed: () {

                                                            Navigator.push(context,MaterialPageRoute(
                                                                builder: (context)=> CbsQuestions(widget.personId, widget.htsId, null, widget.visitId, widget.person)
                                                            ));





                                                          },
                                                        ),
                                                      ),


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

          new RoundedButton(text: "ART Registration", selected: true,/* onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Registration(_patient.id)),
          ),*/),
          new RoundedButton(text: "ART Initiation", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Art_Initiation(widget.personId, widget.visitId
                    )),
          ),
          ),
          new RoundedButton(text: "Close",)
        ],
      ),
    );
  }

}






