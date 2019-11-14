import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/CbsQuestions.dart';
import 'package:ehr_mobile/model/sexualhistory.dart';


import 'package:ehr_mobile/view/hts_pretest_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/cbsquestion2.dart';

import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/hts_testing.dart';
import 'package:ehr_mobile/view/hts_testing.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/sexual_history_overview.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
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
  final _formKey = GlobalKey<FormState>();
  PreTest preTest;
  List<HtsModel> _htsModelList=List();
  List<PurposeOfTest> _purposeOfTestList= List();

  int _hts = 0;
  int _victim = 0;
  HtsRegistration htsRegistration;
  String sexuallyactive = "";
  String agewhenfirsthadsex;
  int numberOfSexualPartners;
  int numberofsexualpartnersinpast12months;
  var selectedMaleDate, selectedFemaleDate;
  DateTime maledate, femaledate;
  HtsModel htsModel;
  PurposeOfTest purposeOfTest;
  String victimofsexualabuse = "";

  bool _hadsexwithmale=false ;
  String hadsexwithmale = "NO";

  bool _hadsexwithfemale=false ;
  String hadsexwithfemale = "NO";

  bool _hadunprotectedsex=false ;
  String hadunprotectedsex = "NO";

  bool _hadsexwithsexworker=false ;
  String hadsexwithsexworker = "NO";

  bool _coupleCounselling=false;
  String coupleCounselling="NO";


  String purposeOfTestId;
  @override
  void initState() {
    //getDropDrowns();
    getHtsRecord(widget.personId);
    super.initState();
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
  Future<Null> _selectMaleDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedMaleDate)
      setState(() {
        selectedMaleDate = DateFormat("yyyy/MM/dd").format(picked);
        maledate = DateFormat("yyyy/MM/dd").parse(selectedMaleDate);
      });
  }
  Future<Null> _selectFemaleDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedFemaleDate)
      setState(() {
        selectedFemaleDate = DateFormat("yyyy/MM/dd").format(picked);
        femaledate = DateFormat("yyyy/MM/dd").parse(selectedFemaleDate);
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer:  new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("admin"), accountEmail: new Text("admin@gmail.com"), currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage('images/mhc.png'))),
            new ListTile(leading: new Icon(Icons.home, color: Colors.blue),title: new Text("Home "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchPatient()),
            )),
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
                                                              child: Text('Are you sexually active ?'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),

                                                        Text('YES'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue: _hts,
                                                            onChanged: _handleHtsChange),
                                                        Text('NO'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _hts,
                                                            onChanged: _handleHtsChange),
                                                        Text('REFUSE'),
                                                        Radio(
                                                            value: 3,
                                                            groupValue: _hts,
                                                            onChanged: _handleHtsChange)
                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:     Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  16.0,
                                                                  horizontal:
                                                                  60.0),
                                                              child:
                                                              TextFormField(
                                                                onSaved:
                                                                    (value) =>
                                                                    setState(
                                                                            () {
                                                                              numberOfSexualPartners  = int.parse(value);                                           }),
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
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:     Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  16.0,
                                                                  horizontal:
                                                                  60.0),
                                                              child:
                                                              TextFormField(
                                                                onSaved:
                                                                    (value) =>
                                                                    setState(
                                                                            () {
                                                                          numberofsexualpartnersinpast12months  = int.parse(value);                                           }),
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
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:              Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: 0.0, horizontal: 30.0),
                                                              child: TextFormField(
                                                                controller:
                                                                TextEditingController(text: selectedMaleDate),
                                                                decoration: InputDecoration(
                                                                    labelText: 'Date of Sex with Male ',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            icon: Icon(Icons.calendar_today),
                                                            color: Colors.blue,
                                                            onPressed: () {
                                                              _selectMaleDate(context);
                                                            })
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                    child:              Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: 0.0, horizontal: 30.0),
                                                              child: TextFormField(
                                                                controller:
                                                                TextEditingController(text: selectedFemaleDate),
                                                                decoration: InputDecoration(
                                                                    labelText: 'Date of Sex with Female ',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            icon: Icon(Icons.calendar_today),
                                                            color: Colors.blue,
                                                            onPressed: () {
                                                              _selectFemaleDate(context);
                                                            })
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
                                                      onPressed: () async {
                                                        if(_formKey.currentState.validate()){
                                                          _formKey.currentState.save();
                                                          SexualHistory sexualhistory = SexualHistory(widget.personId, sexuallyactive, maledate, femaledate, numberOfSexualPartners, numberofsexualpartnersinpast12months);
                                                          saveSexualHistory(sexualhistory);
                                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SexualHistoryOverview(widget.person, sexualhistory, widget.htsid, widget.visitId, widget.personId, widget.htsRegistration)));

                                                        }

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
  void _handleHtsChange(int value) {
    setState(() {
      _hts = value;

      switch (_hts) {
        case 1:
          sexuallyactive = 'YES';
          break;
        case 2:
          sexuallyactive = 'NO';
          break;
        case 3:
          sexuallyactive = 'REFUSE';
          break;
      }
    });
  }

Future<void>saveSexualHistory(SexualHistory sexualHistory) async{
    var response ;
    try{
   await htsChannel.invokeMethod('saveSexualHistory', jsonEncode(sexualHistory));


} catch(e){
    }
}

}


