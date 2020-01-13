import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/model/preTest.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/hts_testscreening.dart';
import 'package:ehr_mobile/view/hts_result.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/vitals/visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';
import 'sexualhistoryform.dart';
import 'rounded_button.dart';
import 'home_page.dart';
import 'hts_testscreening.dart';
import 'hts_registration.dart';
import 'reception_vitals.dart';
import 'package:ehr_mobile/model/address.dart';

class PretestOverview extends StatefulWidget {
  final PreTest preTest;
 final HtsRegistration htsRegistration;
 final String htsId ;
 final String personId;
 final String visitId;
 final Person person;
  PretestOverview(this.preTest, this.htsRegistration, this.personId, this.htsId, this.visitId, this.person);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PretestOverviewState();
  }
}

class PretestOverviewState extends State<PretestOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static final MethodChannel patientChannel = MethodChannel(
      'zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  Person _patient;
  Visit _visit;
  HtsRegistration _htsRegistration;
  Map<String, dynamic> details;
  String _maritalStatus,_educationLevel,_occupation,_nationality, _address, _phonenumber;

  bool showInput = true;
  bool showInputTabOptions = true;
  String visitId="1";
  String htsApproach;
  String _htsModelId;
  String final_result;
  bool newTest;
  String _newTest;
  String coupleCounselling;
  HtsRegistration htsRegistration;
  bool preTestInformationGiven;
  String _pretestInfoGiven;
  String labInvestId;
  String labInvestTestId;

  bool optOutOfTest;
  String _optOutOfTest;

  bool newTestPregLact;
  String _newTestPregLact;

  String purposeOfTestId;

  @override
  void initState() {
     getHtsModel(widget.preTest.htsModelId);
     getHtsRecord(widget.personId);
     getLabInvestigation(widget.personId);

     if(widget.preTest.newTest == false){
       _newTest = "NO";
     }else{
       _newTest = "YES";

     }
     if(widget.preTest.preTestInformationGiven){
       _pretestInfoGiven = "YES";

     }else{
       _pretestInfoGiven = "NO";

     }
     if(widget.preTest.newTestPregLact){
       _newTestPregLact = "YES";

     }else{
       _newTestPregLact = "NO";

     }
     if(widget.preTest.optOutOfTest){
       _optOutOfTest = "YES";
     }else{
      _optOutOfTest = "NO";
     }
     if(widget.preTest.coupleCounselling){
       coupleCounselling = "YES";
     }else{
       coupleCounselling = "NO";
     }
    super.initState();
  }

  Future<void> getVisit(String patientId) async {
    Visit visit;

    try {
      visit = jsonDecode(
          await platform.invokeMethod('visit', patientId)
      );
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _visit = visit;
    });


  }


  Future<void> getHtsModel(String htsModelId) async {
   String htsModel;

    try {
      htsModel = await htsChannel.invokeMethod('getHtsModel', htsModelId);
      print('KKKKKKKKKKKKKKKK' + htsModel);
      setState(() {
        _htsModelId = htsModel;
      });

    } catch (e) {
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
  Future<dynamic> getLabInvestigation(String personId) async {

    try {
      String response = await htsChannel.invokeMethod('getLabInvestigation', personId);
      setState(() {
        labInvestId = response;
        print("@@@@@@@@@@@@@@@@@@@@@@ labinvest @@@@@@@@@@@@"+ labInvestId);
        getFinalResult(labInvestId);
        getLabInvestigationTest(labInvestId);

      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<dynamic> getLabInvestigationTest(String labInvestigationId) async {

    try {
      String response = await htsChannel.invokeMethod('getLabInvestigationTest', labInvestigationId);
      setState(() {
        labInvestTestId = response;
        getFinalResult(labInvestId);

      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }
  Future<void> getFinalResult(labInvestId) async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getFinalResult',labInvestId);
    } catch (e) {
      print('--------------something went wrong  $e');
    }
    setState(() {
      if(response == null){
        final_result = '';
      } else{

        final_result = response;

      }
    });
  }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId),
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
                  top: MediaQuery
                      .of(context)
                      .padding
                      .top + 40.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Pre-Test Overview", style: TextStyle(
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
                  _buildButtonsRow(),
                  Expanded(child: WillPopScope(
                    onWillPop: () {
                      if (!showInput) {
                        setState(() {
                          showInput = true;
                          showInputTabOptions = true;
                        });
                        return Future(() => false);
                      } else {
                        return Future(() => true);
                      }
                    },
                    child: new Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                        child: new LayoutBuilder(
                          builder:
                              (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return Column(
                              children: <Widget>[
                                //   _buildTabBar(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: new ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minHeight: viewportConstraints
                                            .maxHeight - 48.0,
                                      ),
                                      child: new IntrinsicHeight(
                                          child: Column(
                                            children: <Widget>[
                                              Form(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                    children: <Widget>[

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: widget.preTest.htsApproach),
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                    labelText: "Hts Approach",
                                                                    hintText: "Hts Approach"
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _htsModelId)),
                                                                decoration: InputDecoration(
                                                                    icon: new Icon(Icons.credit_card, color: Colors.blue),
                                                                    labelText: "Hts Model",
                                                                    hintText: "Hts Model"
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _newTest)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'New Test ?',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        coupleCounselling)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Couple counselling ?',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _pretestInfoGiven)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Pretest Info given ?',
                                                                  icon: new Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _newTestPregLact)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'New Test for pregnant women ?',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        _optOutOfTest)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Opt out of test ?',
                                                                  icon: Icon(Icons.credit_card, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: Container()),
                                              /*  Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16.0, top: 8.0),
                                              child: FloatingActionButton(
                                                onPressed: () =>
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddPatient()),
                                                    ),
                                                child: Icon(
                                                    Icons.add, size: 36.0),
                                              ),
                                            ), */
                                            ],
                                          )

                                      ),
                                    ),
                                  ),
                                )
                              ]
                              ,
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
    );
  }

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "HTS Registration", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HtsRegOverview(widget.htsRegistration,widget.personId, widget.htsId, widget.visitId, widget.person
                        )),
          ),
          ),

      new RoundedButton(text: "HTS Pre-Testing", selected: true,
          ),


          new RoundedButton(text: "Testing", onTap: () {
            if(final_result == null || final_result == ''  || final_result == 'Pending'){
             Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) =>
            HtsScreeningTest(widget.personId, widget.visitId, widget.person, widget.htsId, widget.htsRegistration)),
            );
            } else{
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Hts_Result(widget.personId, labInvestTestId, widget.visitId, labInvestId, widget.person, widget.htsId, widget.htsRegistration)),
              );

            }
          } ,),

        ],
      ),
    );
  }

  Future<void> getDetails(String maritalStatusId,String educationLevelId,String occupationId,String nationalityId, String patientId) async{
    String maritalStatus,educationLevel,occupation,nationality, address, patientphonenumber;
    try{

      maritalStatus = await patientChannel.invokeMethod('getPatientMaritalStatus',maritalStatusId);
      educationLevel = await patientChannel.invokeMethod('getEducationLevel',educationLevelId);
      occupation = await patientChannel.invokeMethod('getOccupation',occupationId);
      nationality = await patientChannel.invokeMethod('getNationality',nationalityId);
      address = await patientChannel.invokeMethod('getAddress', patientId);
      patientphonenumber = await patientChannel.invokeMethod('getPhonenumber', patientId);


      print('ADDRESS ADDRESS'+ address);

    }
    catch (e) {
      print(
          'Something went wrong during getting marital status........cause $e');
    }

    setState(() {
      _maritalStatus = maritalStatus;
      _educationLevel = educationLevel;
      _occupation = occupation;
      _nationality = nationality;
      _address = address;
      _phonenumber = patientphonenumber;
    });
    print('9999999999999999999999999999999999999999999999999999 $_phonenumber');

  }


}






