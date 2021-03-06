import 'dart:async';
import 'dart:convert';

import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTestDto.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../sidebar.dart';
import 'rounded_button.dart';

class Recency_Result extends StatefulWidget {
  String visitId;
  String patientId;
  String labInvetsTestId;
  String labInvestId;
  Person person;
  String htsId;
  LaboratoryInvestigationTestDto laboratoryInvestigation;

  Recency_Result(this.patientId, this.labInvetsTestId, this.visitId,
      this.labInvestId, this.person, this.htsId, this.laboratoryInvestigation);

  //Hts_Result (this.visitId, this.patientId);

  @override
  State createState() {
    return _Recency_Result();
  }
}

class _Recency_Result extends State<Recency_Result> {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  String _visitId;
  String patientId;
  String indextestid;
  String INDEXTEST;

  String labInvetsTestId;
  String result_string;
  HtsRegistration htsRegistration;
  Person patient;
  var selectedDate;
  bool _showError = false;
  bool _entryPointIsValid = false;
  bool _formIsValid = false;
  String _entryPointError = "Select Entry Point";
  DateTime date;
  int _htsType = 0;
  String htsType = "";
  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  String hts_id;
  String testkit;
  String startTime;
  String endTime;
  bool showInput = true;
  bool showInputTabOptions = true;
  String final_result = 'Pending';
  List<DropdownMenuItem<String>> _dropDownMenuItemsEntryPoint;
  List<LaboratoryInvestigationTest> _entryPointList = List();
  Age age;
  String _currentEntryPoint;

  var facility_name;

  @override
  void initState() {
    _visitId = widget.visitId;
//    patient id
    patientId = widget.patientId;
    labInvetsTestId = widget.labInvetsTestId;
    getFinalResult(widget.labInvestId);
    getFacilities();
    getFacilityName();
    // getLabInvestigationTests();
    getTestKIt(widget.labInvetsTestId);
    getStartTime(widget.labInvetsTestId);
    getHtsRecord(widget.patientId);
    getAge(widget.person);
    //getEndTime(widget.labInvetsTestId);

    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    super.initState();
  }

