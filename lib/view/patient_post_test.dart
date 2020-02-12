import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/posttest_overview.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'rounded_button.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/hts_registration.dart';

import '../sidebar.dart';

class PatientPostTest extends StatefulWidget {
  String result;
  String patientId;
  String visitId;
  Person person;
  String htsId;
  HtsRegistration htsRegistration;
  PatientPostTest(this.result, this.patientId, this.visitId, this.person,
      this.htsId, this.htsRegistration);
  @override
  State createState() {
    return _PatientPostTest();
  }
}

class _PatientPostTest extends State<PatientPostTest> {
  static const platform = MethodChannel('example.channel.dev/people');
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();
  var selectedDate;
  DateTime date;
  List<ReasonForNotIssuingResult> _reasonForNotIssuingResultList = List();
  bool _resultReceived = false;
  String resultReceived = "NO";
  bool _postTestCounselled = false;
  String postTestCounselled = "NO";
  bool awareofstatus;
  bool patientOnArt;
  bool _consenttoindex = false;
  String consenttoindex = "NO";
  HtsRegistration htsRegistration;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasons;
  List<ReasonForNotIssuingResult> _reasonsList = List();
  String _currentReasonfornotissuing;
  String _reasonstring;
  List reasons = List();
  List _dropDownListReasons = List();
  int _resultsreceived = 0;
  int _posttestcounselled = 0;
  int _patientawareofstatus = 0;
  int _patientonart = 0;
  int _consentToIndex = 0;
  Age age;

  var facility_name;

