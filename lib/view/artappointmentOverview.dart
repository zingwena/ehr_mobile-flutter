import 'dart:convert';
import 'package:ehr_mobile/model/artadverseevent.dart';
import 'package:ehr_mobile/model/artappointment.dart';
import 'package:ehr_mobile/model/artvisit.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/artInitiation.dart';
import 'package:ehr_mobile/model/tbscreening.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/art_Visit_Overview.dart';
import 'package:ehr_mobile/view/art_visit.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/art_initiation.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/view/tb_screening.dart';
import 'package:ehr_mobile/vitals/visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';
import 'artFollowUp.dart';
import 'rounded_button.dart';
import 'home_page.dart';

import 'hts_testscreening.dart';
import 'hts_registration.dart';

import 'reception_vitals.dart';
import 'package:ehr_mobile/model/artRegistration.dart';

class ArtAppointmentsOverview extends StatefulWidget {
  final List<ArtAppointment> artAppointment;
  final Person person;
  final String personId;
  final String visitId;
  final String htsId;
  final HtsRegistration htsRegistration;
  ArtAppointmentsOverview(this.artAppointment, this.person, this.personId, this.visitId, this.htsRegistration, this.htsId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ArtAppointmentOverviewState();
  }
}

class ArtAppointmentOverviewState extends State<ArtAppointmentsOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _entrypoint;
  String regimen_name;
  String art_reason;
  Age age;
  bool showInput = true;
  bool showInputTabOptions = true;
  String facility_name;
  ArtVisit _artVisit;
  var dateOfAppointment, displayDate;


  @override
  void initState() {

    print(_patient.toString());
    getArtVist(widget.personId);

    //  getEntryPoint(widget.htsRegistration.entryPointId);
    getAge(widget.person);
    getFacilityName();
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
  Future<void> getRegimen(String regId) async {
    String regimenname;

    try {
      regimenname =
      await artChannel.invokeMethod('getRegimenName', regId);


    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      regimen_name = regimenname;
    });


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
  Future<void> getReason(String reasonId) async {
    String reason;

    try {
      reason =
      await artChannel.invokeMethod('getReason', reasonId);
      setState(() {
        art_reason = reason;
      });



    } catch (e) {
      print("channel failure: '$e'");
    }


  }
  Future<void>getAge(Person person)async{
    String response;
    try{
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
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

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId),
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
                    child: Text("ART Appointment OverView", style: TextStyle(
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
                                                              child: widget.artAppointment.isEmpty
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
                                                                      DataColumn(label: Text("")),
                                                                    ],
                                                                    rows: widget.artAppointment
                                                                        .map((appointment) => DataRow(cells: [
                                                                      DataCell(Text(DateFormat("yyyy/MM/dd").format(appointment.date))),
                                                                      DataCell(Text(appointment.reason)),
                                                                      DataCell(    Padding(
                                                                          padding: const EdgeInsets.only(right: 0),
                                                                          child: RaisedButton(
                                                                            onPressed: () {
                                                                              Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(builder: (context) =>  ArtFollowUpView(widget.person.id, widget.visitId, widget.person, widget.htsRegistration, widget.htsId, appointment.id)));

                                                                            },
                                                                            color: Colors.blue,
                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(left: 15, right: 15, top: 1, bottom: 1),
                                                                              child: Text('Follow Up',
                                                                                style: TextStyle(
                                                                                    fontSize: 13.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          )),


                                                                      ),

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
                                                  onPressed: () {},
                                                ),
                                              ),
                                          /*    Form(
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
                                                                    text: dateOfAppointment),
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons.date_range, color: Colors.blue),
                                                                    labelText: "Date",
                                                                    hintText: "Date"
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
                                                                        widget.artAppointment.reason)),
                                                                decoration: InputDecoration(
                                                                    icon: new Icon(Icons.credit_card, color: Colors.blue),
                                                                    labelText: "Reason",
                                                                    hintText: "Reason"
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
                                                                        art_reason)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Art reason',
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
                                              )*/
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

          new RoundedButton(text: "ART Appointment",selected: true,),
          new RoundedButton(text: "TB Screening", onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TbScreeningView(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId),
            ));

          },
          ),
          new RoundedButton(text: "Close", onTap: () {

            if(_artVisit.visitType == null ){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ArtVisitView(widget.person, widget.personId, widget.visitId, widget.htsId, widget.htsRegistration)),
              );
            } else {
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>  ArtVisitOverview(this._artVisit, widget.personId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)

              ));
            }
          }

            // ArtVisitView(this.person, this.personId, this.visitId, this.htsId, this.htsRegistration);

          ),


        ],
      ),
    );
  }

}






