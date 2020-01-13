import 'dart:convert';
import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/hts_testing.dart';
import 'package:ehr_mobile/view/hts_testscreening.dart';
import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';
import 'rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
class Hts_Result extends StatefulWidget {
  final String visitId;
  final  String patientId;
  final  String labInvetsTestId;
  final String labInvestId;
  final Person person;
  final  String htsId;
  final HtsRegistration htsRegistration;

  Hts_Result(this.patientId, this.labInvetsTestId, this.visitId, this.labInvestId, this.person, this.htsId, this.htsRegistration);

  //Hts_Result (this.visitId, this.patientId);

  @override
  State createState() {
    return _Hts_Result ();
  }
}

class _Hts_Result  extends State<Hts_Result > {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  String _visitId;
  String patientId;
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
  String _labinvestigation_string;
  List labinvestigationlist = List();
  List _labinvestigations = List();
  String hts_id;
  String testkit;
  String startTime;
  String endTime;
  bool showInput = true;
  bool showInputTabOptions = true;
  String final_result = 'Pending';
  List<DropdownMenuItem<String>> _dropDownMenuItemsEntryPoint;
  List<LaboratoryInvestigationTest> _labinvestList = List();
  String test_name;
  String _currentEntryPoint;

  @override
  void initState() {
    _visitId = widget.visitId;
//    patient id
    patientId = widget.patientId;
    labInvetsTestId = widget.labInvetsTestId;

    //getEndTime(widget.labInvetsTestId);
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();

    getFinalResult(widget.labInvestId);
    getLabInvestigationTests();
    // getLabInvestigationTests();
    getTestKIt(widget.labInvetsTestId);
    //getStartTime(widget.labInvetsTestId);
    //getHtsRecord(widget.patientId);
    getTestName();
    super.initState();
  }

  Future<void> getLabInvestigationTests() async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getLabInvestigations', widget.visitId);
      setState(() {
        {
          _labinvestigation_string = response;
          labinvestigationlist = jsonDecode(_labinvestigation_string);
          _labinvestigations = LaboratoryInvestigationTest.mapFromJson(labinvestigationlist);
          _labinvestigations.forEach((e) {
            _labinvestList.add(e);
          });
        }
      });

    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }
  Future<void>getTestName()async{
    try{
      String response = await htsChannel.invokeMethod('getTestName', widget.labInvestId);
      setState(() {
        test_name = response;

      });

    }catch(e){
      print('--------------------Something went wrong  $e');


    }
  }

  Future<void> getHtsRecord(String patientId) async {
    var  hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      setState(() {

        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));

      });
    } catch (e) {
      print("channel failure: '$e'");
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Sidebar(widget.person, widget.patientId, widget.visitId, htsRegistration, widget.htsId),
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
            height: 240.0,
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
                    child: Text("HTS Test Results", style: TextStyle(
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
                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "Sample :",
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(0.0),
                                                                child: Text(
                                                                  ("Blood"),
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
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
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "Investigation:",
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(0.0),
                                                                child: Text(
                                                                  ("HIV"),
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: 10.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                      child: DataTable(
                                                        columns: [
                                                          DataColumn(label: Text("TestKit")),
                                                          DataColumn(label: Text("Result")),
                                                          DataColumn(label: Text("Start Time")),
                                                          DataColumn(label: Text("End Time"))],
                                                      rows: _labinvestList.map((labinvesttest)=>
                                                       DataRow(
                                                           cells: [
                                                       DataCell(Text(labinvesttest.testkit.name)),
                                                       DataCell(Text(labinvesttest.result.name)),
                                                       DataCell(Text(labinvesttest.startTime)),
                                                       DataCell(Text(labinvesttest.endTime))])

                                                      ).toList()


                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: 10.0,
                                                    ),


                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "Final Result:",
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(0.0),
                                                                child: Text(
                                                                  (final_result),
                                                                  style: TextStyle(
                                                                    color: Colors.grey.shade600,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: 30.0,
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
                                                        child: getNextTestButton(),
                                                          onPressed: ()  {
                                                            if (final_result == 'Pending' || final_result == '') {
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HtsScreeningTest(widget.patientId, widget.visitId, widget.person, widget.htsId, widget.htsRegistration)));

                                                            }else{
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientPostTest(this.final_result, this.patientId, this._visitId, widget.person, widget.htsId, widget.htsRegistration)));
                                                            }
                                                          }
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "HTS Registration",
          ),
          new RoundedButton(
            text: "HTS Pre-Testing",
          ),
          new RoundedButton(text: "Hts Result", selected: true,
          ),
        ],
      ),
    );
  }


  Widget getNextTestButton(){
    try{
      if(final_result ==''|| final_result == 'Pending'){
        return new Text("Proceed to "+ test_name,  style: TextStyle(color: Colors.white),);
      } else{
        return new Text("Proceed to Post Test",  style: TextStyle(color: Colors.white),);

      }

    }catch(e){
      print('excption caught ************* $e');
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
      itemCount: _labinvestList.length,
    );
  }

  Future<void> getTestKIt(labInvestId) async {
    String testkitId;
    try {
      testkitId = await htsChannel.invokeMethod('getTestKit',labInvestId);
      setState(() {
        testkit = testkitId;
      });
    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }
  Future<void> getFinalResult(labInvestId) async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getFinalResult',labInvestId);
      setState(() {
        if(response == null){
          final_result = 'Pending';
        } else{

          final_result = response;

        }
      });

    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }
  Future<void> getStartTime(labInvestId) async {
    String starttime;
    try {
      starttime = await htsChannel.invokeMethod('getStartTime',labInvestId);
      setState(() {
        startTime = starttime;
      });
    } catch (e) {
      print('--------------something went wrong  $e');
    }

  }

}








