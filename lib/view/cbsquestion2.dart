import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/CbsQuestions.dart';
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
  bool _newTestInPreg = false;

  bool _exchangedsexformoney = false;
  String exchangedsexformoney = "";
  String agewhenfirsthadsex;
  String numberofsexualpartners;
  HtsModel htsModel;
  PurposeOfTest purposeOfTest;

  int _patientPretest = 0;
  //int _optOutTest = 0;
  PreTest patient_preTest;


  bool _injectedrecreationaldrugs=false ;
  String injectedrecreationaldrugs = "NO";

  bool _beenincarcetadintojail=false ;
  String beenincarcetadintojail = "NO";

  bool _historyofSTI=false ;
  String historyofSTI = "NO";

  bool _medicalinjections=false ;
  String  medicalinjections= "NO";

  bool _receivedbloodtransfusion=false ;
  String receivedbloodtransfusion = "NO";

  bool _unsterilisedinstruments=false ;
  String unsterilisedinstruments = "NO";





  String purposeOfTestId;
  @override
  void initState() {
    //getDropDrowns();
    getHtsRecord(widget.personId);
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
      htsModel = HtsModel.mapFromJson(model_response);

    }catch (e){
      print("channel failure: '$e'");

    }
  }
  Future <void> getPurposeByName(String purposemodelstring) async{
    var model_response;
    try{
      model_response = await htsChannel.invokeMethod('getPurposeofTest', purposemodelstring);
      purposeOfTest = PurposeOfTest.mapFromJson(model_response);

    }catch (e){
      print("channel failure: '$e'");

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
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {

      htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
      print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());

    });


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
      drawer:  new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("admin"), accountEmail: new Text("admin@gmail.com"), currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage('images/mhc.png'))),
            new ListTile(title: new Text("Patient Overview "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Overview(widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Vitals"), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(widget.personId, widget.visitId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("HTS"), onTap: () {
              if(htsRegistration == null ){
                print('bbbbbbbbbbbbbb htsreg null in side bar  ');
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>  Registration(widget.visitId, widget.personId, widget.person)
                ));
              } else {
                print('bbbbbbbbbbbbbb htsreg  not null in side bar ');

                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=> HtsRegOverview(htsRegistration, widget.personId, widget.htsid, widget.visitId, widget.person)
                ));
              }
            }),
            new ListTile( leading: new Icon(Icons.book, color: Colors.blue),title: new Text("ART"), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArtReg(widget.personId, widget.visitId, widget.person, widget.htsRegistration)),
            ))

          ],
        ),
      ),
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
              title: new Column(children: <Widget>[
                new Text("Sexual History"),
                new Text("Patient Name : " + " "+ widget.person.firstName + " " + widget.person.lastName)

              ],)
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
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
                                            Form(
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

                                                        Checkbox(
                                                          value:_exchangedsexformoney,
                                                          onChanged: (bool value) {
                                                            setState(() {
                                                              _exchangedsexformoney=value;
                                                            });
                                                            if(value) {
                                                              setState(() {
                                                                _exchangedsexformoney=true;
                                                              });
                                                            }
                                                          },
                                                        ),
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

                                                        Checkbox(
                                                          value:_injectedrecreationaldrugs,
                                                          onChanged: (bool value) {
                                                            setState(() {
                                                              _injectedrecreationaldrugs=value;
                                                            });
                                                            if(value) {
                                                              setState(() {
                                                                _injectedrecreationaldrugs = true;
                                                              });
                                                            }
                                                          },
                                                        ),
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
                                                        Checkbox(
                                                          value:_beenincarcetadintojail,
                                                          onChanged: (bool value) {
                                                            setState(() {
                                                              _beenincarcetadintojail=value;
                                                            });
                                                            if(value) {
                                                              setState(() {
                                                                _beenincarcetadintojail=true;
                                                              });
                                                            }
                                                          },
                                                        ),
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
                                                        Checkbox(
                                                          value:_historyofSTI,
                                                          onChanged: (bool value) {
                                                            setState(() {
                                                              _historyofSTI=value;
                                                            });
                                                            if(value) {
                                                              setState(() {
                                                                _historyofSTI=true;
                                                              });
                                                            }
                                                          },
                                                        ),
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
                                                              child: Text("Received medical injections"),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Checkbox(
                                                          value:_medicalinjections,
                                                          onChanged: (bool value) {
                                                            setState(() {
                                                              _medicalinjections=value;
                                                            });
                                                            if(value) {
                                                              setState(() {
                                                                _medicalinjections=true;
                                                              });
                                                            }
                                                          },
                                                        ),
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
                                                              child: Text("Received blood transfusions ?"),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Checkbox(
                                                          value:_receivedbloodtransfusion,
                                                          onChanged: (bool value) {
                                                            setState(() {
                                                              _receivedbloodtransfusion=value;
                                                            });
                                                            if(value) {
                                                              setState(() {
                                                                _receivedbloodtransfusion=true;
                                                              });
                                                            }
                                                          },
                                                        ),
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
                                                        Checkbox(
                                                          value:_unsterilisedinstruments,
                                                          onChanged: (bool value) {
                                                            setState(() {
                                                              _unsterilisedinstruments=value;
                                                            });
                                                            if(value) {
                                                              setState(() {
                                                                _unsterilisedinstruments=true;
                                                              });
                                                            }
                                                          },
                                                        ),
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
                                                       /* CbsQuestion cbsquestion = new CbsQuestion(widget.cbsQuestion.sexuallyactive, widget.cbsQuestion.age_whenclienthadfirstsexualintercourse, widget.cbsQuestion.numberofsexualpartners, widget.cbsQuestion.victimofsexualabuse, widget.cbsQuestion.hadsexwithmale, widget.cbsQuestion.hadsexwithfemale, widget.cbsQuestion.unprotectedsex,
                                                            widget.cbsQuestion.hadsexwithsexworker, widget.cbsQuestion.exchangedsexformoney, _injectedrecreationaldrugs, _beenincarcetadintojail, _historyofSTI, _receivedbloodtransfusion, _unsterilisedinstruments);*/
                                                      /*  Navigator.push(context,MaterialPageRoute(
                                                            builder: (context)=> CbsOverview(widget.person, cbsquestion, widget.htsid, widget.visitId, widget.personId)

                                                        ));*/


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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "HTS Registration", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HtsRegOverview(widget.htsRegistration, widget.personId, widget.htsid, widget.visitId, widget.person
                    )),
          ),
          ),
          //HtsRegOverview(this.htsRegistration, this.personId, this.htsid);

          new RoundedButton(
            text: "HTS Pre-Testing", selected: true,

          ),
          new RoundedButton(text: "Testing",
          ),
        ],
      ),
    );
  }
  Widget pregnatandlactatingqstn(){
    if(widget.person.sex ==" female" || widget.person.sex == "FEMALE" || widget.person.sex == "Female"){
      return     Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
        child:            Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'New test for pregnant and lactating women.'),
                ),
                width: 250,
              ),
            ),
            Checkbox(
              value:_newTestInPreg,
              onChanged: (bool value) {
                setState(() {
                  _newTestInPreg=value;
                });
                if(value) {
                  setState(() {
                    _newTestInPreg=true;
                  });
                }
              },
            ),
          ],
        ),
      );

    } else{
      return  SizedBox(
        height: 10.0,
      );
    }
  }

}


