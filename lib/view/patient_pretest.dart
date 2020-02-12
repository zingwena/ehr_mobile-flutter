import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/model/purposeOfTest.dart';
import 'package:ehr_mobile/model/htsModel.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/login_screen.dart';
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
import 'sexualhistoryform.dart';
import 'edit_demographics.dart';
import 'hts_testscreening.dart';
import 'rounded_button.dart';

class PatientPretest extends StatefulWidget {

  final String htsid ;
  final String personId;
  final HtsRegistration htsRegistration;
  final String visitId;
  final Person person;
  PatientPretest(this.personId, this.htsid, this.htsRegistration, this.visitId, this.person);

  @override
  State createState() {
    return _PatientPretest();
  }
}

class _PatientPretest extends State<PatientPretest> {
  static const platform = MethodChannel('example.channel.dev/people');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');

  final _formKey = GlobalKey<FormState>();
  PreTest preTest;
  List<HtsModel> _htsModelList=List();
  List<PurposeOfTest> _purposeOfTestList= List();

  int _hts = 0;
 // String _coupleCounselling="" ;
  String _newTest = " " ;
  String _htsApproach="" ;
  HtsRegistration htsRegistration;

  int _newTestInPreg = 0;
  bool newTestInPreg = false;

  int _newTestInLife = 0;
  bool newTestInLife = false;

  HtsModel htsModel;
  PurposeOfTest purposeOfTest;

  int _patientPretest = 0;
  PreTest patient_preTest;


  int _preTestInfoGiven=0 ;
  bool preTestInfoGiven = false;

  int _optOutOfTest= 0 ;
  bool optOutOfTest = false;

  int _coupleCounselling= 0;
  bool coupleCounselling=false;


  String purposeOfTestId;

  String facility_name;

  bool showApproachError = false;
  bool approachSelected = false;

  bool showModelError = false;
  bool modelSelected = false;

   bool showPurposeError = false;
   bool purposeSelected = false;

   bool shownewTestError = false;
   bool newTestSelected = false;

   bool showCoupleCounselling = false;
   bool coupleCounsellingSelected  = false;

