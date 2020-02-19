import 'dart:convert';

import 'package:ehr_mobile/model/artappointment.dart';
import 'package:ehr_mobile/model/artfollowupcall.dart';
import 'package:ehr_mobile/model/followupreason.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/model/reason.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/artappointmentOverview.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/model/artRegistration.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';

import 'art_summary_overview.dart';


class ArtFollowUpView extends StatefulWidget {
  String personId;
  String visitId;
  Person person;
  HtsRegistration htsRegistration;
  String htsId;
  ArtFollowUpView(this.personId, this.visitId, this.person, this.htsRegistration, this.htsId);


  @override
  State createState() {
    return _ArtFollowUp();
  }
}

class _ArtFollowUp extends State<ArtFollowUpView> {
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
  ArtFollowUpCall artFollowUpCallResponse;
  String facility_name;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasonIdentified;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasons;
  List<FollowUpReason> _reasonList = List();
  String _reason;
  int _followUpType;
  bool typeSelected = false;
  String followUpTypeString;
  bool showTypeError = false;
  List reasons = List();
  List _dropDownListReasons = List();
  String  _currentAppointmentReason;
  bool selfIdentifiedAppointmentReasonIsValid=false;
  String _appointmetnt_string;
  List appointmnents = List();
  List _dropDownListAppointments= List();
  List<ArtAppointment> _appointmentList = List();



  @override
  void initState() {
    displayDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfAppointment = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfAppointment = DateFormat("yyyy/MM/dd").format(DateTime.now());
    test_date = DateTime.now();
    enrollment_date = DateTime.now();
    getArtAppointment(widget.personId);
    getFacilityName();
    getFolloUpReasons();

    super.initState();
  }



  Future<void> getFolloUpReasons() async {
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
        print("TEST DATE TO BE SENT IS THIS ONE"+ test_date.toString());
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
        artAppointmentDto = ArtAppointment.fromJson(jsonDecode(hts));
        print("HERE IS THE art appointment >>>>>>>>>>>> AFTER ASSIGNMENT " + artAppointmentDto.toString());
      });
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
                    child: Text("ART Follow Up", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                  _buildButtonsRow(),
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
                                                                    labelText: "Date Of Follow Up"),
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

                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 90.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding( padding: EdgeInsets.symmetric( vertical: 8.0, horizontal: 30.0 ),
                                                              child: Text('Follow Up Type'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('VISIT'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _followUpType,
                                                            onChanged: _handleFollowUpChange),
                                                        Text('CALL'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _followUpType,
                                                            onChanged: _handleFollowUpChange)
                                                      ],
                                                    ),
                                                  ),

                                                  showTypeError == true ? Container(
                                                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 95),
                                                    child: Text("Select Follow Up type ", style: TextStyle(color: Colors.red, fontSize: 15),),
                                                  ):SizedBox(height: 0.0, width: 0.0,),


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
                                                          hint:Text("Follow Up  Outcome"),
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
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Text('Save', style: TextStyle(color: Colors.white),),
                                                            Spacer(),
                                                            Icon(Icons.save_alt, color: Colors.white, ),
                                                          ],
                                                        ),
                                                        onPressed: () async{
                                                          ArtFollowUpCall artfollowUpObj =  ArtFollowUpCall(null,artAppointmentDto.id, _currentAppointmentReason, test_date, followUpTypeString);
                                                          await artFollowUpReg(artfollowUpObj);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) =>   ArtAppointmentsOverview(this._appointmentList, widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId)
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "ART Follow Up",
            selected: true,
          ),

          /* new RoundedButton(
            text: "ART Initiation",
          ),
*/
          new RoundedButton(
              text: "Close",
              onTap: () =>    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArtSummaryOverview(widget.person, widget.visitId, widget.htsRegistration, widget.htsId)

                  ))
          ),
        ],
      ),
    );
  }

  Future<void> artFollowUpReg(ArtFollowUpCall artFollowUp) async {
    String art_appointment_response;
    try {

      art_appointment_response = await artChannel.invokeMethod('saveArtFollowUpCall', jsonEncode(artFollowUp));
      setState(() {
        artFollowUpCallResponse = ArtFollowUpCall.fromJson(jsonDecode(art_appointment_response));
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

  void changedDropDownItemAppointmentReason(String selectedArvRegimenIdentified) {
    setState(() {
      _currentAppointmentReason = selectedArvRegimenIdentified;
      selfIdentifiedAppointmentReasonIsValid=!selfIdentifiedAppointmentReasonIsValid;
      _selfAppointmentReasonError=null;
    });
  }

  void _handleFollowUpChange(int value) {
    print("hts value : $value");
    setState(() {
      _followUpType = value;

      switch (_followUpType) {
        case 1:
          followUpTypeString = "VISIT";
          typeSelected = true;

          break;
        case 2:
          followUpTypeString = "CALL";
          typeSelected = true;
          break;
      }
    });
  }



}
