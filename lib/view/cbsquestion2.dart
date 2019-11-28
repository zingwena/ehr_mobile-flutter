import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/CbsQuestions.dart';
import 'package:ehr_mobile/model/sexualhistoryview.dart';
import 'package:ehr_mobile/view/sexual_history_overview.dart';


import 'package:ehr_mobile/view/hts_pretest_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
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

class CbsQuestions2 extends StatefulWidget {

  final String htsid ;
  final String personId;
  final HtsRegistration htsRegistration;
  final String visitId;
  final Person person;
  final CbsQuestion cbsQuestion;
  CbsQuestions2(this.personId, this.htsid, this.htsRegistration, this.visitId, this.person, this.cbsQuestion);

  @override
  State createState() {
    return _CbsQuestion();
  }
}

class _CbsQuestion extends State<CbsQuestions2> {
  static const platform = MethodChannel('example.channel.dev/people');

  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  final _formKey = GlobalKey<FormState>();
  PreTest preTest;
  List<HtsModel> _htsModelList=List();
  List<PurposeOfTest> _purposeOfTestList= List();

  int _hts = 0;
  // String _coupleCounselling="" ;
  String _newTest = " " ;
  String _htsApproach="" ;
  HtsRegistration htsRegistration;
  int _exchangedsexformoney = 0;
  int _injecteddrugs = 0;
  int  incarcetadintojail = 0;
  int historyofsti = 0;
  int medicaltrans = 0;
  int _medicalinjections = 0;
  int unsterilisedInstru = 0 ;
  String exchangedsexformoney = "";
  String agewhenfirsthadsex;
  String numberofsexualpartners;
  HtsModel htsModel;
  PurposeOfTest purposeOfTest;
  PreTest patient_preTest;
  String injectedrecreationaldrugs = "NO";
  String beenincarcetadintojail = "NO";
  String historyofSTI = "NO";
  String  medicalinjections= "NO";
  String receivedbloodtransfusion = "NO";
  String unsterilisedinstruments = "NO";
  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  String purposeOfTestId;
  List<SexualHistoryView> _entryPointList = List();

  @override
  void initState() {
    //getDropDrowns();
    getHtsRecord(widget.personId);
    getSexualHistoryViews(widget.personId);
    super.initState();
  }

