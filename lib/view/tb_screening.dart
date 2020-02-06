import 'dart:convert';

import 'package:ehr_mobile/model/artdto.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/tbscreening.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/tb_screening_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
//import '../sidebar.dart';
//import 'rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/model/artRegistration.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
//import 'edit_demographics.dart';

class TbScreeningView extends StatefulWidget {
  String personId;
  String visitId;
  Person person;
  HtsRegistration htsRegistration;
  String htsId;
  TbScreeningView(this.person, this.personId, this.visitId, this.htsRegistration, this.htsId);


  @override
  State createState() {
    return _TbScreening();
  }
}

class _TbScreening extends State<TbScreeningView> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  static final MethodChannel addPatient =
  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  static const dataChannel =  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');


  var dateOfTest,dateOfEnrollment, displayDate, dateOfRetest, dateHivConfirmed;
  DateTime enrollment_date, test_date, retest_date, hivConfirmation_date;

  Age age;
  TbScreening tbScreeningobj;
  TbScreening tbscreeningResponse;

  String facility_name;
  List<DropdownMenuItem<String>> _dropDownMenuItemsHivTestUsedIdentified;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReferringListIdentified;
  List<DropdownMenuItem<String>> _dropDownMenuItemsReasonForTestListIdentified;

  List _referringListIdentified = ["EID", "HTS", "PMTCT", "STI", "TB_PROGRAM", "VMMC", "VIAC" ];
  List _hivTestUsedIdentified = ["AB", "PCR" ];
  List _reasonForHivTestIdentified = ["Reason 1", "Reason 2", "Reason 3", "Reason 4" ];

  int _coughing = 0;
  int _fever = 0;
  int _nightSweats = 0;
  int _weightLoss = 0;

  String coughing = "";
  String fever = "";
  String nightSweats = "";
  String weightLoss = "";

  bool coughingOption = false;
  bool feverOption = false;
  bool nightSweatsOption = false;
  bool weightLossOption = false;
  String  _currentReferringProgram, _currentHivTestUsed, _currentReasonForTest ;

  bool selfIdentifiedReferringIsValid=false;
  bool selfIdentifiedHIVTestIsValid=false;
  bool selfIdentifiedReasonForTestIsValid=false;

  @override
  void initState() {

    getAge(widget.person);
    getFacilityName();
    getTbScreening(widget.personId);

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

  Future<void>getTbScreening(String personId)async{
    String response;
    try{
      response = await artChannel.invokeMethod('getTbScreening', personId);
      setState(() {
        tbScreeningobj = TbScreening.fromJson(jsonDecode(response));
        print("THIS IS THE TB SCREENING  RETRIEVED"+ tbScreeningobj.toString());
      });

    }catch(e){
      debugPrint("Exception thrown in get Tb Screening name method"+e);

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




  void _handleCoughingChange(int value) {
    setState(() {
      _coughing = value;

      switch (_coughing) {
        case 1:
          coughingOption = true;
          break;
        case 2:
          coughingOption = false ;
          break;
      }
    });
  }

  void _handleFeverChange(int value) {
    setState(() {
      _fever = value;

      switch (_fever) {
        case 1:
          feverOption = true;
          break;
        case 2:
          feverOption = false;
          break;
      }
    });
  }

  void _handleNightSweatsChange(int value) {
    setState(() {
      _nightSweats = value;

      switch (_nightSweats) {
        case 1:
          nightSweatsOption = true;
          break;
        case 2:
          nightSweatsOption= false;
          break;
      }
    });
  }

  void _handleWeightLossChange(int value) {
    setState(() {
      _weightLoss = value;

      switch (_weightLoss) {
        case 1:
          weightLossOption = true;
          break;
        case 2:
          weightLossOption = false;
          break;
      }
    });
  }

  String _selfReferringProgramError="Select Referring Program";
  String _selfHivTestUsedError="Select HIV Test Used";
  String _selfReasonForHivTestError="Select HIV Test Used";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId),

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
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("TB Screening", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
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
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                    EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0 ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(8.0),
                                                              child: Text('Coughing : Productive or non productive 1 week or more'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('Yes'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            _coughing,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleCoughingChange),
                                                        Text('No'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _coughing,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleCoughingChange),

                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 10.0,
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                    EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0 ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(8.0),
                                                              child: Text('Fever : 1 week'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('Yes'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            _fever,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleFeverChange),
                                                        Text('No'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _fever,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleFeverChange),

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),

                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                    EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0 ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(8.0),
                                                              child: Text('Night Sweats : Either consecutive or intermittent'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('Yes'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            _nightSweats,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleNightSweatsChange),
                                                        Text('No'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _nightSweats,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleNightSweatsChange),

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),


                                                  Container(
                                                    width: double.infinity,
                                                    padding:
                                                    EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0 ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(8.0),
                                                              child: Text('Weight Loss : Adult of >/ 10% in 3months or since lastvisit child ( < 5 years ) of >/ 5% in 3 months or since last visit'),
                                                            ),
                                                            width: 250,
                                                          ),
                                                        ),
                                                        Text('Yes'),
                                                        Radio(
                                                            value: 1,
                                                            groupValue:
                                                            _weightLoss,
                                                            activeColor:
                                                            Colors.blue,
                                                            onChanged:
                                                            _handleWeightLossChange),
                                                        Text('No'),
                                                        Radio(
                                                            value: 2,
                                                            groupValue: _weightLoss,
                                                            activeColor: Colors.blue,
                                                            onChanged: _handleWeightLossChange),

                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 35.0,
                                                  ),


                                                  Container(
                                                    width: double.infinity,
                                                    padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0 ),
                                                    child: RaisedButton(
                                                      elevation: 4.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(5.0)),
                                                      color: Colors.blue,
                                                      padding: const EdgeInsets.all(20.0),
                                                      child: Text(
                                                        "Save",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      onPressed: () async {
                                                        tbScreeningobj.weightLoss = weightLossOption;
                                                        tbScreeningobj.nightSweats = nightSweatsOption;
                                                        tbScreeningobj.fever = feverOption;
                                                        tbScreeningobj.coughing = coughingOption;

                                                        await saveTbScreening(tbScreeningobj);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) =>   TbScreeningOverview(tbscreeningResponse, widget.personId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)
                                                          ), );

                                                        }
                                                    ),
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



  Future<void> saveTbScreening(TbScreening tbscreening) async {
    var tb_screening_response;
    try {
      print('pppppppppppppppppppppppppppppppppppp tb screening to be saved '+ tb_screening_response.toString());

      tb_screening_response = await artChannel.invokeMethod('saveTbScreening', jsonEncode(tbscreening));
      print('pppppppppppppppppppppppppppppppppppp tb screening response response'+ tb_screening_response);
      setState(() {
        tbscreeningResponse = TbScreening.fromJson(jsonDecode(tb_screening_response));
        print('FFFFFFFFFFFFFFFFFFFFFFF'+ tbscreeningResponse.toString());
      });

    } catch (e) {
      print('--------------something went wrong in art visit save method  $e');
    }

  }
}
