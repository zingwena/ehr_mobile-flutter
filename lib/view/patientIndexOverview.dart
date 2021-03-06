import 'dart:convert';

import 'package:ehr_mobile/model/artdto.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/hiv_information.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/vitals/visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../landing_screen.dart';
import '../sidebar.dart';
import 'art_reg.dart';
import 'hts_registration.dart';
import 'reception_vitals.dart';
import 'rounded_button.dart';

class PatientIndexOverview extends StatefulWidget {
  final Person patient;
  final Person person_contact;
  final String indexTestId;
  final String personId;
  final String visitId;
  final String htsId;
  final HtsRegistration htsRegistration;

  PatientIndexOverview(this.patient, this.person_contact, this.indexTestId,
      this.personId, this.visitId, this.htsRegistration, this.htsId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OverviewState();
  }
}

class OverviewState extends State<PatientIndexOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static final MethodChannel patientChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');


  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _maritalStatus,
      _educationLevel,
      _occupation,
      _nationality,
      _address,
      _phonenumber;
  HtsRegistration htsRegistration;
  String htsId;
  bool showInput = true;
  bool showInputTabOptions = true;
  String visitId;
  Artdto artdto;


  var facility_name;

  @override
  void initState() {
    _patient = widget.patient;
    getVisit(_patient.id);
    getHtsRecord(_patient.id);
    getFacilityName();
    getDetails(widget.person_contact.maritalStatusId, widget.person_contact.educationLevelId,
        widget.person_contact.occupationId, widget.person_contact.nationalityId, widget.person_contact.id);
    getArt(widget.person_contact.id);

    super.initState();
  }

  Future<void>getArt(String personId)async{
    String response;
    try{
      response = await artChannel.invokeMethod('getArt', personId);
      setState(() {
        this.artdto = Artdto.fromJson(jsonDecode(response));
        });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
  }

  Future<void> getVisit(String patientId) async {
    String visit;

    try {
      visit = await platform.invokeMethod('visit', patientId);
      setState(() {
        visitId = visit;
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  Future<void> getFacilityName() async {
    String response;
    try {
      response = await retrieveString(FACILITY_NAME);
      setState(() {
        facility_name = response;
      });
    } catch (e) {
      debugPrint("Exception thrown in get facility name method" + e);
    }
  }

  Future<void> getHtsRecord(String patientId) async {
    var hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      setState(() {
        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
        print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());
      });
      print('HTS IN THE FLUTTER THE RETURNED ONE ' + hts);
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

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.patient, widget.personId, widget.visitId,
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
            height: 210.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title: new Text(
              facility_name != null ? facility_name : 'Impilo Mobile',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 25.0,
              ),
            ),
            actions: <Widget>[


              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
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

              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IconButton(
                              icon: Icon(Icons.home), color: Colors.white,
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchPatient()),),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app), color: Colors.white,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LandingScreen()),),
                          ),
                        ),])
              ),
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
                      "Patient Index OverView",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                  ),
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
                                  //   _buildTabBar(),
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
                                                                const EdgeInsets.only( right:  16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: widget.person_contact.firstName + " " + widget.person_contact.lastName),
                                                              decoration: InputDecoration(
                                                                  icon: Icon( Icons.person,
                                                                      color: Colors.blue),
                                                                  labelText: "Full Name",
                                                                  hintText: "Full Name"),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                    right: 16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: nullHandler(widget.person_contact.sex)),
                                                              decoration: InputDecoration(
                                                                  icon: new Icon(
                                                                      MdiIcons.humanMaleFemale,
                                                                      color: Colors.blue),
                                                                  labelText: "Sex",
                                                                  hintText: "Sex"),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only( right: 16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: nullHandler( widget.person_contact.nationalId)),
                                                              decoration: InputDecoration(
                                                                labelText: 'National ID',
                                                                icon: Icon( Icons.credit_card,
                                                                    color: Colors.blue),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only( right: 16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: DateFormat( "dd/MM/yyyy").format(widget.person_contact.birthDate)),
                                                              decoration: InputDecoration(
                                                                labelText: 'Date Of Birth',
                                                                icon: Icon( Icons.date_range,
                                                                    color: Colors.blue),
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
                                                            padding: const EdgeInsets.only(
                                                                    right: 16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: nullHandler(_maritalStatus)),
                                                              decoration: InputDecoration(
                                                                labelText: 'Marital Status',
                                                                icon: new Icon(
                                                                    MdiIcons.humanMaleFemale,
                                                                    color: Colors.blue),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                    right: 16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: nullHandler(_educationLevel)),
                                                              decoration: InputDecoration(
                                                                labelText: 'Education',
                                                                icon: Icon(
                                                                    Icons.book,
                                                                    color: Colors.blue),
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
                                                            padding: const EdgeInsets.only(
                                                                    right: 16.0),
                                                            child: TextField(
                                                              controller: TextEditingController(
                                                                  text: nullHandler(_nationality)),
                                                              decoration: InputDecoration(
                                                                labelText: 'Nationality',
                                                                icon: Icon(
                                                                    Icons.flag,
                                                                    color: Colors.blue),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(
                                                                    right: 16.0),
                                                            child: TextField(
                                                              controller:
                                                                  TextEditingController(
                                                                      text: _phonenumber),
                                                              decoration:  InputDecoration(
                                                                labelText: 'Phone Number',
                                                                icon: Icon( Icons.smartphone,
                                                                    color: Colors.blue),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(
                                                          0.0, 0.0, 64.0, 8.0),
                                                      child: TextFormField(
                                                        controller: TextEditingController(
                                                                text: _address),
                                                        decoration: InputDecoration(
                                                          labelText: 'Address',
                                                          icon: Icon(Icons.home,
                                                              color: Colors.blue),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                           // Expanded(child: Container()),
                                            SizedBox(height: 50.0),
                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                              child: RaisedButton(
                                                elevation: 4.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5.0)),
                                                color: Colors.blue,
                                                padding: const EdgeInsets.all(20.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text('Add to Contact Index', style: TextStyle(color: Colors.white),),
                                                    Spacer(),
                                                    Icon(Icons.navigate_next, color: Colors.white, ),
                                                  ],
                                                ),
                                                onPressed: () {

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HivInformation(
                                                                  widget.person_contact,
                                                                  widget.indexTestId,
                                                                  widget.patient,
                                                                  widget.personId,
                                                                  widget.visitId,
                                                                  widget.htsRegistration,
                                                                  widget.htsId)));
                                                },
                                              ),
                                            )
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "VITALS",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(_patient.id, visitId, _patient, htsId)),
            ),
          ),
          new RoundedButton(
              text: "HTS",
              onTap: () {
                if (htsRegistration == null) {
                  print('bbbbbbbbbbbbbb htsreg null ');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Registration(visitId, _patient.id, _patient)));
                } else {
                  print('bbbbbbbbbbbbbb htsreg  not null ');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HtsRegOverview(htsRegistration,
                              _patient.id, htsId, visitId, _patient)));
                }
              }),
          new RoundedButton(
            text: "ART",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArtReg(artdto,
                      _patient.id, visitId, _patient, htsRegistration, htsId)),
            ),
          ),
          new RoundedButton(
            text: "CLOSE",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPatient()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidemenu() {
    return new Drawer(
      child: ListView(
        children: <Widget>[],
      ),
    );
  }

  Future<void> getDetails(String maritalStatusId, String educationLevelId,
      String occupationId, String nationalityId, String patientId) async {
    String maritalStatus,
        educationLevel,
        occupation,
        nationality,
        address,
        patientphonenumber;
    try {
      maritalStatus = await patientChannel.invokeMethod(
          'getPatientMaritalStatus', maritalStatusId);
      educationLevel = await patientChannel.invokeMethod(
          'getEducationLevel', educationLevelId);
      occupation =
          await patientChannel.invokeMethod('getOccupation', occupationId);
      nationality =
          await patientChannel.invokeMethod('getNationality', nationalityId);
      address = await patientChannel.invokeMethod('getAddress', patientId);
      patientphonenumber =
          await patientChannel.invokeMethod('getPhonenumber', patientId);

      print('ADDRESS ADDRESS' + address);
    } catch (e) {
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