  @override
  void initState() {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    getHtsRecord(widget.patientId);
    getReasonsForNotIssueingResult();
    getFacilityName();
    getAge(widget.person);

    print(
        'reasonForNotIssuingResultList${_reasonForNotIssuingResultList.length}');

    super.initState();
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
      });
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

  Future<void> insertPostTest(PostTest postTest) async {
    try {
      await htsChannel.invokeMethod('savePostTest', jsonEncode(postTest));
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  Future<void> getHtsRecord(String patientId) async {
    var hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      print('HTS IN THE FLUTTER THE RETURNED ONE ' + hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
      print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());
    });
  }

  Future<void> getReasonsForNotIssueingResult() async {
    String response;
    try {
      response =
          await dataChannel.invokeMethod('getReasonForNotIssueingReasons');
      setState(() {
        _reasonstring = response;
        reasons = jsonDecode(_reasonstring);
        _dropDownListReasons = ReasonForNotIssuingResult.mapFromJson(reasons);
        _dropDownListReasons.forEach((e) {
          _reasonsList.add(e);
        });
        print("Reasons list here " + _reasonsList.toString());
        _dropDownMenuItemsReasons =
            getDropDownMenuItemsReasonForNotIssuingResult();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  List<DropdownMenuItem<String>>
      getDropDownMenuItemsReasonForNotIssuingResult() {
    List<DropdownMenuItem<String>> items = new List();
    for (ReasonForNotIssuingResult reasonForNotIssuingResult in _reasonsList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: reasonForNotIssuingResult.code,
          child: Text(reasonForNotIssuingResult.name)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.patientId, widget.visitId,
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
            height: 230.0,
          ),
          new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            title:new Text(
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
                      "Post Test",
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
                              child: Text("Age -"+ age.years.toString()+"years", style: TextStyle(
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
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 80.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Text(
                                                                      'Final Result'),
                                                                ),
                                                                width: 250,
                                                              ),
                                                            ),
                                                            Text(widget.result),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 16.0,
                                                                horizontal:
                                                                    60.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      'Results Received'),
                                                                ),
                                                                width: 250,
                                                              ),
                                                            ),
                                                            Text('YES'),
                                                            Radio(
                                                                value: 1,
                                                                groupValue:
                                                                    _resultsreceived,
                                                                onChanged:
                                                                    _handleResultReceived),
                                                            Text('NO'),
                                                            Radio(
                                                                value: 2,
                                                                groupValue: _resultsreceived,
                                                                onChanged: _handleResultReceived)
                                                          ],
                                                        ),
                                                      ),
                                                      _resultReceived == false
                                                          ? Container(
                                                              width: double.infinity,
                                                             padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                                                              child: OutlineButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5.0)),
                                                                color: Colors.white,
                                                                child: Container(
                                                                  width: double.infinity,
                                                                  child: DropdownButton(
                                                                    isExpanded: true,
                                                                    icon: Icon(Icons.keyboard_arrow_down),
                                                                    iconEnabledColor: Colors.black,
                                                                    hint: Text("Select reason for not issuing results"),
                                                                    value: _currentReasonfornotissuing,
                                                                    items: _dropDownMenuItemsReasons,
                                                                    onChanged: changedDropDownItemReasons,
                                                                    style: TextStyle(
                                                                      fontSize: 15,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .blue, //Color of the border
                                                                  style: BorderStyle
                                                                      .solid, //Style of the border
                                                                  width:
                                                                      2.0, //width of the border
                                                                ),
                                                                onPressed:
                                                                    () {},
                                                              ))
                                                          : SizedBox(
                                                              height: 0.0),
                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 16.0,
                                                                horizontal:
                                                                    60.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      'Post Test Counselled'),
                                                                ),
                                                                width: 250,
                                                              ),
                                                            ),
                                                            Text('YES'),
                                                            Radio(
                                                                value: 1,
                                                                groupValue:
                                                                    _posttestcounselled,
                                                                onChanged:
                                                                    _handlePostTestCounselled),
                                                            Text('NO'),
                                                            Radio(
                                                                value: 2,
                                                                groupValue:
                                                                    _posttestcounselled,
                                                                onChanged:
                                                                    _handlePostTestCounselled)
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      _postTestCounselled ==
                                                              true
                                                          ? Container(
                                                              width: double
                                                                  .infinity,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          16.0,
                                                                      horizontal:
                                                                          60.0),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(0.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              TextEditingController(text: selectedDate),
                                                                          validator:
                                                                              (value) {
                                                                            return value.isEmpty
                                                                                ? 'Enter some text'
                                                                                : null;
                                                                          },
                                                                          decoration: InputDecoration(
                                                                              labelText: 'Date Post Test Counselled',
                                                                              border: OutlineInputBorder()),
                                                                        ),
                                                                      ),
                                                                      width:
                                                                          100,
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .calendar_today),
                                                                      color: Colors
                                                                          .blue,
                                                                      onPressed:
                                                                          () {
                                                                        _selectDate(
                                                                            context);
                                                                      })
                                                                ],
                                                              ))
                                                          : SizedBox(
                                                              height: 0.0,
                                                            ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 16.0,
                                                                horizontal:
                                                                    60.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                      'Patient aware of their status'),
                                                                ),
                                                                width: 250,
                                                              ),
                                                            ),
                                                            Text('YES'),
                                                            Radio(
                                                                value: 1,
                                                                groupValue:
                                                                    _patientawareofstatus,
                                                                onChanged:
                                                                    _handlePatientAwareOfStatus),
                                                            Text('NO'),
                                                            Radio(
                                                                value: 2,
                                                                groupValue:
                                                                    _patientawareofstatus,
                                                                onChanged:
                                                                    _handlePatientAwareOfStatus)
                                                          ],
                                                        ),
                                                      ),
                                                      widget.result ==
                                                              'POSITIVE'
                                                          ? Container(
                                                              width: double
                                                                  .infinity,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          16.0,
                                                                      horizontal:
                                                                          60.0),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            'Is patient on ART ? '),
                                                                      ),
                                                                      width:
                                                                          250,
                                                                    ),
                                                                  ),
                                                                  Text('YES'),
                                                                  Radio(
                                                                      value: 1,
                                                                      groupValue:
                                                                          _patientonart,
                                                                      onChanged:
                                                                          _handlePatientOnArt),
                                                                  Text('NO'),
                                                                  Radio(
                                                                      value: 2,
                                                                      groupValue:
                                                                          _patientonart,
                                                                      onChanged:
                                                                          _handlePatientOnArt)
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              height: 0.0,
                                                            ),
                                                      widget.result ==
                                                              'POSITIVE'
                                                          ? Container(
                                                              width: double
                                                                  .infinity,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          16.0,
                                                                      horizontal:
                                                                          60.0),
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        SizedBox(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            'Consent to Index testing'),
                                                                      ),
                                                                      width:
                                                                          250,
                                                                    ),
                                                                  ),
                                                                  Text('YES'),
                                                                  Radio(
                                                                      value: 1,
                                                                      groupValue:
                                                                          _consentToIndex,
                                                                      onChanged:
                                                                          _handleConsentForIndex),
                                                                  Text('NO'),
                                                                  Radio(
                                                                      value: 2,
                                                                      groupValue:
                                                                          _consentToIndex,
                                                                      onChanged:
                                                                          _handleConsentForIndex)
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              height: 18.0,
                                                            ),

                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 55.5),
                                                        child: RaisedButton(
                                                          elevation: 4.0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0)),
                                                          color: Colors.blue,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Text('Proceed to Post Test', style: TextStyle(color: Colors.white),),
                                                              Spacer(),
                                                              Icon(Icons.navigate_next, color: Colors.white, ),
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            PostTest postTest = new PostTest(
                                                                widget.htsId,
                                                                date,
                                                                _resultReceived,
                                                                _currentReasonfornotissuing,
                                                                widget.result,
                                                                this._consenttoindex,
                                                                _postTestCounselled);

                                                            //PostTest(this.htsId, this.datePostTestCounselled,this.resultReceived,this.reasonForNotIssuingResult, this.finalResult, this.consentToIndexTesting, this.postTestCounselled);
                                                            insertPostTest(
                                                                postTest);
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => PostTestOverview(
                                                                        postTest,
                                                                        widget
                                                                            .patientId,
                                                                        widget
                                                                            .visitId,
                                                                        widget
                                                                            .person,
                                                                        widget
                                                                            .htsId,
                                                                        _consenttoindex,
                                                                        awareofstatus,
                                                                        patientOnArt,
                                                                        widget
                                                                            .result,
                                                                        htsRegistration)));
                                                          },
                                                        ),
                                                      ),
                                                    ],
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
            text: "HTS Pre-Testing",
          ),
          new RoundedButton(
            text: "HTS Result",
          ),
          new RoundedButton(
            text: "Post Test", selected: true,
          ),
        ],
      ),
    );
  }

  void _handleResultReceived(int value) {
    setState(() {
      _resultsreceived = value;

      switch (_resultsreceived) {
        case 1:
          _resultReceived = true;
          break;
        case 2:
          _resultReceived = false;
          break;
      }
    });
  }

  void _handleConsentForIndex(int value) {
    setState(() {
      _consentToIndex = value;

      switch (_consentToIndex) {
        case 1:
          _consenttoindex = true;
          break;
        case 2:
          _consenttoindex = false;
          break;
      }
    });
  }

  void _handlePostTestCounselled(int value) {
    setState(() {
      _posttestcounselled = value;

      switch (_posttestcounselled) {
        case 1:
          _postTestCounselled = true;
          break;
        case 2:
          _postTestCounselled = false;
          break;
      }
    });
  }

  void _handlePatientAwareOfStatus(int value) {
    setState(() {
      _patientawareofstatus = value;

      switch (_patientawareofstatus) {
        case 1:
          awareofstatus = true;
          break;
        case 2:
          awareofstatus = false;
          break;
      }
    });
  }

  void _handlePatientOnArt(int value) {
    setState(() {
      _patientonart = value;

      switch (_patientonart) {
        case 1:
          patientOnArt = true;
          break;
        case 2:
          patientOnArt = false;
          break;
      }
    });
  }

  void changedDropDownItemReasons(String value) {
    setState(() {
      _currentReasonfornotissuing = value;
    });
  }
}
