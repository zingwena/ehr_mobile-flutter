import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/CbsQuestions.dart';
import 'package:ehr_mobile/model/sexualhistory.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/util/logger.dart';
import 'package:ehr_mobile/view/hts_pretest_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/sexualhistoryform2.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/hts_testing.dart';
import 'package:ehr_mobile/view/hts_testing.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../sidebar.dart';
import 'edit_demographics.dart';
import 'hts_testscreening.dart';
import 'rounded_button.dart';

class CbsQuestions extends StatefulWidget {

  final String htsid ;
  final String personId;
  final HtsRegistration htsRegistration;
  final String visitId;
  final Person person;
  CbsQuestions(this.personId, this.htsid, this.htsRegistration, this.visitId, this.person);

  @override
  State createState() {
    return _CbsQuestion();
  }
}

class _CbsQuestion extends State<CbsQuestions> {
  static const platform = MethodChannel('example.channel.dev/people');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();
  PreTest preTest;
  List<HtsModel> _htsModelList=List();
  List<PurposeOfTest> _purposeOfTestList= List();
  HtsRegistration htsRegistration;
  bool _newTestInPreg = false;
  int _victim = 0;
  int _sexuallyActive =0;
  int _sexwithmale = 0;
  int _sexwithfemale = 0;
  int unprotectedsex = 0;
  int sexWithSExWorker = 0;
  bool sexuallyactive = false;
  int numberofsexualpartnersinlast12months;
  int numberofsexualpartners;
  HtsModel htsModel;
  PurposeOfTest purposeOfTest;
  var selectedDateOfSexWithMale, selectedDateOfSexWithFemale;
  DateTime dateOfSexWithMale , dateOfSexWithFemale;
  String sexualHistoryId;
  String purposeOfTestId;
  Age age;
  String facility_name;
  bool sexually_active;
  @override
  void initState() {
    //getDropDrowns();
    getHtsRecord(widget.personId);
    getAge(widget.person);
    getFacilityName();
    super.initState();
  }
  List<DropdownMenuItem<String>>
  getDropDownMenuItemsPurposeOfTest() {
    List<DropdownMenuItem<String>> items = new List();
    for (PurposeOfTest purposeOfTest in _purposeOfTestList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: purposeOfTest.code, child: Text(purposeOfTest.name)));
    }
    return items;
  }

  Future<void> getHtsRecord(String patientId) async {
    var  hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      setState(() {
        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
        print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());
      });
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
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
        print("THIS IS THE AGE RETRIEVED"+ age.toString());
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

  Future<Null> _selectDateOfSexWithMale(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateOfSexWithMale)
      setState(() {
        selectedDateOfSexWithMale = DateFormat("yyyy/MM/dd").format(picked);
        dateOfSexWithMale = DateFormat("yyyy/MM/dd").parse(selectedDateOfSexWithMale);
      });
  }
  Future<Null> _selectDateOfSexWithFemale(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateOfSexWithFemale)
      setState(() {
        selectedDateOfSexWithFemale = DateFormat("yyyy/MM/dd").format(picked);
        dateOfSexWithFemale = DateFormat("yyyy/MM/dd").parse(selectedDateOfSexWithFemale);
      });
  }
  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer:  Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsid),
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
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
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
                    child: Text("Sexual History", style: TextStyle(
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
                                //  _buildTabBar(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: new ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minHeight:
                                        viewportConstraints.maxHeight - 48.0,
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
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 90.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text('Are you sexually active ?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),

                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            _sexuallyActive,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleSexuallyActiveChange),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                            _sexuallyActive,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleSexuallyActiveChange),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue:
                                                            _sexuallyActive,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleSexuallyActiveChange)
                                                      ],
                                                    ),
                                                  ),
                                                  sexuallyactive== true?Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 30.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0 ),
                                                              child: TextFormField(
                                                                controller: TextEditingController(text: selectedDateOfSexWithMale),
                                                                validator: (value) {
                                                                  return value.isEmpty ? 'Enter date' : null;
                                                                },
                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        icon: Icon(Icons.calendar_today), color: Colors.blue,
                                                                        onPressed: () {_selectDateOfSexWithMale(context);}),
                                                                    labelText: 'Date of last sex with male',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ):SizedBox(height: 0.0,),
                                                  sexuallyactive == true?Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 10.0, horizontal: 30.0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: 16.0, horizontal: 60.0),
                                                              child: TextFormField( controller:
                                                                TextEditingController(text: selectedDateOfSexWithFemale),
                                                                validator: (value) {
                                                                  return value.isEmpty ? 'Enter date' : null;
                                                                },
                                                                decoration: InputDecoration(
                                                                    suffixIcon: IconButton(
                                                                        icon: Icon(Icons.calendar_today), color: Colors.blue,
                                                                        onPressed: () {_selectDateOfSexWithFemale(context);}),
                                                                    labelText: 'Date of last sex with female',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ):SizedBox(height: 0.0,),
                                                  sexuallyactive== true?Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 12.0, horizontal: 30.0),
                                                    child:     Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: 16.0, horizontal: 60.0),
                                                              child: TextFormField(
                                                                keyboardType: TextInputType.number,
                                                                validator: (value) {
                                                                  return value
                                                                      .isEmpty
                                                                      ? 'Enter Number of sexual partners'
                                                                      : null;
                                                                },
                                                                onChanged: (value){
                                                                  if(value!=null && value.isNotEmpty){
                                                                    numberofsexualpartners  = int.parse(value);
                                                                  }
                                                                },
//                                                                onSaved:
//                                                                    (value) =>
//                                                                    setState(() { numberofsexualpartners  = int.parse(value);                                           }),
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                    'Number of sexual partners',
                                                                    border:
                                                                    OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ):SizedBox(height: 0.0,),
                                                  sexuallyactive?Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 30.0),
                                                    child:     Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric( vertical: 16.0, horizontal: 60.0),
                                                              child: TextFormField(
                                                                keyboardType: TextInputType.number,
                                                                validator: (value) {
                                                                  return value
                                                                      .isEmpty
                                                                      ? 'Enter  Number of sexual partners'
                                                                      : null;
                                                                },
                                                                onChanged: (value){
                                                                  if(value!=null && value.isNotEmpty){
                                                                    numberofsexualpartnersinlast12months  = int.parse(value);
                                                                  }
                                                                },
//                                                                onChanged:
//                                                                    (value) =>
//                                                                    setState(
//                                                                            () {
//                                                                          numberofsexualpartnersinlast12months  = int.parse(value);                                           }),
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                    'Number of sexual partners in the past 12 months ',
                                                                    border:
                                                                    OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ):SizedBox(height: 0.0,),
                                                  SizedBox(
                                                    height: 25.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 55.5 ),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5.0)),
                                                      color: Colors.blue,
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text('Proceed', style: TextStyle(color: Colors.white),),
                                                          Spacer(),
                                                          Icon(Icons.navigate_next, color: Colors.white, ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        if (_formKey.currentState.validate()) {
                                                          _formKey.currentState.save();
                                                        }
                                                    SexualHistory sexualhistory = SexualHistory(widget.personId, sexuallyactive, dateOfSexWithMale, dateOfSexWithFemale,numberofsexualpartners, numberofsexualpartnersinlast12months);
                                                         saveSexualHistory(sexualhistory);
                                                        Navigator.push(context,MaterialPageRoute(
                                                            builder: (context)=> CbsQuestions2(widget.personId, widget.htsid, widget.htsRegistration, widget.visitId, widget.person, sexualHistoryId)
                                                        ));
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 30.0,
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

  Future<void>saveSexualHistory(SexualHistory sexualHistory)async{
    log.i(sexualHistory);
    var response;
    try{
      response = await htsChannel.invokeMethod('saveSexualHistory',jsonEncode(sexualHistory));
      setState(() {
        sexualHistoryId = response;
      });

    }catch(e){
      print('Exception thrown in save sexualhistory '+e);

    }
  }

  void _handleSexuallyActiveChange(int value) {
    setState(() {
      _sexuallyActive = value;

      switch (_sexuallyActive) {
        case 1:
          sexuallyactive = true;
          break;
        case 2:
          sexuallyactive = false;
          break;

      }
    });
  }


}


