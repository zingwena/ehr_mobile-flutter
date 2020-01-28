import 'dart:convert';
import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTest.dart';
import 'package:ehr_mobile/model/laboratoryInvestigationTestDto.dart';
import 'package:ehr_mobile/model/laboratory_investigation.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
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
import 'package:ehr_mobile/view/hiv_services_index_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';
import 'sexualhistoryform.dart';
import 'rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
class Recency_Result extends StatefulWidget {
  String visitId;
  String patientId;
  String labInvetsTestId;
  String labInvestId;
  Person person;
  String htsId;
  String indexTestId;
  LaboratoryInvestigationTestDto laboratoryInvestigation;

  Recency_Result(this.patientId, this.labInvetsTestId, this.visitId, this.labInvestId, this.person, this.htsId, this.laboratoryInvestigation, this.indexTestId);

  //Hts_Result (this.visitId, this.patientId);

  @override
  State createState() {
    return _Recency_Result ();
  }
}

class _Recency_Result  extends State<Recency_Result > {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  String _visitId;
  String patientId;
  String indextestid;
  String INDEXTEST ;
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
    //getEndTime(widget.labInvetsTestId);


    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    super.initState();
  }

  Future<void> getFacilities() async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getLabInvestigations', widget.visitId);
      setState(() {
        {
          _entryPoint = response;
          entryPoints = jsonDecode(_entryPoint);
          _dropDownListEntryPoints = LaboratoryInvestigationTest.mapFromJson(entryPoints);
          _dropDownListEntryPoints.forEach((e) {
            _entryPointList.add(e);
          });
        }
      });
      print("HERE IS THE LIST OF LAB INVESTIGATIONS"+ _entryPointList.toString());

    } catch (e) {
      print('--------------------Something went wrong  $e');
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
/*  Future<void> getResultName() async {
    String response;
    try {
      response = await htsChannel.invokeMethod('getLabInvestigations', widget.visitId);
      setState(() {
        {
          _entryPoint = response;
          entryPoints = jsonDecode(_entryPoint);
          _dropDownListEntryPoints = LaboratoryInvestigationTest.mapFromJson(entryPoints);
          _dropDownListEntryPoints.forEach((e) {
            _entryPointList.add(e);
          });
        }
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }*/



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
      drawer:  Sidebar(widget.person, widget.patientId, widget.visitId, htsRegistration, widget.htsId),
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
                    child: Text("Recency Test Results", style: TextStyle(
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
                              child: Text("Age - 25", style: TextStyle(
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
                                                    height: 20.0,
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                                                    child: DataTable(
                                                        columns: [
                                                          DataColumn(label: Text("TestKit")),
                                                          DataColumn(label: Text("Result")),
                                                        ],
                                                        rows: [
                                                          DataRow(cells: [
                                                            DataCell(Text(widget.laboratoryInvestigation.testkit.name)),
                                                            DataCell(Text(widget.laboratoryInvestigation.result.name))
                                                          ])
                                                        ]

                                                    ),
                                                  ),

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
                                                                (widget.laboratoryInvestigation.result.name),
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
                            child: Text(
                            "Proceed to Index Testing",
                            style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                            IndexTest indexTest = IndexTest(widget.patientId, DateTime.now());
                            saveIndexTest(indexTest);
                            Navigator.push(context,MaterialPageRoute(
                            builder: (context)=> HIVServicesIndexContactList(widget.person,null, widget.visitId, widget.htsId, null, widget.patientId, INDEXTEST)
                            ));
                            },
                            ),
                            ),                ],
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
            text: "Post Test",
          ),
          new RoundedButton(
            text: "Recency Testing",
            /*    onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPretest(widget.patientId, hts_id)),
            ),*/
          ),
          new RoundedButton(text: "Recency Result", selected: true,
          ),
        ],
      ),
    );
  }
  Future<void>saveIndexTest(IndexTest indexTest)async{
    var response ;
    print('GGGGGGGGGGGGGGGGGGGGGGGGG HERE IS THE INDEX '+ indexTest.toString());
    print('GGGGGGGGGGGGGGGGGGGGGGGGG HERE IS THE ID FOR PERSON WATIKUDEALER NAYE INDEX TEST'+ indexTest.personId);

    try{
      response = await htsChannel.invokeMethod('saveIndexTest', jsonEncode(indexTest));
      print('LLLLLLLLLLLLLLLLLLLLLLL hre is the indextest id'+ response );
      setState(() {
        INDEXTEST = response;
        print("JJJJJJJJJJJJJJJJJJJJJ INDEX TEST ID IN FLUTTER RETURNED" + indextestid);

      });

    }catch(e){

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
      id = await htsChannel.invokeMethod('htsRegistration', jsonEncode(htsRegistration));
      hts_id = id;

      String patientid = patientId.toString();
      DateTime date = htsRegistration.dateOfHivTest;
      PersonInvestigation personInvestigation = new PersonInvestigation(
          patientid, "36069471-adee-11e7-b30f-3372a2d8551e", date, null);
      await htsChannel.invokeMethod('htsRegistration',jsonEncode(personInvestigation));

      print('---------------------saved file id  $id');
    } catch (e) {
      print('--------------something went wrong  $e');
    }
  }
  Future<void> getTestKIt(labInvestId) async {
    String testkitId;
    try {
      testkitId = await htsChannel.invokeMethod('getTestKit',labInvestId);
      print('TEST KIT HERE '+ testkit);
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
      response = await htsChannel.invokeMethod('getFinalResult',labInvestId);
      print('Final Result here >>>>>>>>>> '+ response);
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
  Future<void> getStartTime(labInvestId) async {
    String starttime;
    try {
      starttime = await htsChannel.invokeMethod('getStartTime',labInvestId);
      print('start time HERE '+ starttime);
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
      endtime = await htsChannel.invokeMethod('getStartTime',labInvestId);
      print('start time HERE '+ endtime);
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








