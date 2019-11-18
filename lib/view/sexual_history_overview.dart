import 'dart:convert';
import 'package:ehr_mobile/model/CbsQuestions.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/sexualhistory.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/vitals/visit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'art_reg.dart';
import 'rounded_button.dart';
import 'home_page.dart';

import 'hts_testscreening.dart';
import 'hts_registration.dart';

import 'reception_vitals.dart';
import 'package:ehr_mobile/model/address.dart';

class CbsOverview extends StatefulWidget {
  final Person patient;
  final CbsQuestion cbsQuestion;
  final String htsId;
  final String visitId;
  final String personId;

  CbsOverview(this.patient, this.cbsQuestion, this.htsId, this.visitId, this.personId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CbsOverview();
  }
}

class _CbsOverview extends State<CbsOverview> {
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
  @override
  void initState() {
    _patient = widget.patient;
    getVisit(_patient.id);
    getHtsRecord(_patient.id);
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
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {

      htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
      print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());

    });


  }
  Future<void> getHtsId(String patientId) async {
    var hts;

    try {
      hts = await htsChannel.invokeMethod('getHtsId', patientId);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      htsId = hts;
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
          /*  new ListTile(title: new Text("Patient Overview ",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CbsOverview(_patient)),
            )),*/
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Vitals", style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(_patient.id, visitId, _patient)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("HTS",  style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)),onTap: () {
              if(htsRegistration == null ){
                print('bbbbbbbbbbbbbb htsreg null in side bar  ');
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>  Registration(visitId, _patient.id, _patient)
                ));
              } else {
                print('bbbbbbbbbbbbbb htsreg  not null in side bar ');

                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=> HtsRegOverview(htsRegistration, _patient.id, htsId, visitId, _patient)
                ));
              }
            }),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("ART", style: new TextStyle(
                color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArtReg(_patient.id, visitId, _patient, htsRegistration)),
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
            title:new Column(children: <Widget>[
              new Text("CBS Overview"),
              new Text("Patient Name : " + " "+ widget.patient.firstName + " " + widget.patient.lastName)

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
                                                                    text:
                                                                        widget.cbsQuestion.sexuallyactive),
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons.person, color: Colors.blue),
                                                                    labelText: "Sexually active ?",
                                                                    hintText: "Sexually active ?"
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
                                                                        widget.cbsQuestion.age_whenclienthadfirstsexualintercourse)),
                                                                decoration: InputDecoration(
                                                                    icon: new Icon(MdiIcons.humanMaleFemale, color: Colors.blue),
                                                                    labelText: "Age fwhen client had first intercourse ",
                                                                    hintText: "Age fwhen client had first intercourse"
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
                                                                        widget.cbsQuestion.numberofsexualpartners)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Number of sexual partners in the last 12 months',
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
                                                                    text: nullHandler(victimofsexualause)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Victim of sexual abuse ?',
                                                                  icon: Icon(Icons.person, color: Colors.blue),
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
                                                                        widget.cbsQuestion.hadsexwithmale)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Had sex with male ?',
                                                                  icon: new Icon(MdiIcons.humanMale, color: Colors.blue),
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
                                                                        widget.cbsQuestion.hadsexwithfemale)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Had sex with female ?',
                                                                  icon: Icon(MdiIcons.humanFemale, color: Colors.blue),
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
                                                                        widget.cbsQuestion.unprotectedsex)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Had unprotected sex ?',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: widget.cbsQuestion.hadsexwithsexworker),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Had sex with sex worker ?',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
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
                                                                        widget.cbsQuestion.injectedrecreationaldrugs)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Ever injected recreational drugs ?',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: widget.cbsQuestion.historyofansti),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Has history of an STI ?',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
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
                                                                        widget.cbsQuestion.unprotectedsex)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Had unprotected sex ?',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: widget.cbsQuestion.beenincerceratedintojail),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Been in jail  ?',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
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
                                                                        widget.cbsQuestion.tatooedwithunsterilisedinstruments)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Tatooed with unsterilised instruments ?',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
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
                                                              text: widget.cbsQuestion.receivedbloodtransfusions),
                                                          decoration: InputDecoration(
                                                            labelText: 'Received blood transfusions ?',
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
          new RoundedButton(text: "VITALS", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ReceptionVitals(
                        _patient.id, visitId, _patient)),
          ),
          ),
          new RoundedButton(text: "HTS",  onTap: () {
            if(htsRegistration == null ){
              print('bbbbbbbbbbbbbb htsreg null ');
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>  Registration(visitId, _patient.id, _patient)
              ));
            } else {
              print('bbbbbbbbbbbbbb htsreg  not null ');

              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=> HtsRegOverview(htsRegistration, _patient.id, htsId, visitId, _patient)
              ));
            }
          }
          ),


          new RoundedButton(text: "ART", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ArtReg(_patient.id, visitId, _patient, htsRegistration)),
          ),),


          new RoundedButton(text: "CLOSE", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchPatient()),
          ),
          ),
        ],
      ),
    );
  }
  Widget _sidemenu(){
    return new Drawer(
      child: ListView(
        children: <Widget>[

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