   bool pretestInfoGivenSelected = false;
   bool showPretestInfoError = false;
  Age age;
  @override
  void initState() {
  getDropDrowns();
  getHtsRecord(widget.personId);
  getFacilityName();
  getAge(widget.person);
    super.initState();
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

  Future<void> insertPreTest(PreTest preTest) async {
    String pretestjson;
    try {
        pretestjson =  await htsChannel.invokeMethod('savePreTest',  jsonEncode(preTest));
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

  Future<void> getDropDrowns() async {

    List htsModelList = [];
    List purposeOfTestList = [];

    try {
      htsModelList= jsonDecode(await htsChannel.invokeMethod('htsModelOptions'));

      purposeOfTestList= jsonDecode(await htsChannel.invokeMethod('purposeOfTestsOptions'));
      print('PURPOSE OF TEST LIST >>>>>>>>>>>>>>>>>>>>>' + purposeOfTestList.toString());

       } catch (e) {
      print("channel failure: '$e'");
    }

    setState(() {
      _htsModelList = HtsModel.mapFromJson(htsModelList);
      _purposeOfTestList = PurposeOfTest.mapFromJson(purposeOfTestList);


      _dropDownMenuItemsHtsModel =
          getDropDownMenuItemsHtsModel();

      _dropDownMenuItemsPurposeOfTest =
          getDropDownMenuItemsPurposeOfTest();

    });
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

   void _handleHtsChange(int value) {
    setState(() {
      _hts = value;

      switch (_hts) {
        case 1:
          _htsApproach = "PITC";
          approachSelected = true;
          break;
        case 2:
          _htsApproach = "CITC";
          approachSelected = true;
          break;
      }
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
      drawer:  Sidebar(widget.person, widget.personId, widget.visitId, htsRegistration, widget.htsid),
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
                    child: Text("Patient Pre-Test", style: TextStyle(
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

                                                    SizedBox(
                                                      height: 25.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text('HTS Approach'),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('PITC'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _hts,
                                                              onChanged: _handleHtsChange),
                                                          Text('CITC'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _hts,
                                                              onChanged: _handleHtsChange)
                                                        ],
                                                      ),
                                                    ),

                                                    showApproachError == true ? Container(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 65), child: Text("Select HTS Approach ", style: TextStyle(color: Colors.red, fontSize: 15),),
                                                    ):SizedBox(height: 0.0, width: 0.0,),

                                                    SizedBox(
                                                      height: 15.0,
                                                    ),

                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60),
                                                      width: double.infinity,
                                                      child: OutlineButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0)),
                                                        color: Colors.white,
                                                        padding: const EdgeInsets.all(0.0),
                                                        child: Container(
                                                          width: double.infinity,
                                                          padding: EdgeInsets.symmetric(
                                                              vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            iconEnabledColor: Colors.black,
                                                            hint: Text('Select Hts model'),
                                                            value: _currentHtsModel,
                                                            items: _dropDownMenuItemsHtsModel,
                                                            onChanged: changedDropDownItemHtsModel,
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
                                                    showModelError == true ? Container(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 65),
                                                       child: Text("Select HTS Model ", style: TextStyle(color: Colors.red, fontSize: 15),),
                                                    ):SizedBox(height: 0.0, width: 0.0,),

                                                    SizedBox(
                                                      height: 15.0,
                                                    ),

                                                    Container(
                                                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60),
                                                      width: double.infinity,
                                                      child: OutlineButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0)),
                                                        color: Colors.white,
                                                        padding: const EdgeInsets.all(0.0),
                                                        child: Container(
                                                          width: double.infinity,
                                                          padding: EdgeInsets.symmetric(
                                                              vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            iconEnabledColor: Colors.black,
                                                            hint: Text('Select Purpose of Test'),
                                                            value: _currentPurposeOfTest,
                                                            items: _dropDownMenuItemsPurposeOfTest,
                                                            onChanged: changedDropDownItemPurposeOfTest,
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
                                                    showPurposeError == true ? Container(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 65), child: Text("Select Purpose of Test", style: TextStyle(color: Colors.red, fontSize: 15),),
                                                    ):SizedBox(height: 0.0, width: 0.0,),

                                                    SizedBox(
                                                      height: 25.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 60.0),
                                                      child:        Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text('New test in patients life?'),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _newTestInLife,
                                                              onChanged: _handleNewTestInLife),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _newTestInLife,
                                                              onChanged: _handleNewTestInLife)

                                                        ],
                                                      ),
                                                    ),
                                                    shownewTestError == true ? Container(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 65), child: Text("Select New Test Option?  ", style: TextStyle(color: Colors.red, fontSize: 15),),
                                                    ):SizedBox(height: 0.0, width: 0.0,),

                                                    SizedBox(
                                                      height: 25.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 60.0),
                                                      child:        Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child:  Text("Couple Counselling"),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _coupleCounselling,
                                                              onChanged: _handleCoupleCounselling),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _coupleCounselling,
                                                              onChanged: _handleCoupleCounselling)
                                                        ],
                                                      ),
                                                    ),
                                                    showCoupleCounselling == true ? Container(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 65), child: Text("Select Couple Counselling Option?  ", style: TextStyle(color: Colors.red, fontSize: 15),),
                                                    ):SizedBox(height: 0.0, width: 0.0,),

                                                    SizedBox(
                                                      height: 25.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 60.0),
                                                      child:        Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child:  Text("Pre-test Information given"),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _preTestInfoGiven,
                                                              onChanged: _handlePretestInfoGiven),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _preTestInfoGiven,
                                                              onChanged: _handlePretestInfoGiven)

                                                        ],
                                                      ),
                                                    ),
                                                    showPretestInfoError == true ? Container(
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 65), child: Text("Select Pretest Info Given Option?  ", style: TextStyle(color: Colors.red, fontSize: 15),),
                                                    ):SizedBox(height: 0.0, width: 0.0,),

                                                    pregnatandlactatingqstn(),
                                                     Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child:            Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text("Opt Out Of Test"),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('YES'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _optOutOfTest,
                                                              onChanged: _handleOptOutOfTest),
                                                          Text('NO'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _optOutOfTest,
                                                              onChanged: _handleOptOutOfTest)

                                                        ],
                                                      ),
                                                    ),


                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 55.5),
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
                                                            Text('Save', style: TextStyle(color: Colors.white),),
                                                            Spacer(),
                                                            Icon(Icons.save_alt, color: Colors.white, ),
                                                          ],
                                                        ),
                                                        onPressed: ()async {
                                                          if (_formKey.currentState.validate()) {
                                                            _formKey.currentState.save();
                                                            if(approachSelected & modelSelected&purposeSelected
                                                            &newTestSelected &pretestInfoGivenSelected&coupleCounsellingSelected){
                                                            //  getPurposeByName(_currentPurposeOfTest);
                                                           // getHtsModelByName(_currentHtsModel);
                                                            PreTest patient_pretest_obj = PreTest(widget.personId, widget.htsid,_htsApproach, _currentHtsModel, newTestInLife,
                                                                coupleCounselling,preTestInfoGiven,optOutOfTest,newTestInPreg,_currentPurposeOfTest);
                                                             await insertPreTest(patient_pretest_obj);
                                                            if(patient_pretest_obj.optOutOfTest ){
                                                              Navigator.push(context,MaterialPageRoute(
                                                                  builder: (context)=> Overview(widget.person)
                                                              ));
                                                            } else {
                                                              Navigator.push(context,MaterialPageRoute(
                                                                  builder: (context)=> PretestOverview(patient_preTest, widget.htsRegistration, widget.personId, widget.htsid, widget.visitId, widget.person)
                                                              ));
                                                            }
                                                            }else{

                                                              if(approachSelected == false){
                                                                setState(() {
                                                                  showApproachError = true;
                                                                });
                                                              }
                                                              if(pretestInfoGivenSelected == false){
                                                                setState(() {
                                                                  showPretestInfoError = true;
                                                                });
                                                              }
                                                              if(coupleCounsellingSelected == false){
                                                                setState(() {
                                                                  showCoupleCounselling = true;
                                                                });
                                                              }
                                                              if(newTestSelected == false){
                                                                setState(() {
                                                                  shownewTestError = true;
                                                                });
                                                              }
                                                              if(purposeSelected == false){
                                                                setState(() {
                                                                  showPurposeError = true;
                                                                });
                                                              }
                                                              if(modelSelected == false){
                                                                setState(() {
                                                                  showModelError = true;
                                                                });
                                                              }
                                                            }

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
            Text('YES'),
            Radio(
                value: 1,
                groupValue: _newTestInPreg,
                onChanged: _handleNewTestInPreg),
            Text('NO'),
            Radio(
                value: 2,
                groupValue: _newTestInPreg,
                onChanged: _handleNewTestInPreg)
          ],
        ),
      );

} else{
      return  SizedBox(
        height: 10.0,
      );
    }
}
  void changedDropDownItemHtsModel(String value) {
    setState(() {
      _currentHtsModel = value;
      modelSelected = true;

    });
  }

  void changedDropDownItemPurposeOfTest(String value) {
    setState(() {
      _currentPurposeOfTest = value;
      purposeSelected = true;

    });
  }
  void _handleOptOutOfTest(int value) {
    setState(() {
      _optOutOfTest = value;

      switch (_optOutOfTest) {
        case 1:
          optOutOfTest = true;
          break;
        case 2:
          optOutOfTest = false;
          break;
      }
    });
  }
  void _handleNewTestInPreg(int value) {
    setState(() {
      _newTestInPreg = value;

      switch (_newTestInPreg) {
        case 1:
          newTestInPreg = true;
          break;
        case 2:
          newTestInPreg = false;
          break;
      }
    });
  }
  void _handleCoupleCounselling(int value) {
    setState(() {
      _coupleCounselling = value;

      switch (_coupleCounselling) {
        case 1:
          coupleCounselling = true;
          coupleCounsellingSelected = true;
          break;
        case 2:
          coupleCounselling = false;
          coupleCounsellingSelected = true;
          break;
      }
    });
  }
  void _handleNewTestInLife(int value) {
    setState(() {
      _newTestInLife = value;

      switch (_newTestInLife) {
        case 1:
          newTestInLife = true;
          newTestSelected = true;
          break;
        case 2:
          newTestInLife = false;
          newTestSelected = true;
          break;
      }
    });
  }


  void _handlePretestInfoGiven(int value) {
    setState(() {
      _preTestInfoGiven = value;

      switch (_preTestInfoGiven) {
        case 1:
          preTestInfoGiven = true;
          pretestInfoGivenSelected = true;
          break;
        case 2:
          preTestInfoGiven = false;
          pretestInfoGivenSelected = true;
          break;
      }
    });
  }

}


