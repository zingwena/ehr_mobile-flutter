import 'dart:convert';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/htsscreening.dart';
import 'package:ehr_mobile/model/htsscreeningdto.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';

import 'package:ehr_mobile/vitals/visit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import '../landing_screen.dart';
import '../sidebar.dart';
import 'art_reg.dart';
import 'sexualhistoryform.dart';
import 'rounded_button.dart';
import 'home_page.dart';

import 'hts_testscreening.dart';
import 'hts_registration.dart';

import 'reception_vitals.dart';
import 'package:ehr_mobile/model/address.dart';

class HtsScreeningOverview extends StatefulWidget {
  final String htsId ;
  final String personId;
  final String visitId;
  final Person person;
  final HtsScreening htsScreening;

  HtsScreeningOverview(this.person, this.htsScreening, this.htsId, this.visitId, this.personId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HtsScreeningOverview();
  }
}

class _HtsScreeningOverview extends State<HtsScreeningOverview> {
  static const platform = MethodChannel('ehr_mobile.channel/vitals');
  static final MethodChannel patientChannel = MethodChannel(
      'zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');


  Person _patient;
  Visit _visit;
  Map<String, dynamic> details;
  String _maritalStatus,_educationLevel,_occupation,_nationality, _address, _phonenumber;
  HtsRegistration htsRegistration;
  String htsId;
  bool showInput = true;
  bool showInputTabOptions = true;
  String visitId;
  String beenTestedBefore;
  String patientOnArt;
  String everbeenonprep;
  Age age;
  String facility_name;
  @override
  void initState() {
    _patient = widget.person;
    getVisit(_patient.id);
    getHtsRecord(_patient.id);
    getFacilityName();
    getAge(widget.person);
    getHtsId(_patient.id);
    if(widget.htsScreening.testedBefore == true){
      beenTestedBefore = 'YES';
    }else{
      beenTestedBefore = 'NO';
    }
    if(widget.htsScreening.art == true){
      patientOnArt = 'YES';

    }else{
      patientOnArt = 'NO';

    }
    if(widget.htsScreening.beenOnPrep == true){
      everbeenonprep = 'YES';
    }else{
      everbeenonprep = 'NO';
    }
    super.initState();
  }

  Future<void> getVisit(String patientId) async {
    String visit;

    try {
      visit =
      await platform.invokeMethod('visit', patientId);

    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      visitId = visit;
    });


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
        print("THIS IS THE AGE RETRIEVED"+ age.toString());
      });

    }catch(e){
      debugPrint("Exception thrown in get facility name method"+e);

    }
  }

  Future<void> getHtsRecord(String patientId) async {
    var  hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      setState(() {

        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));

      });
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
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

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  Sidebar(widget.person, widget.personId, widget.visitId, htsRegistration, widget.htsId),
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
                              icon: Icon(Icons.home), color: Colors.white,
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchPatient()),),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app), color: Colors.white,
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LandingScreen()),),
                          ),
                        ),])
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
                    child: Text("HTS Screening Overview", style: TextStyle(
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
                              child: Text("Age -"+ age.years.toString()+"years", style: TextStyle(
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
                                        minHeight: viewportConstraints .maxHeight - 48.0,
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
                                                                    text: beenTestedBefore),
                                                                decoration: InputDecoration(
                                                                    icon: Icon(Icons.person, color: Colors.blue),
                                                                    labelText: "Been testes before?",
                                                                    hintText: "Been testes before?"
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
                                                                        patientOnArt)),
                                                                decoration: InputDecoration(
                                                                    icon: new Icon(MdiIcons.humanMaleFemale, color: Colors.blue),
                                                                    labelText: "Are you on Art?",
                                                                    hintText: "Are you on Art?"
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
                                                                        widget.htsScreening.result)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Results when tested',
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
                                                                    text: DateFormat("dd/MM/yyyy").format(widget.htsScreening.dateLastTested)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Date last tested',
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
                                                                        widget.htsScreening.artNumber)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Art Number',
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
                                                                        everbeenonprep)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Have you ever been on Prep',
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
                                                                        widget.htsScreening.viralLoadDone)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Viral load done ?',
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
                                                                    text: widget.htsScreening.cd4Done),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Cd4 count done?',
                                                                  icon: Icon(Icons.smartphone, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          widget.htsScreening.viralLoadDone == 'DONE'?Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: nullHandler(
                                                                        widget.htsScreening.viralLoadDone)),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Viral load',
                                                                  icon: Icon(Icons.flag, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ): SizedBox(height: 0.0,),
                                                          widget.htsScreening.cd4Done == 'DONE'? Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(right: 16.0),
                                                              child: TextField(
                                                                controller: TextEditingController(
                                                                    text: widget.htsScreening.cd4Done),
                                                                decoration: InputDecoration(
                                                                  labelText: 'Cd4 count',
                                                                  icon: Icon(Icons.smartphone, color: Colors.blue),
                                                                ),

                                                              ),
                                                            ),
                                                          ): SizedBox(height: 0.0,)
                                                        ],
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                height: 35.0,
                                              ),

                                             // Expanded(child: Container()),
                                               Container(
                                                        width: double.infinity,
                                                 padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0),
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
                                                              Text('Proceed to HTS Registration', style: TextStyle(color: Colors.white),),
                                                              Spacer(),
                                                              Icon(Icons.navigate_next, color: Colors.white, ),
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            if(htsRegistration == null ){
                                                              print('bbbbbbbbbbbbbb htsreg null ');
                                                              Navigator.push(context,MaterialPageRoute(
                                                                  builder: (context)=>  Registration(visitId, _patient.id, _patient)
                                                              ));
                                                            } else {
                                                              print('bbbbbbbbbbbbbb htsreg  not null ');

                                                              Navigator.push(context,MaterialPageRoute(
                                                                  builder: (context)=> HtsRegOverview(htsRegistration, _patient.id, htsId, visitId, _patient)
                                                              ));
                                                            }
                                                          },
                                                        ),
                                                      ),
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

}






