import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
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

class HtsRegOverview extends StatefulWidget {
  final HtsRegistration htsRegistration;
  final String htsid ;
  final String personId;

  HtsRegOverview(this.htsRegistration, this.personId, this.htsid);

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

  bool showInput = true;
  bool showInputTabOptions = true;

  String visitId="1";

  @override
  void initState() {

    print(_patient.toString());
    print('BBBBBBBBBBBBBBBBBBBBBBBBBBB HERE IS PERSON ID IN REG OVERVIEW'+ widget.personId);
    getEntryPoint(widget.htsRegistration.entryPointId);

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
  Future<void> getEntryPoint(String entrypointId) async {
   String entrypoint;

    try {
      entrypoint = jsonDecode(
          await htsChannel.invokeMethod('getEntrypoint', entrypointId)
      );
      print('%%%%%%%%%%%%%%%%%%%%%%%%'+ entrypoint);
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
                "HTS Registration OverView"
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
                                                                    icon: new Icon(MdiIcons.humanMaleFemale, color: Colors.blue),
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


                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                                                        child: TextFormField(
                                                          controller: TextEditingController(
                                                              text: ''),
                                                          decoration: InputDecoration(
                                                            labelText: '',
                                                            icon: Icon(Icons.home, color: Colors.blue),
                                                          ),

                                                        ),
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
          new RoundedButton(text: "HTS Pre-Testing", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PatientPretest(widget.personId, widget.htsid, widget.htsRegistration
                        )),
          ),
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






