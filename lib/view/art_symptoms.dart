import 'dart:convert';

import 'package:ehr_mobile/model/artsymptom.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/sexualhistoryview.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/sexual_history_overview.dart';
import 'package:ehr_mobile/view/sexual_history_qn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import '../sidebar.dart';
import 'art_newOS.dart';
import 'art_symptomview.dart';

class ArtSymptoms extends StatefulWidget {
  final String htsid;
  final String personId;
  final HtsRegistration htsRegistration;
  final String visitId;
  final Person person;

  ArtSymptoms(this.personId, this.htsid, this.htsRegistration, this.visitId,
      this.person);

  @override
  State createState() {
    return _ArtSymptomState();
  }
}

class _ArtSymptomState extends State<ArtSymptoms> {
  static const platform = MethodChannel('example.channel.dev/people');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');

  final _formKey = GlobalKey<FormState>();
  PreTest preTest;
  List<HtsModel> _htsModelList = List();
  List<PurposeOfTest> _purposeOfTestList = List();

  int _hts = 0;
  String _picked = 'Two';
  String _newTest = " ";
  String _htsApproach = "";

  HtsRegistration htsRegistration;
  int _exchangedsexformoney = 0;
  int _injecteddrugs = 0;
  int incarcetadintojail = 0;
  int historyofsti = 0;
  int medicaltrans = 0;
  int _medicalinjections = 0;
  int _response = 0;
  String exchangedsexformoney = "";
  String agewhenfirsthadsex;
  String numberofsexualpartners;
  HtsModel htsModel;
  PurposeOfTest purposeOfTest;
  PreTest patient_preTest;
  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  String purposeOfTestId;
  List<ArtSymptom> _entryPointList = List();
  int _question_response = 0;
  String response;
  int random_number;
  var random_string;
  Age age;

  String facility_name;

  @override
  void initState() {
    getHtsRecord(widget.personId);
    getArtSymptoms(widget.personId);
    getAge(widget.person);
    getFacilityName();
    super.initState();
  }

  Future<void> insertPreTest(PreTest preTest) async {
    String pretestjson;
    try {
      pretestjson =
      await htsChannel.invokeMethod('savePreTest', jsonEncode(preTest));
      setState(() {
        patient_preTest = PreTest.fromJson(jsonDecode(pretestjson));
      });
    } catch (e) {
      print("channel failure: '$e'");
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


  Future<void>getAge(Person person)async{
    String response;
    try{
      response = await dataChannel.invokeMethod('getage', person.id);
      setState(() {
        age = Age.fromJson(jsonDecode(response));
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
  }

  Future<void> getHtsModelByName(String htsmodelstring) async {
    var model_response;
    try {
      model_response =
      await htsChannel.invokeMethod('getHtsModel', htsmodelstring);
      setState(() {
        htsModel = HtsModel.mapFromJson(model_response);
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  Future<void> getPurposeByName(String purposemodelstring) async {
    var model_response;
    try {
      model_response =
      await htsChannel.invokeMethod('getPurposeofTest', purposemodelstring);
      setState(() {
        purposeOfTest = PurposeOfTest.mapFromJson(model_response);
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  Future<void> getArtSymptoms(String patientId) async {
    String response;
    try {
      response =
      await artChannel.invokeMethod('getArtSymptom', patientId);
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = ArtSymptom.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
      });
    } catch (e) {
      print("Exception thrown in getsexualhistory view method" + e);
    }
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsHtsModel() {
    List<DropdownMenuItem<String>> items = new List();
    for (HtsModel htsModel in _htsModelList) {
      items.add(
          DropdownMenuItem(value: htsModel.code, child: Text(htsModel.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsPurposeOfTest() {
    List<DropdownMenuItem<String>> items = new List();
    for (PurposeOfTest purposeOfTest in _purposeOfTestList) {
      items.add(DropdownMenuItem(
          value: purposeOfTest.code, child: Text(purposeOfTest.name)));
    }
    return items;
  }

  Future<void> getHtsRecord(String patientId) async {
    var hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      setState(() {
        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
        print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());
      });
      print('HTS IN THE FLUTTER THE RETURNED ONE ' + hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  List<DropdownMenuItem<String>> _dropDownMenuItemsHtsModel,
      _dropDownMenuItemsPurposeOfTest;

  String _currentHtsModel;
  String _currentPurposeOfTest;

  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.personId, widget.visitId,
          widget.htsRegistration, widget.htsid),
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
                      "Art Symptoms",
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
                          ])),
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
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            getArtSymptomWidgets(_entryPointList,  widget.personId),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: SizedBox(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 55.5),
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
                                                          onPressed: ()  {
                                                            Navigator.push(context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>   ArtNewOI(widget.personId, widget.htsid, widget.htsRegistration, widget.visitId,
                                                                        widget.person)

                                                                ));
                                                          }
                                                      ),
                                                    ),
                                                    width: 100,
                                                  ),
                                                ),

                                              ],
                                            ),

                                            SizedBox(
                                              height: 20.0,
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

}

Widget getArtSymptomWidgets(List<ArtSymptom> artsymptoms,String personId) {

  return new Column(
      children: artsymptoms
          .map(
              (item) => ArtSymptomView(item,  personId, true)
      )
          .toList());
}



