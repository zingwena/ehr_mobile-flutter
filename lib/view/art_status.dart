import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/model/artRegistration.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';


class ArtStatus extends StatefulWidget {
  String personId;
  String visitId;
  Person person;
  HtsRegistration htsRegistration;

  String htsId;
  ArtStatus();


  @override
  State createState() {
    return _ArtStatus();
  }
}

class _ArtStatus extends State<ArtStatus> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final MethodChannel addPatient =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  static const dataChannel =  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  String oi_art_number;
  ArtRegistration _artRegistration;
  var dateOfTest,dateOfInitiation, displayDate;
  DateTime enrollment_date, test_date;
  String _nationalIdError = "National Id number is invalid";
  Age age;

  String facility_name;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasonIdentified;
  List<DropdownMenuItem<String>> _dropDownMenuItemsArvRegimenIdentified;
  List<DropdownMenuItem<String>> _dropDownMenuItemsAdverseEventListIdentified;

  List _arvRegimenIdentified = ["ARV Regimen 1", "ARV Regimen 2", "ARV Regimen 3", "ARV Regimen 4" ];
  List _reasonIdentified = ["Reason 1", "Reason 2", "Reason 3", "Reason 4" ];
  List _adverseEventStatusIdentified = ["Adverse Event Status 1", "Adverse Event Status 2", "Adverse Event Status 3", "Adverse Event Status 4" ];

  int _noARV = 0;
  int _startARV = 0;
  int _continue = 0;
  int _change = 0;
  int _stop = 0;
  int _restart = 0;
  int _pmtct = 0;
  String noARV = "";
  String startARV = "";
  String Continue = "";
  String change = "";
  String stop = "";
  String restart = "";
  String pmtct = "";

  String retestedBeforeArt = "";

  String  _currentArvRegimen, _currentReason, _currentAdverseEventStatus ;

  bool selfIdentifiedArvRegimenIsValid=false;
  bool selfIdentifiedReasonIsValid=false;
  bool selfIdentifiedAdverseEventIsValid=false;

  @override
  void initState() {
    displayDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfInitiation = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfTest = DateFormat("yyyy/MM/dd").format(DateTime.now());
    test_date = DateTime.now();
    enrollment_date = DateTime.now();
    getAge(widget.person);
    getFacilityName();
    _dropDownMenuItemsArvRegimenIdentified = getDropDownMenuItemsArvRegimenList();
    _dropDownMenuItemsReasonIdentified = getDropDownMenuItemsReason();
    _dropDownMenuItemsAdverseEventListIdentified = getDropDownMenuItemsAdverseEvents();
    super.initState();
  }



  Future<Null> _selectDateOfInitiation(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateOfTest)
      setState(() {
        dateOfTest = DateFormat("yyyy/MM/dd").format(picked);
        test_date = DateFormat("yyyy/MM/dd").parse(dateOfTest);
      });
  }


  Future<Null> _selectDateOfEnrollment(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateOfTest)
      setState(() {
        dateOfInitiation = DateFormat("yyyy/MM/dd").format(picked);
        enrollment_date = DateFormat("yyyy/MM/dd").parse(dateOfInitiation);
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
  Future<void>getAge(Person person)async{
    String response;
    try{
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
        print("THIS IS THE AGE RETRIEVED"+ age.toString());
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
  }


  List<DropdownMenuItem<String>> getDropDownMenuItemsArvRegimenList() {
    List<DropdownMenuItem<String>> items = new List();
    for (String arvRegimenIdentified in _arvRegimenIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: arvRegimenIdentified, child: Text(arvRegimenIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsReason() {
    List<DropdownMenuItem<String>> items = new List();
    for (String reasonIdentified in _reasonIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: reasonIdentified, child: Text(reasonIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsAdverseEvents() {
    List<DropdownMenuItem<String>> items = new List();
    for (String adverseEventStatusIdentified in _adverseEventStatusIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: adverseEventStatusIdentified, child: Text(adverseEventStatusIdentified)));
    }
    return items;
  }

  void _handleNoARVChange (int value) {
    setState(() {
      _noARV = value;

      switch (_noARV) {
        case 1:
          noARV = "ARV Change";
          break;

      }
    });
  }

  void _handleStartARVChange (int value) {
    setState(() {
      _startARV = value;

      switch (_startARV) {
        case 1:
          startARV = "Start ARV";
          break;
      }
    });
  }

  void _handleContinueChange(int value) {
    setState(() {
      _continue = value;

      switch (_continue) {
        case 1:
          Continue = "Continue";
          break;

      }
    });
  }

  void _handleChangeChange(int value) {
    setState(() {
      _change = value;

      switch (_change) {
        case 1:
          change = "Change";
          break;

      }
    });
  }

  void _handleStopChange(int value) {
    setState(() {
      _stop = value;

      switch (_stop) {
        case 1:
          stop = "Stop";
          break;

      }
    });
  }

  void _handleRestartChange(int value) {
    setState(() {
      _restart = value;

      switch (_restart) {
        case 1:
          restart = "Restart";
          break;

      }
    });
  }

  void _handlePmtctChange(int value) {
    setState(() {
      _pmtct = value;

      switch (_pmtct) {
        case 1:
          pmtct = "PMTCT";
          break;

      }
    });
  }

  String _selfArvRegimenError="Select ARV Regimen";
  String _selfReasonError="Select Reason";
  String _selfAdverseEventStatusError="Select Adverse Event Status";


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
                    child: Text("ART Status", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                  /*  Container(
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
                  ),  */
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

                                                  Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[

                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('ARV Status'),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),


                                                      ]),

                                                  Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[

                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('No ARV'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _noARV,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleNoARVChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Start ARV'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child:  Radio(
                                                                    value: 1,
                                                                    groupValue: _startARV,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleStartARVChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),

                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Continue'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _continue,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleContinueChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Change'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _change,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleChangeChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                      ]),


                                                  Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Stop'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _stop,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleStopChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('Restart'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _restart,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handleRestartChange),
                                                              ),
                                                            ),

                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),

                                                        Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 90.0 ),
                                                                child: Text('PMTCT PROPHLAXIS'),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(right: 16.0),
                                                                child: Radio(
                                                                    value: 1,
                                                                    groupValue: _pmtct,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: _handlePmtctChange),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ] ),

                                                  SizedBox(
                                                    height: 10.0,
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
                                                                    text: dateOfTest),
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
                                                                    labelText: "Date Of Initiation"),
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
                                                          hint:Text("ARV Regimen"),
                                                          iconEnabledColor: Colors.black,
                                                          value: _currentArvRegimen,
                                                          items: _dropDownMenuItemsArvRegimenIdentified,
                                                          onChanged: changedDropDownItemReferring,
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
                                                          hint:Text("Reason"),
                                                          iconEnabledColor: Colors.black,
                                                          value: _currentReason,
                                                          items: _dropDownMenuItemsReasonIdentified,
                                                          onChanged: changedDropDownItemReason,
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
                                                          hint:Text("Adverse Event Status"),
                                                          iconEnabledColor: Colors.black,
                                                          value: _currentAdverseEventStatus ,
                                                          items: _dropDownMenuItemsAdverseEventListIdentified,
                                                          onChanged: changedDropDownItemAdverseEventStatus,
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
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          _formKey
                                                              .currentState
                                                              .save();
                                                          setState(() {
                                                          /*  ArtRegistration artRegistrationDetails = ArtRegistration(widget.personId, enrollment_date, test_date, oi_art_number);
                                                            artRegistration(artRegistrationDetails);
                                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ArtRegOverview(artRegistrationDetails, widget.personId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)));
*/

                                                          });
                                                        }
                                                      },
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

  Future<void> artRegistration(ArtRegistration artRegistration) async {
    String art_registration_response;
    try {
      print('pppppppppppppppppppppppppppppppppppp art regmethod');

      art_registration_response = await artChannel.invokeMethod(
          'saveArtRegistration', jsonEncode(artRegistration.toJson()));
      print('pppppppppppppppppppppppppppppppppppp art response'+ art_registration_response);
      setState(() {
        _artRegistration = ArtRegistration.fromJson(jsonDecode(art_registration_response));
        print('FFFFFFFFFFFFFFFFFFFFFFF'+ _artRegistration.toString());
      });

    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }

  void changedDropDownItemReferring(String selectedArvRegimenIdentified) {
    setState(() {
      _currentArvRegimen = selectedArvRegimenIdentified;
      selfIdentifiedArvRegimenIsValid=!selfIdentifiedArvRegimenIsValid;
      _selfArvRegimenError=null;
    });
  }

  void changedDropDownItemReason(String selectedReasonIdentified) {
    setState(() {
      _currentReason = selectedReasonIdentified;
      selfIdentifiedReasonIsValid=!selfIdentifiedReasonIsValid;
      _selfReasonError=null;
    });
  }

  void changedDropDownItemAdverseEventStatus(String selectedAdverseEventIdentified) {
    setState(() {
      _currentAdverseEventStatus = selectedAdverseEventIdentified;
      selfIdentifiedAdverseEventIsValid=!selfIdentifiedAdverseEventIsValid;
      _selfAdverseEventStatusError=null;
    });
  }
}
