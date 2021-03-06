import 'dart:convert';

import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/disclosuremethod.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indexcontact.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/testingplan.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/hiv_services_index_contact_page.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../landing_screen.dart';
import '../sidebar.dart';

class PatientIndexHivInfo extends StatefulWidget {
  final Person person;
  final String personId;
  final IndexContact indexcontact;
  final String htsId;
  final String visitId;
  final HtsRegistration htsRegistration;
  final Person person_contact;

  PatientIndexHivInfo(this.person_contact, this.indexcontact, this.personId,
      this.person, this.visitId, this.htsRegistration, this.htsId);

  @override
  State createState() {
    return _PatientIndexHivInfo();
  }
}

class _PatientIndexHivInfo extends State<PatientIndexHivInfo>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String lastName, firstName;
  var selectedDate;
  DateTime date;
  int _options = 0;
  int status = 0;
  bool fear = false;
  bool disclosed_status = false;
  String options = "";
  List _religions = List();
  List<DisclosureMethod> _religionListDropdown = List();
  List _testingplans = List();
  List<TestingPlan> _testingplanListDropdown = List();
  List _religionList = List();
  List _testingplanlist = List();
  String religion;
  String testingplan;
  String disclosure_method;
  String indexContactId;
  Age age;
  List _disclosuremethods = List();
  List<DisclosureMethod> _disclosuremethodsListDropdown = List();
  List _disclosureList = List();
  static const dataChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  String _currentDisclosurePlanStatus;
  String _currentReligion;

  List<DropdownMenuItem<String>> _dropDownMenuItemsDisclosurePlanStatus;
  List<DropdownMenuItem<String>> _dropDownMenuItemsTesting_plans;

  String facility_name;

  List<DropdownMenuItem<String>> getDropDownMenuItemsReligion() {
    List<DropdownMenuItem<String>> items = new List();
    for (DisclosureMethod disclosuremethod in _religionList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: disclosuremethod.id, child: Text(disclosuremethod.name)));
    }
    return items;
  }

  List _diclosurePlanStatusList = [
    "Select Partner Disclosure Plan",
    "Index To Disclose",
    "Couple Testing",
    "Client & HCW Disclosure Together",
    "HCW Assisted",
  ];

  String _currentTestingPlanStatus;

  List<DropdownMenuItem<String>> _dropDownMenuItemsTestingPlanStatus;

  List<DropdownMenuItem<String>>
      getDropDownMenuItemsIdentifiedTestingPlanStatus() {
    List<DropdownMenuItem<String>> items = new List();
    for (TestingPlan testingPlan in _testingplanlist) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: testingPlan.id, child: Text(testingPlan.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> _dropDownMenuItemsReligion;
  List<DropdownMenuItem<String>> _dropDownMenuItemsTestingPlans;

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
      debugPrint("Exception thrown in get facility name method" + e);
    }
  }

  @override
  void initState() {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    getDropdowninfo();
    getFacilityName();
    getAge(widget.person);
    _dropDownMenuItemsDisclosurePlanStatus = getDropDownMenuItemsReligion();
    _dropDownMenuItemsTesting_plans =
        getDropDownMenuItemsIdentifiedTestingPlanStatus();
    super.initState();
  }

  Future<void> getDropdowninfo() async {
    String disclosure_string, testing_plan_string;
    try {
      disclosure_string =
          await dataChannel.invokeMethod('getdisclosuremethods');
      testing_plan_string = await dataChannel.invokeMethod('getTestingPlan');
      setState(() {
        religion = disclosure_string;
        _religions = jsonDecode(religion);
        _religionListDropdown = DisclosureMethod.mapFromJson(_religions);
        _religionListDropdown.forEach((e) {
          _religionList.add(e);
        });
        _dropDownMenuItemsReligion = getDropDownMenuItemsReligion();

        testingplan = testing_plan_string;
        _testingplans = jsonDecode(testingplan);
        _testingplanListDropdown = TestingPlan.mapFromJson(_testingplans);
        _testingplanListDropdown.forEach((e) {
          _testingplanlist.add(e);
        });
        _dropDownMenuItemsTestingPlans =
            getDropDownMenuItemsIdentifiedTestingPlanStatus();
      });
    } catch (e) {}
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
      });
  }

  void _handleOptionsChange(int value) {
    setState(() {
      _options = value;

      switch (_options) {
        case 1:
          fear = true;
          break;
        case 2:
          fear = false;
          break;
      }
    });
  }

  void _handleStatusDiscloseChange(int value) {
    setState(() {
      status = value;

      switch (status) {
        case 1:
          disclosed_status = true;
          break;
        case 2:
          disclosed_status = false;
          break;
      }
    });
  }

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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.person_pin,
                            size: 25.0,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            "admin",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0,
                                color: Colors.white),
                          ),
                        ),
                      ])),
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
                      "Disclosure And Partner Testing Information",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
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
                  //    _buildButtonsRow(),
                  Expanded(
                    child: WillPopScope(
                      child: new Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.all(8.0),
                        child: DefaultTabController(
                          child: new LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints viewportConstraints) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    height: 2.0,
                                    color: Colors.blue,
                                  ),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 20.0,
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
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          0.0,
                                                                      horizontal:
                                                                          0.0),
                                                              child: Text(
                                                                  'Fear of Intimate Partner Violence (IPV) (if partner finds you are HIV+'),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                        Text('Yes'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                                _options,
                                                            activeColor:
                                                                Colors.blue,
                                                            onChanged:
                                                                _handleOptionsChange),
                                                        Text('No'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                                _options,
                                                            activeColor:
                                                                Colors.blue,
                                                            onChanged:
                                                                _handleOptionsChange)
                                                      ],
                                                    ),
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
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          0.0,
                                                                      horizontal:
                                                                          0.0),
                                                              child: Text(
                                                                  'Disclosed status?'),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                        Text('Yes'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: status,
                                                            activeColor:
                                                                Colors.blue,
                                                            onChanged:
                                                                _handleStatusDiscloseChange),
                                                        Text('No'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: status,
                                                            activeColor:
                                                                Colors.blue,
                                                            onChanged:
                                                                _handleStatusDiscloseChange)
                                                      ],
                                                    ),
                                                  ),
                                                  disclosed_status
                                                      ? Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      16.0,
                                                                  horizontal:
                                                                      60.0),
                                                          width:
                                                              double.infinity,
                                                          child: OutlineButton(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0)),
                                                            color: Colors.white,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.0,
                                                                      horizontal:
                                                                          30.0),
                                                              child:
                                                                  DropdownButton(
                                                                hint: Text(
                                                                  "Select Disclosure Plan",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black,
                                                                    // fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                                isExpanded:
                                                                    true,
                                                                icon: Icon(Icons
                                                                    .keyboard_arrow_down),
                                                                iconEnabledColor:
                                                                    Colors
                                                                        .black,
                                                                value:
                                                                    _currentReligion,
                                                                items:
                                                                    _dropDownMenuItemsReligion,
                                                                onChanged:
                                                                    changedDropDownItemReligion,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                              //Color of the border
                                                              style: BorderStyle
                                                                  .solid,
                                                              //Style of the border
                                                              width:
                                                                  2.0, //width of the border
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 0.0,
                                                        ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 16.0,
                                                            horizontal: 60.0),
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
                                                        child: DropdownButton(
                                                          hint: Text(
                                                            "Select Testing Plan",
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.black,
                                                              // fontWeight: FontWeight.w500
                                                            ),
                                                          ),
                                                          isExpanded: true,
                                                          icon: Icon(Icons
                                                              .keyboard_arrow_down),
                                                          iconEnabledColor:
                                                              Colors.black,
                                                          value:
                                                              _currentTestingPlanStatus,
                                                          items:
                                                              _dropDownMenuItemsTestingPlans,
                                                          onChanged:
                                                              changedDropDownItemTestingPlanStatus,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                          ),
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
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          0.0,
                                                                      horizontal:
                                                                          0.0),
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    TextEditingController(
                                                                        text:
                                                                            selectedDate),
                                                                validator:
                                                                    (value) {
                                                                  return value
                                                                          .isEmpty
                                                                      ? 'Enter some text'
                                                                      : null;
                                                                },
                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        icon: Icon(Icons.calendar_today),
                                                                        color: Colors.blue,
                                                                        onPressed: () {
                                                                          _selectDate(
                                                                              context);
                                                                        }),
                                                                    labelText: 'Proposed HIV Index Testing Appointment Date',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 60,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      16.0,
                                                                  horizontal:
                                                                      60.0),
                                                          child: RaisedButton(
                                                              elevation: 4.0,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0)),
                                                              color:
                                                                  Colors.blue,
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      20.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Text(
                                                                    'Save Index Contact Details',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Spacer(),
                                                                  Icon(
                                                                    Icons
                                                                        .save_alt,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ],
                                                              ),
                                                              onPressed: () {
                                                                IndexContact indexcontact = IndexContact(
                                                                    '',
                                                                    widget
                                                                        .indexcontact
                                                                        .indexTestId,
                                                                    widget
                                                                        .indexcontact
                                                                        .personId,
                                                                    widget
                                                                        .indexcontact
                                                                        .relation,
                                                                    widget
                                                                        .indexcontact
                                                                        .hivStatus,
                                                                    widget
                                                                        .indexcontact
                                                                        .dateOfHivStatus,
                                                                    fear,
                                                                    _currentReligion,
                                                                    _currentTestingPlanStatus,
                                                                    disclosed_status,
                                                                    _currentReligion);
                                                                saveIndexContact(
                                                                    indexcontact);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => HIVServicesIndexContactList(
                                                                            widget.person,
                                                                            widget.person_contact,
                                                                            null,
                                                                            null,
                                                                            null,
                                                                            widget.personId,
                                                                            widget.indexcontact.indexTestId)));
                                                              }),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                ],
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigation(),
    );
  }

  void changedDropDownItemDisclosurePlanStatus(
      String selectedDisclosurePlanStatus) {
    setState(() {
      _currentDisclosurePlanStatus = selectedDisclosurePlanStatus;
    });
  }

  void changedDropDownItemTestingPlanStatus(String selectedTestingPlanStatus) {
    setState(() {
      _currentTestingPlanStatus = selectedTestingPlanStatus;
    });
  }

  void changedDropDownItemReligion(String selectedReligion) {
    setState(() {
      _currentReligion = selectedReligion;
    });
    print('@@@@@@@@@@@@@@@@@@ $_currentReligion');
  }

  Future<void> saveIndexContact(IndexContact indexcontact) async {
    print("HHHHHHHHHHHHHHHHHHH  HERE IS THE ID OF THE INDEXCONTACT SAVED " +
        indexcontact.toString());
    var response;
    try {
      response = await htsChannel.invokeMethod(
          'saveIndexContact', jsonEncode(indexcontact));
      setState(() {
        indexContactId = response;
      });
    } catch (e) {}
  }
}
