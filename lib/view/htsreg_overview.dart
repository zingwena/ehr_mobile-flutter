import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/hts_pretest_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/art_reg.dart';
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
import 'package:ehr_mobile/model/address.dart';

class HtsRegOverview extends StatefulWidget {
  final HtsRegistration htsRegistration;
  final String htsid ;
  final String personId;
  final String visitId;
  final Person person;
  HtsRegOverview(this.htsRegistration, this.personId, this.htsid, this.visitId, this.person);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HtsOverviewState();
  }
}

class HtsOverviewState extends State<HtsRegOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _entrypoint;
  HtsRegistration htsRegistration;

  bool showInput = true;
  bool showInputTabOptions = true;
  PreTest preTest;
  String htsApproach;

  @override
  void initState() {
    print(_patient.toString());
    getEntryPoint(widget.htsRegistration.entryPointId);
    getPretestRecord(widget.personId);
    getHtsRecord(widget.personId);
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
  Future<void> getPretestRecord(String patientId) async {
    var  pre_test;
    try {
      pre_test = await htsChannel.invokeMethod('getcurrenthts', patientId);
      print('PRETEST IN THE FLUTTER THE RETURNED ONE '+ pre_test.toString());
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {

      preTest = PreTest.fromJson(jsonDecode(pre_test));
      htsApproach = preTest.htsApproach;
      print("HERE IS THE PRETEST AFTER ASSIGNMENT HTS APPROACH #######################" + htsApproach);

    });


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
            new ListTile(leading: new Icon(Icons.home, color: Colors.blue),title: new Text("Home ",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Overview(widget.person)),
            )),
              new ListTile(leading: new Icon(Icons.person, color: Colors.blue),title: new Text("Patient Overview ",  style: new TextStyle(
                  color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Overview(widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Vitals",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(widget.personId, widget.visitId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("HTS",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)),  onTap: () {
              if(htsRegistration == null ){
                print('bbbbbbbbbbbbbb htsreg null in side bar  ');
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>  Registration(widget.visitId, widget.personId, widget.person)
                ));
              } else {
                print('bbbbbbbbbbbbbb htsreg  not null in side bar ');

                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=> HtsRegOverview(htsRegistration, widget.personId, widget.htsid, widget.visitId, widget.person)
                ));
              }
            }),
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
            title: new Column(children: <Widget>[
              new Text("HTS Reg Overview"),
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
                                                                    text: widget.htsRegistration.dateOfHivTest.toString()),
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons.date_range, color: Colors.blue),
                                                                    labelText: "Date of Hiv Test",
                                                                    hintText: "Date of Hiv Test"
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
                                                                        widget.htsRegistration.htsType)),
                                                                decoration: InputDecoration(
                                                                    icon: new Icon(Icons.credit_card, color: Colors.blue),
                                                                    labelText: "Hts Type",
                                                                    hintText: "Hts Type"
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
                                                                        _entrypoint)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Entry Point',
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

          new RoundedButton(text: "HTS Registration", selected: true,/* onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Registration(_patient.id)),
          ),*/),
          new RoundedButton(text: "HTS Pre-Testing", onTap: () {
            if(htsApproach == null ){
              print('bbbbbbbbbbbbbb htsPretest null ');
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>  PatientPretest(widget.personId, widget.htsid, widget.htsRegistration, widget.visitId, widget.person)
              ));
            } else {
              print('bbbbbbbbbbbbbb htsreg  not null ');

              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=> PretestOverview(preTest, widget.htsRegistration, widget.personId, widget.htsid, widget.visitId, widget.person)
              ));
            }




          }
          ),
          new RoundedButton(text: "HTS Testing",/* onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HtsScreeningTest(widget.personId)),
          ),*/
          ),


          /*new RoundedButton(text: "HTS Post-Testing", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Art_Registration(_patient.id)),
          ),),*/


         /* new RoundedButton(text: "CLOSE", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchPatient()),
          ),
          ),*/
        ],
      ),
    );
  }

}






