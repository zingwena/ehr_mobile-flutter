import 'dart:convert';

import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/artappointment.dart';
import 'package:ehr_mobile/model/artdto.dart';
import 'package:ehr_mobile/model/artipt.dart';
import 'package:ehr_mobile/model/artvisit.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/htsscreening.dart';
import 'package:ehr_mobile/model/patientsummarydto.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/tbscreening.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/art_appointment.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';
import 'package:ehr_mobile/view/htsscreeningoverview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/tb_screening.dart';
import 'package:ehr_mobile/view/tb_screening_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../sidebar.dart';
import 'artFollowUp.dart';
import 'art_Visit_Overview.dart';
import 'art_iptStatus.dart';
import 'art_iptStatusOverView.dart';
import 'art_newOS.dart';
import 'art_reg.dart';
import 'art_symptoms.dart';
import 'art_visit.dart';
import 'artappointmentOverview.dart';
import 'hts_screening.dart';

class ArtSummaryOverview extends StatefulWidget {
  final Person person;
  final String visitId;
  final String htsId;
  final HtsRegistration htsRegistration;

  ArtSummaryOverview(this.person, this.visitId, this.htsRegistration, this.htsId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArtSummaryOverviewState();
  }
}

class ArtSummaryOverviewState extends State<ArtSummaryOverview>
    with TickerProviderStateMixin {
  TabController controller;
  HtsScreening htsScreening;
  PatientSummaryDto patientSummaryDto;
  String queue = "";
  String Bp_date;
  String Respiratoryrate_date;
  String pulse_date;
  String weight_date;
  String height_date;
  String temp_date;
  Age age;
  Artdto artdto;
  TbScreening tbScreeningobj;
  static const htsChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const visitChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/visitChannel');
  static const dataChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const artChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  String _appointmetnt_string;
  List appointmnents = List();
  List _dropDownListAppointments= List();
  List<ArtAppointment> _appointmentList = List();
  ArtAppointment artAppointmentResponse;
  String facility_name;

  String coughingString = "";
  String feverString = "";
  String nightSweatsString = "";
  String weightLossString  = "";
  String bmiUnderSeventeenString = "";

  bool coughingOption = false;
  bool feverOption = false;
  bool nightSweatsOption = false;
  bool weightLossOption = false;
  bool bmiUnderSeventeen = false;

  ArtVisit _artVisit;
  ArtIpt _artIpt;

  @override
  void initState() {
    getHtsScreeningRecord(widget.person.id);
    getPatientSummary(widget.person.id);
    getTbScreening(widget.person.id);
    getArt(widget.person.id);
    getAge(widget.person);
    getFacilityName();
    getArtAppointments(widget.person.id);
    getArtVist(widget.person.id);
    getArtIpt(widget.person.id);

    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  Future<void> getArt(String personId) async {
    String response;
    try {
      response = await artChannel.invokeMethod('getArt', personId);
      setState(() {
        this.artdto = Artdto.fromJson(jsonDecode(response));
      });
    } catch (e) {
      debugPrint("Exception thrown in get facility name method" + e);
    }
  }

  Future<void> getHtsScreeningRecord(String patientId) async {
    var hts_screening;
    print("get screening method called here");
    try {
      hts_screening =
      await htsChannel.invokeMethod('getHtsScreening', patientId);

      setState(() {
        htsScreening = HtsScreening.fromJson(jsonDecode(hts_screening));
      });
    } catch (e) {
      print("channel failure at hts screening: '$e'");
    }
  }

  Future<void>getTbScreening(String personId)async{
    String response;
    try{
      response = await artChannel.invokeMethod('getTbScreening', personId);
      setState(() {
        tbScreeningobj = TbScreening.fromJson(jsonDecode(response));
        print("THIS IS THE TB SCREENING  RETRIEVED"+ tbScreeningobj.toString());

        if(tbScreeningobj != null){
          if(tbScreeningobj.coughing == true){
            coughingString = "YES";
          }else{
            coughingString = "NO";
          }

          if(tbScreeningobj.fever == true){
            feverString = "YES";
          }else{
            feverString = "NO";
          }

          if(tbScreeningobj.nightSweats == true){
            nightSweatsString = "YES";

          }else{
            nightSweatsString = "NO";
          }
          if(tbScreeningobj.bmiUnderSeventeen == true){
            bmiUnderSeventeenString = "YES";
          }else{
            bmiUnderSeventeenString = "NO";

          }
          if(tbScreeningobj.weightLoss == true){
            weightLossString = "YES";
          }else{
            weightLossString = "NO";

          }


        }
      });

    }catch(e){
      debugPrint("Exception thrown in get Tb Screening name method"+e);

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

  Future<void> getArtAppointments(String  personId) async {
    var art_appointment_response;
    try {

      art_appointment_response = await artChannel.invokeMethod(
          'getArtAppointments', personId);
      setState(() {
        _appointmetnt_string = art_appointment_response;
        appointmnents = jsonDecode(_appointmetnt_string);
        _dropDownListAppointments = ArtAppointment.mapFromJson(appointmnents);
        _dropDownListAppointments.forEach((e) {
          _appointmentList.add(e);
        });
      });

    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }
  Future<void> getAge(Person person) async {
    String response;
    try {
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
        print("THIS IS THE AGE RETRIEVED" + age.toString());
      });
    } catch (e) {
      debugPrint("Exception thrown in get Age name method" + e);
    }
  }

  Future<void> getPatientSummary(String patientId) async {
    var patient_summary;
    try {
      patient_summary =
      await visitChannel.invokeMethod('getPatientSummary', patientId);
      setState(() {
        patientSummaryDto =
            PatientSummaryDto.fromJson(jsonDecode(patient_summary));
        debugPrint("RRRRRRRRRRRRR Patient summary dto from android" +
            patientSummaryDto.toString());
        debugPrint(
            "RRRRRRRRRRRRR Patient summary dto from android temperature" +
                patientSummaryDto.temperature.toString());
      });
    } catch (e) {
      print("channel failure at Patient summary dto method: '$e'");
    }
  }

  Future<void> getArtVist(String  personId) async {
    var art_visit_response;
    try {
      art_visit_response = await artChannel.invokeMethod('getArtVisit', personId);
      setState(() {
        _artVisit = ArtVisit.fromJson(jsonDecode(art_visit_response));
      });

    } catch (e) {
      print('--------------something went wrong in art visit get  method  $e');
    }

  }

  Future<void> getArtIpt(String  personId) async {
    var art_visit_response;
    try {
      art_visit_response = await artChannel.invokeMethod('getArtIpt', personId);
      print("KKKKKKKKKKK art ipt string here "+ art_visit_response.toString());

      setState(() {
        _artIpt = ArtIpt.fromJson(jsonDecode(art_visit_response));
        print("KKKKKKKKKKK art ipt here "+ _artIpt.toString());
      });

    } catch (e) {
      print('--------------something went wrong in art visit get  method  $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Sidebar(widget.person, widget.person.id, widget.visitId, widget.htsRegistration, widget.htsId),

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
                            icon: Icon(Icons.exit_to_app), color: Colors.white,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),),
                          ),
                          /*  Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("logout", style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0,color: Colors.white ),),
                        ), */

                        ),  ])
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
                      " Art Summary",
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
                                Icons.date_range,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                            age == null
                                ? SizedBox(
                              height: 0.0,
                            )
                                : Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Age :" + age.years.toString() + "years",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.person,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Sex :" + widget.person.sex,
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
                  _buildButtonsRow(),
                  SizedBox(
                    height: 3.0,
                  ),
                  Expanded(
                    child: new Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                        child: new LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return Column(
                              children: <Widget>[
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
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16.0,
                                                            horizontal: 20.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5.0)),
                                                          color: Colors.white,
                                                          padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                vertical: 8.0,
                                                                horizontal:
                                                                30.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: <Widget>[
                                                                // three line description
                                                                Container(
                                                                  alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                                  child: Text(
                                                                    'ART Registration',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                      fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                ),

                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top: 3.0),
                                                                ),

                                                                Divider(
                                                                  height: 10.0,
                                                                  color: Colors.blue
                                                                      .shade500,
                                                                ),
                                                                Container(
                                                                  height: 2.0,
                                                                  color:
                                                                  Colors.blue,
                                                                ),

                                                                artdto ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          artdto.artNumber,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.confirmation_number, color: Colors.blue),
                                                                            labelText: "Art Number",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          DateFormat("yyyy/MM/dd").format(artdto.date),
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.calendar_today, color: Colors.blue),
                                                                            labelText: "Registration Date",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                artdto ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          DateFormat("yyyy/MM/dd").format(artdto.dateEnrolled),
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.ac_unit, color: Colors.blue),
                                                                            labelText: "Date Enrolled",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          DateFormat("yyyy/MM/dd").format(artdto.dateOfHivTest),
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                            labelText: "Date of HIV Test",
                                                                            //hintText: "National ID"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                artdto ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          DateFormat("yyyy/MM/dd").format(artdto.dateHivConfirmed),
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.ac_unit, color: Colors.blue),
                                                                            labelText: "Date HIV Confirmed",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          artdto.linkageFrom,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                            labelText: "Linkage From",
                                                                            //hintText: "National ID"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                artdto ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          artdto.linkageNumber,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.ac_unit, color: Colors.blue),
                                                                            labelText: "Art Linkage Number",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          artdto.hivTestUsed,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                            labelText: "HIV Test used",
                                                                            //hintText: "National ID"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                artdto ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                           artdto.testReason,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.ac_unit, color: Colors.blue),
                                                                            labelText: "Test Reason",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 
                                                                        16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          artdto.reTested.toString(),
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                            labelText: "Retested ?",
                                                                            //hintText: "National ID"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                artdto ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          DateFormat("yyyy/MM/dd").format(artdto.dateRetested),
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.ac_unit, color: Colors.blue),
                                                                            labelText: "Date Retested",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                   artdto.facility != null? Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          artdto.facility,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                            labelText: "Facility",
                                                                            //hintText: "National ID"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ):Expanded(
                                                                     child:
                                                                     Padding(
                                                                       padding:
                                                                       const EdgeInsets.only(right: 16.0),
                                                                       child:
                                                                       TextFormField(
                                                                         initialValue:
                                                                         artdto.otherInstitution,
                                                                         decoration:
                                                                         InputDecoration(
                                                                           icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                           labelText: "Other Institution ",
                                                                           //hintText: "National ID"
                                                                         ),
                                                                       ),
                                                                     ),
                                                                   ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  height: 10.0,
                                                                  color: Colors.blue
                                                                      .shade500,
                                                                ),
                                                                Container(
                                                                  height: 2.0,
                                                                  color:
                                                                  Colors.blue,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          borderSide: BorderSide(
                                                            color: Colors.blue,
                                                            //Color of the border
                                                            style:
                                                            BorderStyle.solid,
                                                            //Style of the border
                                                            width:
                                                            2.0, //width of the border
                                                          ),
                                                          onPressed: () {
                                                            if(artdto.artNumber == null){
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => ArtReg(
                                                                        artdto,
                                                                        widget.person
                                                                            .id,
                                                                        widget
                                                                            .visitId,
                                                                        widget.person,
                                                                        widget
                                                                            .htsRegistration,
                                                                        widget
                                                                            .htsId)),
                                                              );
                                                            }else{
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ArtRegOverview(
                                                                          this.artdto,
                                                                          widget.person.id,
                                                                          widget.visitId,
                                                                          widget.person,
                                                                          widget.htsRegistration,
                                                                          widget.htsId)));

                                                            }

                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16.0,
                                                            horizontal: 20.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5.0)),
                                                          color: Colors.white,
                                                          padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                vertical: 8.0,
                                                                horizontal:
                                                                30.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: <Widget>[
                                                                // three line description
                                                                Container(
                                                                  alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                                  child: Text(
                                                                    'Art Appointments List',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                      fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  height: 10.0,
                                                                  color: Colors.blue
                                                                      .shade500,
                                                                ),
                                                                Container(
                                                                  height: 2.0,
                                                                  color:
                                                                  Colors.blue,
                                                                ),
                                                                Row(
                                                                  children: <Widget>[
                                                                    Expanded(
                                                                      child: _appointmentList.isEmpty
                                                                          ? Container(
                                                                          alignment:
                                                                          Alignment.topLeft,
                                                                          child:
                                                                          Center(child: Text(
                                                                            'No Records',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black54),
                                                                          ),)
                                                                      )
                                                                          : Container(
                                                                        width: double
                                                                            .infinity,
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical:
                                                                            0.0,
                                                                            horizontal:
                                                                            30.0),
                                                                        child: DataTable(
                                                                            columns: [
                                                                              DataColumn(label: Text("Date")),
                                                                              DataColumn(label: Text("Reason Name")),
                                                                            ],
                                                                            rows: _appointmentList
                                                                                .map((appointment) => DataRow(cells: [
                                                                              DataCell(Text(DateFormat("yyyy/MM/dd").format(appointment.date))),
                                                                              DataCell(Text(appointment.reason)),
                                                                            ]))
                                                                                .toList()),
                                                                      ),)
                                                                  ],
                                                                ),

                                                                Divider(
                                                                  height: 10.0,
                                                                  color: Colors.blue
                                                                      .shade500,
                                                                ),
                                                                Container(
                                                                  height: 2.0,
                                                                  color:
                                                                  Colors.blue,
                                                                ),

                                                              ],
                                                            ),
                                                          ),

                                                          borderSide: BorderSide(
                                                            color: Colors.blue,
                                                            //Color of the border
                                                            style:
                                                            BorderStyle.solid,
                                                            //Style of the border
                                                            width:
                                                            2.0, //width of the border
                                                          ),
                                                          onPressed: () {
                                                            if(_appointmentList.isEmpty){

                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>  ArtAppointmentView(widget.person.id, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)
                                                                ),
                                                              );
                                                            }else{
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>  ArtAppointmentsOverview(_appointmentList, widget.person, widget.person.id, widget.visitId, widget.htsRegistration, widget.htsId)
                                                                  ));
                                                            }

                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16.0,
                                                            horizontal: 20.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  5.0)),
                                                          color: Colors.white,
                                                          padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                vertical: 8.0,
                                                                horizontal:
                                                                30.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize.max,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: <Widget>[
                                                                // three line description
                                                                Container(
                                                                  alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                                  child: Text(
                                                                    'TB Screening',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                      fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                      color: Colors
                                                                          .black87,
                                                                    ),
                                                                  ),
                                                                ),

                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      top: 3.0),
                                                                ),

                                                                Divider(
                                                                  height: 10.0,
                                                                  color: Colors.blue
                                                                      .shade500,
                                                                ),
                                                                Container(
                                                                  height: 2.0,
                                                                  color:
                                                                  Colors.blue,
                                                                ),

                                                                tbScreeningobj ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          feverString,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.confirmation_number, color: Colors.blue),
                                                                            labelText: "Fever",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          coughingString,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.calendar_today, color: Colors.blue),
                                                                            labelText: "Coughing",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                tbScreeningobj ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          weightLossString,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.ac_unit, color: Colors.blue),
                                                                            labelText: "Weight Loss",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          nightSweatsString,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                            labelText: "Night Sweats",
                                                                            //hintText: "National ID"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                tbScreeningobj ==
                                                                    null
                                                                    ? Center(
                                                                  child: Text(
                                                                    'No Record',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        13.0,
                                                                        color:
                                                                        Colors.black54),
                                                                  ),
                                                                )
                                                                    : Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding:
                                                                        const EdgeInsets.only(right: 16.0),
                                                                        child:
                                                                        TextFormField(
                                                                          initialValue:
                                                                          bmiUnderSeventeenString,
                                                                          decoration:
                                                                          InputDecoration(
                                                                            icon: Icon(Icons.ac_unit, color: Colors.blue),
                                                                            labelText: "BMI Under Seventeen ?",
                                                                            // hintText: "Sex"
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Divider(
                                                                  height: 10.0,
                                                                  color: Colors.blue
                                                                      .shade500,
                                                                ),
                                                                Container(
                                                                  height: 2.0,
                                                                  color:
                                                                  Colors.blue,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          borderSide: BorderSide(
                                                            color: Colors.blue,
                                                            //Color of the border
                                                            style:
                                                            BorderStyle.solid,
                                                            //Style of the border
                                                            width:
                                                            2.0, //width of the border
                                                          ),
                                                          onPressed: () {
                                                            if(tbScreeningobj == null){
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>   TbScreeningView(widget.person, widget.person.id, widget.visitId, widget.htsRegistration, widget.htsId)
                                                                ),
                                                              );

                                                            }else{
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>     TbScreeningOverview(tbScreeningobj, widget.person.id, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)

                                                                ),
                                                              );

                                                            }

                                                          },
                                                        ),
                                                      ),
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
            text: "ART VISIT",
            onTap: () =>   {
            if(_artVisit.visitType == null ){
        Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ArtVisitView(widget.person, widget.person.id, widget.visitId, widget.htsId, widget.htsRegistration)),
      )
        } else {
    Navigator.push(context,MaterialPageRoute(
    builder: (context)=>  ArtVisitOverview(this._artVisit, widget.person.id, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)

    ))
    }

            }
          ),
          new RoundedButton(
            text: "FOLLOW UP ",
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>   ArtFollowUpView(widget.person.id, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)


              ));
            }/*=>{
              if(_artIpt == null){
              Navigator.push(context,
              MaterialPageRoute(
                  builder: (context)=>    ArtIptStatusView(widget.person, widget.person.id, widget.visitId, widget.htsId, widget.htsRegistration)

              ))

              }else{

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArtIptStatusOverview(_artIpt, widget.person, widget.person.id, widget.visitId, widget.htsRegistration, widget.htsId)),
                ),

              }
            }*/
          ),
          new RoundedButton(
              text: "ART SYMPTOMS",
              onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>   ArtSymptoms(widget.person.id, widget.htsId, widget.htsRegistration, widget.visitId,
                              widget.person)));


              }),
          new RoundedButton(
              text: "ART NEW OI",
              onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>   ArtNewOI(widget.person.id, widget.htsId, widget.htsRegistration, widget.visitId,
                              widget.person)));

              }),
        ],
      ),
    );
  }
}