  Future<void> getFacilities() async {
    String response;
    try {
      response =
          await htsChannel.invokeMethod('getLabInvestigations', widget.visitId);
      setState(() {
        {
          _entryPoint = response;
          entryPoints = jsonDecode(_entryPoint);
          _dropDownListEntryPoints =
              LaboratoryInvestigationTest.mapFromJson(entryPoints);
          _dropDownListEntryPoints.forEach((e) {
            _entryPointList.add(e);
          });
        }
      });

    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  Future<void> getAge(Person person) async {
    String response;
    try {
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
      });
    } catch (e) {
      debugPrint("Exception thrown in get facility name method" + e);
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
        date = DateFormat("yyyy/MM/dd").parse(selectedDate);
      });
  }

  Future<void> getHtsRecord(String patientId) async {
    var hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      setState(() {
        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  void _handleHtsTypeChange(int value) {
    print("hts value : $value");
    setState(() {
      _htsType = value;

      switch (_htsType) {
        case 1:
          htsType = "Self";
          print("hts value : $htsType");

          break;
        case 2:
          htsType = "Rapid";
          print("hts value : $htsType");

          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.patientId, widget.visitId,
          htsRegistration, widget.htsId),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app),
                            color: Colors.white,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            ),
                          ),
                          /*  Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text("logout", style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12.0,color: Colors.white ),),
                        ), */
                        ),
                      ])),
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
                      "Recency Test Results",
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
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        16.0),
                                                            child: TextField(
                                                              controller:
                                                                  TextEditingController(
                                                                      text:
                                                                          'Blood'),
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Sample',
                                                                // icon: Icon(Icons.add_box, color: Colors.blue),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        16.0),
                                                            child: TextField(
                                                              controller:
                                                                  TextEditingController(
                                                                      text:
                                                                          'HIV'),
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Investigation',
                                                                //icon: Icon(Icons.adjust, color: Colors.blue),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0.0,
                                                            horizontal: 60.0),
                                                    child: DataTable(columns: [
                                                      DataColumn(
                                                          label: Text(
                                                        "TestKit",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.80),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )),
                                                      DataColumn(
                                                          label: Text(
                                                        "Result",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.80),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )),
                                                    ], rows: [
                                                      DataRow(cells: [
                                                        DataCell(Text(widget
                                                            .laboratoryInvestigation
                                                            .testkit
                                                            .name)),
                                                        DataCell(Text(widget
                                                            .laboratoryInvestigation
                                                            .result
                                                            .name))
                                                      ])
                                                    ]),
                                                  ),
                                                  SizedBox(
                                                    height: 30.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 0.0,
                                                                  horizontal:
                                                                      60.0),
                                                          child: TextField(
                                                            controller:
                                                                TextEditingController(
                                                                    text: widget
                                                                        .laboratoryInvestigation
                                                                        .result
                                                                        .name),
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Final Result',
                                                              // icon: Icon(Icons.add_box, color: Colors.blue),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 30.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 0.0,
                                                            horizontal: 30.0),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                      color: Colors.blue,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20.0),
                                                      child: Text(
                                                        "Close ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => SummaryOverview(
                                                                    widget
                                                                        .person,
                                                                    widget
                                                                        .visitId,
                                                                    this
                                                                        .htsRegistration,
                                                                    widget
                                                                        .htsId)));
                                                      },
                                                    ),
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

  Widget buildNotificationItem({IconData icon}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "RESULT",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        title: Text(
          "FINAL",
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 1,
                color: Colors.black26,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              children: <Widget>[
                /*  Icon(
                  Icons.plus_one,
                  color: Colors.grey,
                  size: 15,
                ), */
                Text(
                  widget.laboratoryInvestigation.result.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "Recency Testing", selected: true,
          ),
          new RoundedButton(
            text: "Close",
            selected: true,
          ),
        ],
      ),
    );
  }

  Future<void> saveIndexTest(IndexTest indexTest) async {
    var response;

    try {
      response =
          await htsChannel.invokeMethod('saveIndexTest', jsonEncode(indexTest));
      setState(() {
        indextestid = response;
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          // Image.asset('assets/macbook.jpg'),
          Text('Hie', style: TextStyle(color: Colors.deepPurple))
        ],
      ),
    );
  }

  @override
  Widget buildlistview(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildProductItem,
      itemCount: _entryPointList.length,
    );
  }

  Future<void> registration(HtsRegistration htsRegistration) async {
    String id;
    print('*************************htsType ${htsRegistration.toString()}');
    try {
      id = await htsChannel.invokeMethod(
          'htsRegistration', jsonEncode(htsRegistration));
      hts_id = id;

      String patientid = patientId.toString();
      DateTime date = htsRegistration.dateOfHivTest;
      PersonInvestigation personInvestigation = new PersonInvestigation(
          patientid, "36069471-adee-11e7-b30f-3372a2d8551e", date, null);
      await htsChannel.invokeMethod(
          'htsRegistration', jsonEncode(personInvestigation));

      print('---------------------saved file id  $id');
    } catch (e) {
      print('--------------something went wrong  $e');
    }
  }

  Future<void> getTestKIt(labInvestId) async {
    String testkitId;
    try {
      testkitId = await htsChannel.invokeMethod('getTestKit', labInvestId);
      print('TEST KIT HERE ' + testkit);
    } catch (e) {
      print('--------------something went wrong  $e');
    }
    setState(() {
      testkit = testkitId;
    });
  }

  Future<void> getFinalResult(labInvestId) async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getFinalResult', labInvestId);
      print('Final Result here >>>>>>>>>> ' + response);
    } catch (e) {
      print('--------------something went wrong  $e');
    }
    setState(() {
      if (response == null) {
        final_result = '';
      } else {
        final_result = response;
      }
    });
  }

  Future<void> getStartTime(labInvestId) async {
    String starttime;
    try {
      starttime = await htsChannel.invokeMethod('getStartTime', labInvestId);
      print('start time HERE ' + starttime);
    } catch (e) {
      print('--------------something went wrong  $e');
    }
    setState(() {
      startTime = starttime;
    });
  }

  Future<void> getEndTime(labInvestId) async {
    String endtime;
    try {
      endtime = await htsChannel.invokeMethod('getStartTime', labInvestId);
      print('start time HERE ' + endtime);
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  void changedDropDownItemEntryPoint(String selectedEntryPoint) {
    setState(() {
      _currentEntryPoint = selectedEntryPoint;
      _entryPointError = null;
      _entryPointIsValid = !_entryPointIsValid;
    });
  }
}
