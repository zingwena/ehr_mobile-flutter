import 'dart:convert';

import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/artdto.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/htsscreening.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/model/patientsummarydto.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/art_summary_overview.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';
import 'package:ehr_mobile/view/hiv_services_index_contact_page.dart';
import 'package:ehr_mobile/view/htsscreeningoverview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/recency.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'art_reg.dart';
import 'hts_screening.dart';

class SummaryOverview extends StatefulWidget {
  final Person person;
  final String visitId;
  final String htsId;
  final HtsRegistration htsRegistration;

  SummaryOverview(this.person, this.visitId, this.htsRegistration, this.htsId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SummaryOverviewState();
  }
}

class SummaryOverviewState extends State<SummaryOverview>
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
  bool eligibel_for_recency = false;
  bool eligible_for_index = false;
  String indextestid;
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const visitChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/visitChannel');
  static const dataChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const artChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');

  String facility_name;

  @override
  void initState() {
    getHtsScreeningRecord(widget.person.id);
    getPatientSummary(widget.person.id);
    getArt(widget.person.id);
    getAge(widget.person);
    eligibleForRecency(widget.person.id);
    eligibleForIndex(widget.person.id);
    getIndexTestByPersonId(widget.person.id);
    getFacilityName();
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  Future<void> getArt(String personId) async {
    String response;
    try {
      response = await artChannel.invokeMethod('getArt', personId);
      setState(() {
        this.artdto = Artdto.fromJson(jsonDecode(response));
        print(
            "THIS IS THE ARTDTO RETRIEVED @@@@@@@@@@@@@@ " + artdto.toString());
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

  Future<void> eligibleForRecency(String patientId) async {
    bool eligibleForRecency_response;
    try {
      eligibleForRecency_response =
      await htsChannel.invokeMethod('eligibleForRecency', patientId);
     print("HERE IS THE RESPONSE FROM RECENCY ELIGIBILITY"+ eligibleForRecency_response.toString());
      setState(() {
        eligibel_for_recency = eligibleForRecency_response;
        print("ELIGIBILITY FOR RECENCY BOOLEAN "+ eligibleForRecency_response.toString());

      });
    } catch (e) {
      print("channel failure at hts screening: '$e'");
    }
  }

  Future<void> eligibleForIndex(String patientId) async {
    bool eligibility_for_index;
    try {
      eligibility_for_index =
      await htsChannel.invokeMethod('eligibleForIndex', patientId);
      print("HERE IS THE RESPONSE FROM INDEX ELIGIBILITY"+ eligibility_for_index.toString());
      setState(() {
        eligible_for_index = eligibility_for_index;
        print("ELIGIBILITY FOR INDEX BOOLEAN "+ eligibility_for_index.toString());

      });
    } catch (e) {
      print("channel failure at hts screening: '$e'");
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
      });
    } catch (e) {
      print("channel failure at Patient summary dto method: '$e'");
    }
  }

  Future<void>saveIndexTest(IndexTest indexTest)async{
    var response ;
    try{
      response = await htsChannel.invokeMethod('saveIndexTest', jsonEncode(indexTest));
      setState(() {
        indextestid = response;

      });

    }catch(e){
      print("channel failure: '$e'");

    }

  }

  Future<void>  getIndexTestByPersonId(String personId)async{
    var response ;

    try{
      response = await htsChannel.invokeMethod('getIndexTestByPersonId', personId);
      print("INdex test id sent from android "+ response);
      setState(() {
        indextestid = response;
        print("Index test id after response");
      });

    }catch(e){
      print("channel failure: '$e'");



    }

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
              SizedBox(width: 5.0,),
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
                              MaterialPageRoute(builder: (context) => LoginScreen()),),
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
                      "Summary",
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
                                                                'Reception Vitals Overview',
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
                                                            patientSummaryDto !=
                                                                    null
                                                                ? Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                          padding: EdgeInsets.all(
                                                                              3.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                'BP',
                                                                                style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                              ),
                                                                              patientSummaryDto.bloodPressure == null
                                                                                  ? Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Text(
                                                                                        'No Record',
                                                                                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                      ),
                                                                                    )
                                                                                  : Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            patientSummaryDto.bloodPressure.value.toString(),
                                                                                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                          ),
                                                                                          Text(
                                                                                            'Recorded :' + DateFormat("yyyy/MM/dd").format(patientSummaryDto.bloodPressure.date),
                                                                                            style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          padding: EdgeInsets.all(
                                                                              3.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                'Temp',
                                                                                style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                              ),
                                                                              patientSummaryDto.temperature == null
                                                                                  ? Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Text(
                                                                                        'No Record',
                                                                                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                      ),
                                                                                    )
                                                                                  : Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            patientSummaryDto.temperature.value.toString(),
                                                                                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                          ),
                                                                                          Text(
                                                                                            'Recorded :' + DateFormat("yyyy/MM/dd").format(patientSummaryDto.temperature.date),
                                                                                            style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          padding: EdgeInsets.all(
                                                                              3.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                'Pulse',
                                                                                style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                              ),
                                                                              patientSummaryDto.pulse == null
                                                                                  ? Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Text(
                                                                                        'No Record',
                                                                                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                      ),
                                                                                    )
                                                                                  : Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            patientSummaryDto.pulse.value.toString(),
                                                                                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                          ),
                                                                                          Text(
                                                                                            'Recorded :' + DateFormat("yyyy/MM/dd").format(patientSummaryDto.pulse.date),
                                                                                            style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  )
                                                                : Center(
                                                                    child: Text(
                                                                        'No Records'),
                                                                  ),
                                                            Divider(
                                                              height: 10.0,
                                                              color: Colors.blue
                                                                  .shade500,
                                                            ),

                                                            patientSummaryDto !=
                                                                    null
                                                                ? Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                          padding: EdgeInsets.all(
                                                                              3.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                'Respiratory Rate',
                                                                                style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                              ),
                                                                              patientSummaryDto.respiratoryRate == null
                                                                                  ? Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Text(
                                                                                        'No Record',
                                                                                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                      ),
                                                                                    )
                                                                                  : Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            patientSummaryDto.respiratoryRate.value.toString(),
                                                                                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                          ),
                                                                                          Text(
                                                                                            'Recorded :' + DateFormat("yyyy/MM/dd").format(patientSummaryDto.respiratoryRate.date),
                                                                                            style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          padding: EdgeInsets.all(
                                                                              3.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                'Height ',
                                                                                style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                              ),
                                                                              patientSummaryDto.height == null
                                                                                  ? Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Text(
                                                                                        'No Record',
                                                                                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                      ),
                                                                                    )
                                                                                  : Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            patientSummaryDto.height.value.toString(),
                                                                                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                          ),
                                                                                          Text(
                                                                                            'Recorded :' + DateFormat("yyyy/MM/dd").format(patientSummaryDto.height.date),
                                                                                            style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                            ],
                                                                          )),
                                                                      Container(
                                                                          padding: EdgeInsets.all(
                                                                              3.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                'Weight',
                                                                                style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                              ),
                                                                              patientSummaryDto.weight == null
                                                                                  ? Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Text(
                                                                                        'No Record',
                                                                                        style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                      ),
                                                                                    )
                                                                                  : Container(
                                                                                      margin: EdgeInsets.only(top: 3.0),
                                                                                      child: Column(
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            patientSummaryDto.weight.value.toString(),
                                                                                            style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                                          ),
                                                                                          Text(
                                                                                            'Recorded :' + DateFormat("yyyy/MM/dd").format(patientSummaryDto.weight.date),
                                                                                            style: TextStyle(fontSize: 13.0, color: Colors.black54),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                            ],
                                                                          )),
                                                                    ],
                                                                  )
                                                                : Center(
                                                                    child: Text(
                                                                        'No Records'),
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
                                                            2.0,
                                                        //width of the border
                                                      ),
                                                      onPressed: (){},
                                                  
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
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
                                                                'Investigations Overview',
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
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child: patientSummaryDto ==
                                                                      null ||
                                                                      patientSummaryDto
                                                                          .investigations
                                                                          .isEmpty
                                                                      ? Container(
                                                                      alignment: Alignment
                                                                          .topLeft,
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        Text(
                                                                          'No Record',
                                                                          style: TextStyle(fontSize: 15.0, color: Colors.black87),
                                                                        ),
                                                                      ))
                                                                      : Container(
                                                                    width:
                                                                    double.infinity,
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical: 0.0,
                                                                        horizontal: 30.0),
                                                                    child: DataTable(
                                                                        columns: [
                                                                          DataColumn(label: Text("Date")),
                                                                          DataColumn(label: Text("Test Name")),
                                                                          DataColumn(label: Text("Result")),
                                                                        ],
                                                                        rows: patientSummaryDto.investigations
                                                                            .map((investigation) => DataRow(cells: [
                                                                          DataCell(Text(DateFormat("yyyy/MM/dd").format(investigation.testDate))),
                                                                          DataCell(Text(investigation.testName)),
                                                                          DataCell(Text(investigation.result)),
                                                                        ]))
                                                                            .toList()),
                                                                  ),
                                                                ),


                                                              ],
                                                            ),

                                                            Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: <
                                                                  Widget>[
                                                                eligibel_for_recency?Expanded(
                                                                  child:
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                        0.0,
                                                                        horizontal:
                                                                        10.0),
                                                                    child: RaisedButton(
                                                                      //onPressed: () {},
                                                                        color: Colors.blue,
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 10,
                                                                              right: 10,
                                                                              top: 1,
                                                                              bottom: 1),
                                                                          child:
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Icon(
                                                                                Icons.edit_attributes,
                                                                                color: Colors.white,
                                                                              ),
                                                                              Spacer(),
                                                                              Text(
                                                                                'Offer Recency Testing',
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => RecencyTest(
                                                                                      widget.person.id,
                                                                                      widget.visitId,
                                                                                      widget.person,
                                                                                      widget.htsId,
                                                                                      widget.htsRegistration)));
                                                                        }),
                                                                  ),
                                                                ): SizedBox(height: 0.0, width: 0.0,),
                                                                eligible_for_index ?Expanded(
                                                                  child:
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical:
                                                                        0.0,
                                                                        horizontal:
                                                                        10.0),
                                                                    child: RaisedButton(
                                                                        color: Colors.blue,
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 2,
                                                                              right: 2,
                                                                              top: 1,
                                                                              bottom: 1),
                                                                          child:
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Icon(
                                                                                Icons.format_list_numbered,
                                                                                color: Colors.white,
                                                                              ),
                                                                              Spacer(),
                                                                              Text(
                                                                                'Index Contact List ',
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        onPressed: () {
                                                                          //getIndexTestByPersonId(widget.person.id);
                                                                          if(indextestid == null){
                                                                            IndexTest indexTest = IndexTest(widget.person.id, DateTime.now());
                                                                            saveIndexTest(indexTest);
                                                                            Navigator.push(context,MaterialPageRoute(
                                                                                builder: (context)=> HIVServicesIndexContactList(widget.person,null, widget.visitId, widget.htsId, null, widget.person.id, indextestid)
                                                                            ));
                                                                          }else{
                                                                            print("INDEX TEST FOUND");
                                                                            Navigator.push(context,MaterialPageRoute(
                                                                                builder: (context)=> HIVServicesIndexContactList(widget.person,null, widget.visitId, widget.htsId, null, widget.person.id, indextestid)
                                                                            ));
                                                                          }
                                                                        }),
                                                                  ),
                                                                ): SizedBox(height: 0.0, width: 0.0,),
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
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
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
                                                                'ART Overview',
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

                                                            patientSummaryDto ==
                                                                        null ||
                                                                    patientSummaryDto
                                                                            .artDetails.artNumber ==
                                                                        null
                                                                ? Center(
                                                                    child: Text(
                                                                      'No Record',
                                                                      style: TextStyle(fontSize: 15.0, color: Colors.black87),
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
                                                                                patientSummaryDto.artDetails.artNumber,
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
                                                                          padding: const EdgeInsets.only(right: 16.0),
                                                                          child:   DateFormat("yyyy/MM/dd").format(patientSummaryDto.artDetails.dateRegistered) ==  DateFormat("yyyy/MM/dd").format(DateTime.utc(2020, 1, 1))?TextFormField(
                                                                            initialValue: '',
                                                                            decoration: InputDecoration(
                                                                              icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                              labelText: "Registration Date",
                                                                            ),
                                                                          ):TextFormField(
                                                                            initialValue:  DateFormat("yyyy/MM/dd").format(patientSummaryDto.artDetails.dateRegistered),
                                                                            decoration: InputDecoration(
                                                                              icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                              labelText: "Registration Date",

                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                            patientSummaryDto ==
                                                                        null ||
                                                                    patientSummaryDto
                                                                            .artDetails.artNumber ==
                                                                        null
                                                                ? Center(
                                                                    child: Text(
                                                                      'No Record',
                                                                      style: TextStyle(fontSize: 15.0, color: Colors.black87),
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
                                                                                patientSummaryDto.artDetails.whoStage,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              icon: Icon(Icons.ac_unit, color: Colors.blue),
                                                                              labelText: "WHO Stage Levels",
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
                                                                                patientSummaryDto.artDetails.arvRegimen,
                                                                            decoration:
                                                                                InputDecoration(
                                                                              icon: Icon(Icons.perm_contact_calendar, color: Colors.blue),
                                                                              labelText: "Regimen",
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
                                                    /*    Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>   ArtSummaryOverview(widget.person, widget.visitId, widget.htsRegistration, widget.htsId)

                                                            ));*/
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
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
            text: "DEMOGRAPHICS",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Overview(widget.person)),
            ),
          ),
          new RoundedButton(
            text: "VITALS",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReceptionVitals(widget.person.id,
                      widget.visitId, widget.person, widget.htsId)),
            ),
          ),
          new RoundedButton(
              text: "HTS",
              onTap: () {
                if (htsScreening == null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Hts_Screening(
                              widget.person.id,
                              widget.htsId,
                              widget.htsRegistration,
                              widget.visitId,
                              widget.person)));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HtsScreeningOverview(
                              widget.person,
                              htsScreening,
                              widget.htsId,
                              widget.visitId,
                              widget.person.id)));
                }
              }),
          new RoundedButton(
              text: "ART",
              onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>   ArtSummaryOverview(widget.person, widget.visitId, widget.htsRegistration, widget.htsId)

                      ));

              }),
        ],
      ),
    );
  }
}
