import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/htsscreening.dart';
import 'package:ehr_mobile/model/patient_queue.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/htsscreeningoverview.dart';
import 'package:ehr_mobile/view/relationship_listPage.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/hts_screening.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/view/visit_initiation.dart';
import 'package:ehr_mobile/vitals/visit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'art_reg.dart';
import 'sexualhistoryform.dart';
import 'rounded_button.dart';
import 'home_page.dart';
import 'hts_testscreening.dart';
import 'hts_registration.dart';
import 'reception_vitals.dart';
import 'package:ehr_mobile/model/address.dart';

class Overview extends StatefulWidget {
  final Person patient;
  Overview(this.patient);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OverviewState();
  }
}
class OverviewState extends State<Overview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static final MethodChannel patientChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const visitChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/visitChannel');
  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _maritalStatus,_educationLevel,_occupation,_nationality, _address, _phonenumber;
  HtsRegistration htsRegistration;
  HtsScreening htsScreening;
  String htsId;
  bool showInput = true;
  bool showInputTabOptions = true;
  String visitId;
  PatientQueue patientQueue;
  String facility_name;
  @override
  void initState() {
    _patient = widget.patient;
    getVisit(_patient.id);
    getHtsRecord(_patient.id);
    getHtsScreeningRecord(_patient.id);
    getDetails(_patient.maritalStatusId,_patient.educationLevelId,_patient.occupationId,_patient.nationalityId, _patient.id);
    getQueueName(widget.patient.id);
    getFacilityName();
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

  Future<void> getVisit(String patientId) async {
    String visit;

    try {
      visit =
          await platform.invokeMethod('visit', patientId);
      setState(() {
        visitId = visit;
      });


    } catch (e) {
      print("channel failure: '$e'");
    }


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
  Future<void> getHtsScreeningRecord(String patientId) async {
    var  hts_screening;
    try {
      hts_screening = await htsChannel.invokeMethod('getHtsScreening', patientId);
      setState(() {
        htsScreening = HtsScreening.fromJson(jsonDecode(hts_screening));
      });

    } catch (e) {
      print("channel failure: '$e'");
    }
  }
  Future<void> getHtsId(String patientId) async {
    var hts;

    try {
      hts = await htsChannel.invokeMethod('getHtsId', patientId);
      setState(() {
        htsId = hts;
      });
    } catch (e) {
      print("channel failure: '$e'");
    }
     }

     Future<void>getQueueName(String patientId) async {
     String queue_response;
     try{
       queue_response = await visitChannel.invokeMethod('getPatientQueue', patientId);
       setState(() {
         patientQueue = PatientQueue.fromJson(jsonDecode(queue_response));
         debugPrint("Patient queue after assignment " + patientQueue.toString());

       });
     }catch(e){
       debugPrint("Exception was thrown in the get queueName method $e");

     }
     }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Sidebar(_patient, widget.patient.id, visitId, htsRegistration, htsId),
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
            title: new Text(
              facility_name!=null?facility_name: 'Impilo Mobile',   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
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
                    child: Text("Patient OverView", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                  patientQueue != null ?Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(patientQueue.queue.name, style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ):  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                  patientQueue!=null?_buildButtonsRow():SizedBox(height: 0.0,
                  ),
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
                                                                    text: _patient.firstName +" "+
                                                                        _patient.lastName),
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons.person, color: Colors.blue),
                                                                    labelText: "Full Name",
                                                                    hintText: "Full Name"
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
                                                                        _patient.sex)),
                                                                decoration: InputDecoration(
                                                                    icon: new Icon(MdiIcons.humanMaleFemale, color: Colors.blue),
                                                                    labelText: "Sex",
                                                                    hintText: "Sex"
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
                                                                        _patient.nationalId)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'National ID',
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
                                                                    text: DateFormat("dd/MM/yyyy").format(_patient.birthDate)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Date Of Birth',
                                                                  icon: Icon(Icons.date_range, color: Colors.blue),
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
                                                                        _maritalStatus)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Marital Status',
                                                                  icon: new Icon(MdiIcons.humanMaleFemale, color: Colors.blue),
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
                                                                        _educationLevel)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Education',
                                                                  icon: Icon(Icons.book, color: Colors.blue),
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
                                                                        _nationality)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Nationality',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),

                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: _phonenumber),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Phone Number',
                                                                  icon: Icon(Icons.smartphone, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 64.0, 8.0),
                                                        child: TextFormField(
                                                          controller: TextEditingController(
                                                              text: _address),
                                                          decoration: InputDecoration(
                                                            labelText: 'Address',
                                                            icon: Icon(Icons.home, color: Colors.blue),
                                                          ),

                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ),

                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 20.0),
                                                      child: patientQueue == null ?RaisedButton(
                                                       onPressed: () {
                                                         Navigator.push(context,MaterialPageRoute(
                                                             builder: (context)=>  VisitInitiation(widget.patient, false, this.htsId, this.htsRegistration)
                                                         ));
                                                       },

                                                        color: Colors.blue,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 15, right: 15, top: 1, bottom: 1),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Icon(Icons.person_add, color: Colors.white,),
                                                              Spacer(),
                                                              Text('Admit Out Patient', style: TextStyle(color: Colors.white,),),
                                                            ],
                                                          ),
                                                        ),
                                                      ):RaisedButton(
                                                        onPressed: () {
                                                          Navigator.push(context,MaterialPageRoute(
                                                              builder: (context)=>  VisitInitiation(widget.patient, true, this.htsId, this.htsRegistration)
                                                          ));


                                                        },
                                                        color: Colors.blue,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(left: 15, right: 15, top: 1, bottom: 1),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Icon(Icons.person_add, color: Colors.white,),
                                                              Spacer(),
                                                              Text('Change Queue', style: TextStyle(color: Colors.white,),),
                                                            ],
                                                          ),
                                                        ),
                                                      ) ,
                                                    ),
                                                  ),

                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 20.0),
                                                      child: RaisedButton(
                                                         onPressed: () {},
                                                        color: Colors.blue,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(left: 15, right: 15, top: 1, bottom: 1),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Icon(Icons.person_add, color: Colors.white, ),
                                                              Spacer(),
                                                              Text('Admit In Patient', style: TextStyle(color: Colors.white),),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(child: Container()),
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
          new RoundedButton(text: "VITALS", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ReceptionVitals(
                        _patient.id, visitId, _patient,htsId)),
          ),
          ),

          new RoundedButton(text: "HTS", onTap: () {
            if(htsScreening == null ){
              debugPrint("The htsscreening record was null ######");
               Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>  Hts_Screening(widget.patient.id, htsId, htsRegistration, visitId, _patient)
              ));
            } else {
              debugPrint("The htsscreening record wasn't null #######");
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=> HtsScreeningOverview(widget.patient, htsScreening, htsId, visitId,  widget.patient.id)
              ));
            }
          }
          ),

      new RoundedButton(text: "ART", onTap: () =>     Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
        ArtReg(_patient.id, visitId, _patient, htsRegistration, htsId)),
    ),),
          new RoundedButton(text: "RELATIONS", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RelationshipListPage(_patient, visitId, htsId, htsRegistration, _patient.id)
            ),
          ),
          ),


        ],
      ),
    );
  }
Widget _sidemenu(){
    return new Drawer(
      child: ListView(
        children: <Widget>[

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

      setState(() {
        _maritalStatus = maritalStatus;
        _educationLevel = educationLevel;
        _occupation = occupation;
        _nationality = nationality;
        _address = address;
        _phonenumber = patientphonenumber;
      });



    }
    catch (e) {
      print(
          'Something went wrong during getting marital status........cause $e');
    }


  }


}






