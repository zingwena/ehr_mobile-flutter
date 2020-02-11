import 'dart:convert';

import 'package:ehr_mobile/model/artappointment.dart';
import 'package:ehr_mobile/model/followupreason.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/artappointmentOverview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/model/artRegistration.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';


class ArtAppointmentView extends StatefulWidget {
  String personId;
  String visitId;
  Person person;
  HtsRegistration htsRegistration;
  String htsId;
  ArtAppointmentView(this.personId, this.visitId, this.person, this.htsRegistration, this.htsId);


  @override
  State createState() {
    return _ArtAppointment();
  }
}

class _ArtAppointment extends State<ArtAppointmentView> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final MethodChannel addPatient =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  static const dataChannel =  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  String oi_art_number;
  ArtRegistration _artRegistration;
  var dateOfAppointment, displayDate;
  DateTime enrollment_date, test_date;
  String _nationalIdError = "National Id number is invalid";
  Age age;
 ArtAppointment artAppointmentDto;
 ArtAppointment artAppointmentResponse;
  String facility_name;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasonIdentified;

  List<DropdownMenuItem<String>> _dropDownMenuItemsReasons;
  List<FollowUpReason> _reasonList = List();
  String _reason;
  List reasons = List();
  List _dropDownListReasons = List();

  String  _currentAppointmentReason;

  bool selfIdentifiedAppointmentReasonIsValid=false;

  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  List<ArtAppointment> _entryPointList = List();



  @override
  void initState() {
    displayDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfAppointment = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfAppointment = DateFormat("yyyy/MM/dd").format(DateTime.now());
    test_date = DateTime.now();
    enrollment_date = DateTime.now();
    getArtAppointment(widget.personId);
    //getAge(widget.person);
    getFacilityName();
    getEntryPoints();

    super.initState();
  }



  Future<void> getEntryPoints() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getFollowUpReason');
      setState(() {
        _reason = response;
        reasons = jsonDecode(_reason);
        _dropDownListReasons = FollowUpReason.mapFromJson(reasons);
        _dropDownListReasons.forEach((e) {
          _reasonList.add(e);
        });
        print("LIST OF REASONS "+_reasonList.toString());
        _dropDownMenuItemsReasons = getDropDownMenuAppointmentReasonList();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  Future<Null> _selectDateOfInitiation(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateOfAppointment)
      setState(() {
        dateOfAppointment = DateFormat("yyyy/MM/dd").format(picked);
        test_date = DateFormat("yyyy/MM/dd").parse(dateOfAppointment);
      });
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

  Future<void> getArtAppointment(String patientId) async {
    var hts;
    try {
      hts = await artChannel.invokeMethod('getArtAppointment', patientId);
      setState(() {
        artAppointmentResponse = ArtAppointment.fromJson(jsonDecode(hts));
        print("HERE IS THE art appointments AFTER ASSIGNMENT " + artAppointmentResponse.toString());
      });
      print('HTS IN THE FLUTTER THE RETURNED ONE ' + hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  List<DropdownMenuItem<String>> getDropDownMenuAppointmentReasonList() {
    List<DropdownMenuItem<String>> items = new List();
    for (FollowUpReason entryPoint in _reasonList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: entryPoint.code, child: Text(entryPoint.name)));
    }
    print('HERE ARE THE ITEMS IN MAPPING DROP DOWN '+ items.toString());
    return items;
  }


  String _selfAppointmentReasonError="Select ARV Regimen";

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
            title: new Text(
              facility_name!=null?facility_name: 'Impilo Mobile',   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("ART Appointment", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                 /* Container(
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
                        *//*    Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Age -"+age.years.toString()+"years", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),*//*
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
                  ),*/
                 // _buildButtonsRow(),
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
                                              key: _formKey,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[

                                                  SizedBox(
                                                    height: 30.0,
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(0.0),
                                                              child: TextFormField(
                                                                controller: TextEditingController(
                                                                    text: dateOfAppointment),
                                                                validator: (value) {
                                                                  return value
                                                                      .isEmpty
                                                                      ? 'Enter some text'
                                                                      : null;
                                                                },
                                                                decoration: InputDecoration(
                                                                    border: OutlineInputBorder(
                                                                        borderRadius:
                                                                        BorderRadius.circular(0.0)),
                                                                    labelText: "Date Of Appointment"),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                        IconButton(
                                                            icon: Icon(Icons.calendar_today),
                                                            color:
                                                            Colors.blue,
                                                            onPressed: () {
                                                              _selectDateOfInitiation(
                                                                  context);
                                                            })
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 10.0,
                                                  ),

                                                  Container(
                                                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                                                    width: double.infinity,
                                                    child: OutlineButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5.0)),
                                                      color: Colors.white,
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                        child: DropdownButton(
                                                          isExpanded:true,
                                                          icon: Icon(Icons.keyboard_arrow_down),
                                                          hint:Text("Appointment Reason"),
                                                          iconEnabledColor: Colors.black,
                                                          value: _currentAppointmentReason,
                                                          items: _dropDownMenuItemsReasons,
                                                          onChanged: changedDropDownItemAppointmentReason,
                                                        ),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue, //Color of the border
                                                        style: BorderStyle.solid, //Style of the border
                                                        width: 2.0, //width of the border
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 25.0,
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0 ),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(5.0)),
                                                      color: Colors.blue,
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Text(
                                                        "Save",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      onPressed: () async{
                                                        ArtAppointment artAppointmentObj =  ArtAppointment(null, this.artAppointmentResponse.artId, _currentAppointmentReason, test_date);

                                                       await artappintmentReg(artAppointmentObj);
                                                       await getArtAppointments(widget.personId);

                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) =>   ArtAppointmentsOverview(this._entryPointList, widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId)
                                                          ), );

                                                       }
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 25.0,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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

  /* Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "ART Registration",
            selected: true,
          ),

          new RoundedButton(
            text: "ART Initiation",
          ),

          new RoundedButton(
            text: "Close",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPatient()),
            ),
          ),
        ],
      ),
    );
  } */

  Future<void> artappintmentReg(ArtAppointment artAppointment) async {
    String art_appointment_response;
    print("ART APPOINTMENT SAVE METHOD"+ artAppointment.toString());
    try {

      art_appointment_response = await artChannel.invokeMethod('saveArtAppointment', jsonEncode(artAppointment));
      setState(() {
        artAppointmentResponse = ArtAppointment.fromJson(jsonDecode(art_appointment_response));
      });

    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }

  Future<void> getArtAppointments(String  personId) async {
    var art_appointment_response;
    try {

      art_appointment_response = await artChannel.invokeMethod(
          'getArtAppointments', personId);
      setState(() {
        _entryPoint = art_appointment_response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = ArtAppointment.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
        print("DDDDDDDDDDDDD ART APPOINTMENTS HERE"+ _entryPointList.toString());
      });

    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }

  void changedDropDownItemAppointmentReason(String selectedArvRegimenIdentified) {
    setState(() {
      _currentAppointmentReason = selectedArvRegimenIdentified;
      selfIdentifiedAppointmentReasonIsValid=!selfIdentifiedAppointmentReasonIsValid;
      _selfAppointmentReasonError=null;
    });
  }



}
