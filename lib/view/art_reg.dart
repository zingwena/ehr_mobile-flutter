import 'dart:convert';

import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/artdto.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/namecode.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/question.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../sidebar.dart';
import 'rounded_button.dart';

class ArtReg extends StatefulWidget {
  String personId;
  String visitId;
  Person person;
  HtsRegistration htsRegistration;
  Artdto artdto;

  String htsId;

  ArtReg(this.artdto, this.personId, this.visitId, this.person,
      this.htsRegistration, this.htsId);

  @override
  State createState() {
    return _ArtReg();
  }
}

class _ArtReg extends State<ArtReg> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final MethodChannel addPatient =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const artChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  static const dataChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  String oi_art_number, program_number;
  Artdto _artRegistration;
  var dateOfTest, dateOfEnrollment, displayDate, dateOfRetest, dateHivConfirmed;
  DateTime enrollment_date, test_date, retest_date, hivConfirmation_date;
  String _nationalIdError = "National Id number is invalid";
  Age age;
  String facility_name;
  List<DropdownMenuItem<String>> _dropDownMenuItemsHivTestUsedIdentified;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReferringListIdentified;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasonForTest;
  List _referringListIdentified = [
    "EID",
    "HTS",
    "PMTCT",
    "STI",
    "TB_PROGRAM",
    "VMMC",
    "VIAC"
  ];
  List _hivTestUsedIdentified = ["AB", "PCR"];
  List _reasonForHivTestIdentified = [
    "Reason 1",
    "Reason 2",
    "Reason 3",
    "Reason 4"
  ];

  int _testingSite = 0;
  int _reTested = 0;
  String testingSite = "";
  bool retestedBeforeArt = false;
  String _currentReferringProgram, _currentHivTestUsed, _currentReasonForTest, _currentFacility;

  bool selfIdentifiedReferringIsValid = false;
  bool selfIdentifiedHIVTestIsValid = false;
  bool selfIdentifiedReasonForTestIsValid = false;
  bool selfIdentifiedFacilitysValid = false;
  bool healthfacility_change = false;

  String _reason;
  List reasons = List();
  List _dropDownListReasons = List();
  List<Question> _reasonList = List();
  NameCode testreason;
  bool otherSite = false;
  bool healthFacility = false;

  List<DropdownMenuItem<String>> _dropDownMenuItemsEntryPoint;
  List<NameCode> _entryPointList = List();
  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();

  @override
  void initState() {
    displayDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfEnrollment = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfTest = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfRetest = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateHivConfirmed = DateFormat("yyyy/MM/dd").format(DateTime.now());
    test_date = DateTime.now();
    enrollment_date = DateTime.now();
    retest_date = DateTime.now();
    hivConfirmation_date = DateTime.now();
    getAge(widget.person);
    getFacilityName();
    getHivReasonForTesting();
    getFacilities();
    _dropDownMenuItemsReferringListIdentified = getDropDownMenuItemsReferringList();
    _dropDownMenuItemsHivTestUsedIdentified = getDropDownMenuItemsHivTestUsed();
   // _dropDownMenuItemsReasonForTestListIdentified = getDropDownMenuItemsReasonForHivTest();
    _dropDownMenuItemsReasonForTest  =     getDropDownMenuItemsReasonsForHivTest();
    if(widget.artdto.facility != null){
      _testingSite = 1;
      healthFacility = true;

    }

    super.initState();
  }

  Future<Null> _selectDateOfHivTest(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateOfTest)
      setState(() {
        dateOfTest = DateFormat("yyyy/MM/dd").format(picked);
        test_date = DateFormat("yyyy/MM/dd").parse(dateOfTest);
      });
  }
  Future<void> getFacilities() async {
    String response;
    try {
      response = await dataChannel.invokeMethod('facilityOptions');
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = NameCode.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
        _dropDownMenuItemsEntryPoint =
            getDropDownMenuItemsIdentifiedEntryPoint();
        print("LLLLLLLLLLLLL list of facilities retrieved"+ _entryPointList.toString());
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  Future<void> getHivReasonForTesting() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getReasonForhivTest');
      setState(() {
        _reason = response;
        reasons = jsonDecode(_reason);
        _dropDownListReasons = Question.mapFromJson(reasons);
        _dropDownListReasons.forEach((e) {
          _reasonList.add(e);
        });
        _dropDownMenuItemsReasonForTest =
            getDropDownMenuItemsReasonsForHivTest();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  Future<Null> _selectDateOfEnrollment(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateOfEnrollment)
      setState(() {
        dateOfEnrollment = DateFormat("yyyy/MM/dd").format(picked);
        enrollment_date = DateFormat("yyyy/MM/dd").parse(dateOfEnrollment);
      });
  }

  Future<Null> _selectDateOfReTest(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateOfTest)
      setState(() {
        dateOfRetest = DateFormat("yyyy/MM/dd").format(picked);
        retest_date = DateFormat("yyyy/MM/dd").parse(dateOfRetest);
      });
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

  Future<Null> _selectDateHivConfirmed(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateHivConfirmed)
      setState(() {
        dateHivConfirmed = DateFormat("yyyy/MM/dd").format(picked);
        hivConfirmation_date = DateFormat("yyyy/MM/dd").parse(dateHivConfirmed);
      });
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
      debugPrint("Exception thrown in get facility name method" + e);
    }
  }


  List<DropdownMenuItem<String>> getDropDownMenuItemsReferringList() {
    List<DropdownMenuItem<String>> items = new List();
    for (String referringListIdentified in _referringListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: referringListIdentified,
          child: Text(referringListIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsHivTestUsed() {
    List<DropdownMenuItem<String>> items = new List();
    for (String hivTestIdentified in _hivTestUsedIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: hivTestIdentified, child: Text(hivTestIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedEntryPoint() {
    List<DropdownMenuItem<String>> items = new List();
    for (NameCode entryPoint in _entryPointList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: entryPoint.name, child: Text(entryPoint.name)));
    }
    return items;
  }

/*  List<DropdownMenuItem<String>> getDropDownMenuItemsReasonForHivTest() {
    List<DropdownMenuItem<String>> items = new List();
    for (String hivReasonIdentified in _reasonForHivTestIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: hivReasonIdentified, child: Text(hivReasonIdentified)));
    }
    return items;
  }*/

  List<DropdownMenuItem<String>> getDropDownMenuItemsReasonsForHivTest() {
    List<DropdownMenuItem<String>> items = new List();
    for (Question question in _reasonList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: question.code, child: Text(question.name)));
    }
    return items;
  }

  void _handleTestingSiteChange(int value) {
    setState(() {
      _testingSite = value;

      switch (_testingSite) {
        case 1:
          healthFacility = true;
          testingSite = "Health Facility";
          break;
        case 2:
          otherSite = true;
          testingSite = "Other Site";
          break;
      }
    });
  }

  void _handleReTestedArtChange(int value) {
    setState(() {
      _reTested = value;

      switch (_reTested) {
        case 1:
          retestedBeforeArt = true;
          break;
        case 2:
          retestedBeforeArt = true;
          break;
      }
    });
  }

  String _selfReferringProgramError = "Select Referring Program";
  String _selfHivTestUsedError = "Select HIV Test Used";
  String _selfReasonForHivTestError = "Select HIV Test Used";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.personId, widget.visitId,
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
                      "ART Registration",
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
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            "Age -" + age.years.toString() + "years",
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
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: SizedBox(
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                            child: TextFormField(
                                                              validator:
                                                                  (value) {
                                                                return value
                                                                        .isEmpty
                                                                    ? 'Enter Art Number'
                                                                    : null;
                                                              },
                                                              onSaved:
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                oi_art_number = value;
                                                              }),
                                                              decoration: InputDecoration(
                                                                  labelText: 'Art Number',
                                                                  border: OutlineInputBorder()),
                                                            ),
                                                          ),
                                                          width: 100,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(0.0),
                                                              child: TextFormField(
                                                                controller: TextEditingController(
                                                                        text: dateOfTest),
                                                                validator:
                                                                    (value) {
                                                                  return value
                                                                          .isEmpty
                                                                      ? 'Enter some text'
                                                                      : null;
                                                                },

                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        icon: Icon(Icons.calendar_today), color: Colors.blue,
                                                                        onPressed: () {_selectDateOfHivTest(context);}),
                                                                    labelText: 'Date of HIV Test',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
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
                                                                        text: dateOfEnrollment),
                                                                validator:
                                                                    (value) {
                                                                  return value
                                                                          .isEmpty
                                                                      ? 'Enter some text'
                                                                      : null;
                                                                },

                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        icon: Icon(Icons.calendar_today), color: Colors.blue,
                                                                        onPressed: () {_selectDateOfEnrollment(context);}),
                                                                    labelText: 'Date of Enrollment',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text(
                                                                  'Testing Site'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('Health Facility'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _testingSite,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged: _handleTestingSiteChange),
                                                        Text('Other Site'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _testingSite,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleTestingSiteChange),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  otherSite
                                                      ? Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                                  child: TextFormField(
                                                                    decoration: InputDecoration(
                                                                        labelText: 'Health Facility Name',
                                                                        border: OutlineInputBorder()),
                                                                  ),
                                                                ),
                                                                width: 100,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox(
                                                          height: 0.0,
                                                        ),
                                                  healthFacility
                                                      ? Container(
                                                          padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                          width: double.infinity,
                                                          child: OutlineButton(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(5.0)),
                                                            color: Colors.white,
                                                            padding: const EdgeInsets.all(0.0),
                                                            child: Container(
                                                              width: double.infinity,
                                                              padding: EdgeInsets.symmetric( vertical: 8.0, horizontal: 30.0),
                                                              child: SearchableDropdown(
                                                                isExpanded: true,
                                                                icon: Icon(Icons.keyboard_arrow_down),
                                                                hint: Text("Health Facility"),
                                                                iconEnabledColor:
                                                                    Colors.black,
                                                                value: _currentFacility,
                                                                items: _dropDownMenuItemsEntryPoint,
                                                                onChanged: changedDropDownItemHealthFacility,
                                                              ),
                                                            ),
                                                            borderSide: BorderSide(
                                                              color: Colors.blue,
                                                              //Color of the border
                                                              style: BorderStyle.solid,
                                                              //Style of the border
                                                              width: 2.0, //width of the border
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                        )
                                                      : SizedBox( height: 0.0,
                                                        ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    width: double.infinity,
                                                    child: OutlineButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                      color: Colors.white,
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                        child: DropdownButton(
                                                          isExpanded: true,
                                                          icon: Icon(Icons.keyboard_arrow_down),
                                                          hint: Text( "Referring Program"),
                                                          iconEnabledColor: Colors.black,
                                                          value: _currentReferringProgram,
                                                          items: _dropDownMenuItemsReferringListIdentified,
                                                          onChanged: changedDropDownItemReferring,
                                                        ),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        //Color of the border
                                                        style: BorderStyle.solid,
                                                        //Style of the border
                                                        width: 2.0, //width of the border
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: SizedBox(
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                    vertical: 16.0, horizontal: 60.0),
                                                            child: TextFormField(
                                                              validator:
                                                                  (value) {
                                                                return value.isEmpty
                                                                    ? 'Enter Program Number'
                                                                    : null;
                                                              },
                                                              onSaved: (value) => setState( () {
                                                                program_number = value;
                                                              }),
                                                              decoration: InputDecoration(
                                                                  labelText: 'Program Number',
                                                                  border: OutlineInputBorder()),
                                                            ),
                                                          ),
                                                          width: 100,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(0.0),
                                                              child: TextFormField(
                                                                controller: TextEditingController(
                                                                        text: dateHivConfirmed),
                                                                validator:
                                                                    (value) {
                                                                  return value
                                                                          .isEmpty
                                                                      ? 'Enter date'
                                                                      : null;
                                                                },

                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        icon: Icon(Icons.calendar_today), color: Colors.blue,
                                                                        onPressed: () {_selectDateHivConfirmed(context);}),
                                                                    labelText: 'Date HIV Confirmed',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    width: double.infinity,
                                                    child: OutlineButton(
                                                      shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                      color: Colors.white,
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 8.0, horizontal: 30.0),
                                                        child: DropdownButton(
                                                          isExpanded: true,
                                                          icon: Icon(Icons.keyboard_arrow_down),
                                                          hint: Text("HIV Test Used"),
                                                          iconEnabledColor: Colors.black,
                                                          value: _currentHivTestUsed,
                                                          items: _dropDownMenuItemsHivTestUsedIdentified,
                                                          onChanged:
                                                              changedDropDownItemHIVTestUsed,
                                                        ),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        //Color of the border
                                                        style: BorderStyle.solid,
                                                        //Style of the border
                                                        width: 2.0, //width of the border
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    width: double.infinity,
                                                    child: OutlineButton(
                                                      shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                      color: Colors.white,
                                                      padding: const EdgeInsets.all(0.0),
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 8.0, horizontal: 30.0),
                                                        child: DropdownButton(
                                                          isExpanded: true,
                                                          icon: Icon(Icons.keyboard_arrow_down),
                                                          hint: Text("Reason for HIV Test"),
                                                          iconEnabledColor: Colors.black,
                                                          value: _currentReasonForTest,
                                                          items: _dropDownMenuItemsReasonForTest,
                                                          onChanged: changedDropDownItemReasonForTest,
                                                        ),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        //Color of the border
                                                        style: BorderStyle.solid,
                                                        //Style of the border
                                                        width: 2.0, //width of the border
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.all(8.0),
                                                              child: Text( 'Retested Before ART Initiation '),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('Yes'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _reTested,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleReTestedArtChange),
                                                        Text('No'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _reTested,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleReTestedArtChange),
                                                      ],
                                                    ),
                                                  ),
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
                                                              padding:
                                                                  const EdgeInsets.all(0.0),
                                                              child: TextFormField(
                                                                controller:
                                                                    TextEditingController(
                                                                        text: dateOfRetest),
                                                                validator:
                                                                    (value) {
                                                                  return value
                                                                          .isEmpty
                                                                      ? 'Enter some text'
                                                                      : null;
                                                                },


                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        icon: Icon(Icons.calendar_today), color: Colors.blue,
                                                                        onPressed: () {_selectDateOfReTest(context);}),
                                                                    labelText: 'Date of ReTest',
                                                                    border: OutlineInputBorder()),


                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 35.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5.0) ),
                                                      color: Colors.blue,
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text('Register', style: TextStyle(color: Colors.white),),
                                                          Spacer(),
                                                          Icon(Icons.navigate_next, color: Colors.white, ),
                                                        ],
                                                      ),
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          _formKey.currentState
                                                              .save();
                                                          widget.artdto.personId = widget.personId;
                                                          widget.artdto.date = test_date;
                                                          widget.artdto.artNumber = oi_art_number;
                                                          widget.artdto.dateOfHivTest = test_date;
                                                          widget.artdto.dateEnrolled = enrollment_date;
                                                          widget.artdto.linkageFrom = _currentReferringProgram;
                                                          widget.artdto.dateHivConfirmed = test_date;
                                                          widget.artdto.linkageNumber = program_number;
                                                          widget.artdto.hivTestUsed = _currentHivTestUsed;
                                                          widget.artdto.otherInstitution = null;
                                                          widget.artdto.testReason = _currentReasonForTest;
                                                          widget.artdto.reTested = retestedBeforeArt;
                                                          widget.artdto.dateRetested = retest_date;
                                                          if(healthfacility_change){
                                                            widget.artdto.facility = _currentFacility;
                                                          }


                                                          await artRegistration(
                                                              widget.artdto);
                                                          print(
                                                              "ART DTO WAS NULL %%%%%%%%%%%%%%%%%%%%");
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ArtRegOverview(
                                                                      _artRegistration,
                                                                      widget.personId,
                                                                      widget.visitId,
                                                                      widget.person,
                                                                      widget.htsRegistration,
                                                                      widget.htsId)));

                                                          artRegistration(
                                                              widget.artdto);
                                                          print(
                                                              "ART DTO WAS NULL %%%%%%%%%%%%%%%%%%%%");
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => ArtRegOverview(
                                                                      _artRegistration,
                                                                      widget.personId,
                                                                      widget.visitId,
                                                                      widget.person,
                                                                      widget.htsRegistration,
                                                                      widget.htsId)));
                                                          setState(() {
                                                            /*  Artdto(this.personId, this.date, this.artNumber, this.enlargedLymphNode,
                                                                this.pallor, this.jaundice, this.cyanosis, this.mentalStatus,
                                                                this.centralNervousSystem, this.dateOfHivTest, this.dateEnrolled,
                                                                this.tracing, this.followUp, this.hivStatus, this.relation,
                                                                this.dateOfDisclosure, this.reason, this.linkageFrom,
                                                                this.dateHivConfirmed, this.linkageNumber, this.hivTestUsed,
                                                                this.otherInstitution, this.testReason, this.reTested, this.dateRetested,
                                                                this.facility);*/
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 45.0,
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
  }

  Future<void> artRegistration(Artdto artRegistration) async {
    var art_registration_response;
    try {
      print('pppppppppppppppppppppppppppppppppppp art regmethod reg object ' +
          artRegistration.toString());

      art_registration_response = await artChannel.invokeMethod(
          'saveArtRegistration', jsonEncode(artRegistration));
      print('pppppppppppppppppppppppppppppppppppp art response' +
          art_registration_response);
      setState(() {
        _artRegistration =
            Artdto.fromJson(jsonDecode(art_registration_response));
        print('FFFFFFFFFFFFFFFFFFFFFFF' + _artRegistration.toString());
      });
    } catch (e) {
      print('--------------something went wrong in art registration  $e');
    }
  }

  void changedDropDownItemReferring(String selectedReferringProgramIdentified) {
    setState(() {
      _currentReferringProgram = selectedReferringProgramIdentified;
      selfIdentifiedReferringIsValid = !selfIdentifiedReferringIsValid;
      _selfReferringProgramError = null;
    });
  }
  void changedDropDownItemHealthFacility(String selectedReferringProgramIdentified) {
    setState(() {
      healthfacility_change = true;
      _currentFacility = selectedReferringProgramIdentified;
      selfIdentifiedFacilitysValid = !selfIdentifiedFacilitysValid;
      _selfReferringProgramError = null;
    });
  }

  void changedDropDownItemHIVTestUsed(String selectedHIVTestIdentified) {
    setState(() {
      _currentHivTestUsed = selectedHIVTestIdentified;
      selfIdentifiedHIVTestIsValid = !selfIdentifiedHIVTestIsValid;
      _selfHivTestUsedError = null;
    });
  }

  void changedDropDownItemReasonForTest(String selectedReasonForTest) {
    setState(() {
      _currentReasonForTest = selectedReasonForTest;
      //testreason.code = _currentReasonForTest;
      selfIdentifiedReasonForTestIsValid = !selfIdentifiedReasonForTestIsValid;
      _selfReasonForHivTestError = null;
    });
  }
}