  Future<void> insertPreTest(PreTest preTest) async {
    String pretestjson;
    try {
      pretestjson =  await htsChannel.invokeMethod('savePreTest',  jsonEncode(preTest));
      print('LLLLLLLLLLLLLLLL'+ pretestjson);
      setState(() {
        patient_preTest = PreTest.fromJson(jsonDecode(pretestjson));
        print('LLLLLLLLLLLLLLLLLLLLL'+ patient_preTest.toString());
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  Future <void> getHtsModelByName(String htsmodelstring) async{
    var model_response;
    try{
      model_response = await htsChannel.invokeMethod('getHtsModel', htsmodelstring);
      setState(() {
        htsModel = HtsModel.mapFromJson(model_response);
      });

    }catch (e){
      print("channel failure: '$e'");

    }
  }
  Future <void> getPurposeByName(String purposemodelstring) async{
    var model_response;
    try{
      model_response = await htsChannel.invokeMethod('getPurposeofTest', purposemodelstring);
      setState(() {
        purposeOfTest = PurposeOfTest.mapFromJson(model_response);

      });

    }catch (e){
      print("channel failure: '$e'");

    }
  }
  Future<void>getSexualHistoryViews(String patientId)async{
    String response;
    try{
      response = await htsChannel.invokeMethod('getSexualHistoryViews', patientId);
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = SexualHistoryView.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
        print("Sexual hitsory list returned @@@@@@@@@@@"+ _entryPointList.toString());
      });
    }catch(e){
      print("Exception thrown in getsexualhistory view method"+e);
      
    }
  }


  List<DropdownMenuItem<String>>
  getDropDownMenuItemsHtsModel() {
    List<DropdownMenuItem<String>> items = new List();
    for (HtsModel htsModel in _htsModelList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: htsModel.code, child: Text(htsModel.name)));
    }
    return items;
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

  List<DropdownMenuItem<String>>
  _dropDownMenuItemsHtsModel,
      _dropDownMenuItemsPurposeOfTest;

  String  _currentHtsModel;
  String _currentPurposeOfTest;

  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsid),
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
            title: new Text("Impilo Mobile",   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ),

            ),
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
                                        viewportConstraints.maxHeight -
                                            48.0,
                                      ),
                                      child: new IntrinsicHeight(
                                        child: Column(
                                          children: <Widget>[
                                      /*      Form(
                                              key: _formKey,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget>[
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:        Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text('Ever exchanged money for sex ?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),

                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            _exchangedsexformoney,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleEXchangedSExForMoney),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                            _exchangedsexformoney,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleEXchangedSExForMoney),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue:
                                                            _exchangedsexformoney,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleEXchangedSExForMoney)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:        Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child:  Text("Injected recreational drugs ?"),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),

                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            _injecteddrugs,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleInjectedDrugsChange),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                            _injecteddrugs,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleInjectedDrugsChange),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue:
                                                            _injecteddrugs,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleInjectedDrugsChange)
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:            Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text("Been incarcerated into jail ?"),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            incarcetadintojail,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleBeenIncanedtIntoJail),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                            incarcetadintojail,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleBeenIncanedtIntoJail),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue:
                                                            incarcetadintojail,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleBeenIncanedtIntoJail)
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:            Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text("History of STI  ?"),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            historyofsti,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleStiHistory),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                            historyofsti,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleStiHistory),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue:
                                                            historyofsti,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleStiHistory)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:            Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text("Received blood transfusions"),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            medicaltrans,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleMedicalTrans),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                            medicaltrans,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleMedicalTrans),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue:
                                                            medicaltrans,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleMedicalTrans)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:            Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text("Received medical  injections ?"),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            _medicalinjections,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleMedicalInjections),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                            _medicalinjections,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleMedicalInjections),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue:
                                                            _medicalinjections,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleMedicalInjections)
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:            Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Text("Tatooed with unsterilised intstruments ?"),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            unsterilisedInstru,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleUnsterilisedINstru),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue:
                                                            unsterilisedInstru,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleUnsterilisedINstru),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue:
                                                            unsterilisedInstru,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleUnsterilisedINstru)
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(5.0)),
                                                      color: Colors.blue,
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Text(
                                                        "Proceed",
                                                        style: TextStyle(color: Colors.white),
                                                      ),
                                                      onPressed: () {
                                                        CbsQuestion cbsquestion = new CbsQuestion(widget.cbsQuestion.sexuallyactive, widget.cbsQuestion.age_whenclienthadfirstsexualintercourse, widget.cbsQuestion.numberofsexualpartners, widget.cbsQuestion.victimofsexualabuse, widget.cbsQuestion.hadsexwithmale, widget.cbsQuestion.hadsexwithfemale, widget.cbsQuestion.unprotectedsex,
                                                            widget.cbsQuestion.hadsexwithsexworker, widget.cbsQuestion.exchangedsexformoney, injectedrecreationaldrugs, beenincarcetadintojail, historyofSTI, receivedbloodtransfusion, unsterilisedinstruments);
                                                        Navigator.push(context,MaterialPageRoute(
                                                            builder: (context)=> CbsOverview(widget.person, cbsquestion, widget.htsid, widget.visitId, widget.personId)

                                                        ));


                                                      },
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 30.0,
                                                  ),
                                                ],
                                              ),
                                            ),*/
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

  void _handleEXchangedSExForMoney(int value) {
    setState(() {
      _exchangedsexformoney = value;

      switch (_exchangedsexformoney) {
        case 1:
          exchangedsexformoney = "YES";
          break;
        case 2:
          exchangedsexformoney = "NO";
          break;
        case 3:
          exchangedsexformoney = "REFUSE";

          break;
      }
    });
  }

  void _handleInjectedDrugsChange(int value) {
    setState(() {
      _injecteddrugs = value;

      switch (_injecteddrugs) {
        case 1:
          injectedrecreationaldrugs = "YES";
          break;
        case 2:
          injectedrecreationaldrugs = "NO";
          break;
        case 3:
          injectedrecreationaldrugs = "REFUSE";

          break;
      }
    });
  }
  void _handleBeenIncanedtIntoJail(int value) {
    setState(() {
      incarcetadintojail = value;

      switch (incarcetadintojail) {
        case 1:
          beenincarcetadintojail = "YES";
          break;
        case 2:
          beenincarcetadintojail = "NO";
          break;
        case 3:
          beenincarcetadintojail = "REFUSE";

          break;
      }
    });
  }
  void _handleStiHistory(int value) {
    setState(() {
      historyofsti = value;

      switch (historyofsti) {
        case 1:
          historyofSTI = "YES";
          break;
        case 2:
          historyofSTI = "NO";
          break;
        case 3:
          historyofSTI = "REFUSE";

          break;
      }
    });
  }
  void _handleMedicalTrans(int value) {
    setState(() {
      medicaltrans = value;

      switch (medicaltrans) {
        case 1:
          receivedbloodtransfusion = "YES";
          break;
        case 2:
          receivedbloodtransfusion = "NO";
          break;
        case 3:
          receivedbloodtransfusion = "REFUSE";

          break;
      }
    });
  }
  void _handleMedicalInjections(int value) {
    setState(() {
      _medicalinjections = value;

      switch (_medicalinjections) {
        case 1:
          medicalinjections = "YES";
          break;
        case 2:
          medicalinjections = "NO";
          break;
        case 3:
          medicalinjections = "REFUSE";

          break;
      }
    });
  }
  void _handleUnsterilisedINstru(int value) {
    setState(() {
      unsterilisedInstru = value;

      switch (unsterilisedInstru) {
        case 1:
          unsterilisedinstruments = "YES";
          break;
        case 2:
          unsterilisedinstruments = "NO";
          break;
        case 3:
          unsterilisedinstruments = "REFUSE";

          break;
      }
    });
  }

}


