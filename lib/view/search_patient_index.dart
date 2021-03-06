import 'dart:convert';


import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/add_patient_index.dart';
import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/view/patientIndexOverview.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/search_patient.dart';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../landing_screen.dart';
import 'add_patient.dart';
import 'list_patients.dart';
import 'patient_overview.dart';
import 'reception_vitals.dart';

class SearchPatientIndex extends StatefulWidget {
  String indexTestId;
  Person person_patient;
  String visitId;
  String htsId;
  String person;


  HtsRegistration htsRegistration;
  String personId;
  SearchPatientIndex(this.person_patient,this.indexTestId, this.visitId, this.personId);
  _SearchPatientState createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatientIndex> {
  static const platform = MethodChannel('ehr_mobile.channel/patient');

  String searchItem;
  String facility_name;
  final _searchFormKey = GlobalKey<FormState>();
  List<Person> _patientList;

  Future<void> searchPatient(String searchItem) async {
    List<dynamic> list;

    try {
      list =
          jsonDecode(await platform.invokeMethod('searchPerson', searchItem));
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {
      _patientList = Person.fromJsonDecodedMap(list);
    });

    print("=====================searched$_patientList");
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

  String nullHandler(String value) {
    return value == null ? "" : value;
  }


  @override
  void initState() {
    getFacilityName();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

     //drawer: Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId),
      backgroundColor: Colors.white,

      body: Column(

        children: <Widget>[

          Stack(
            children: <Widget>[
              Container(
                height: 180.0,
                width: double.infinity,
                color: Colors.blue,
              ),

              AppBar(
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
              Positioned(
                  bottom: 150,
                  left: -40,
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: Colors.blueAccent[100].withOpacity(0.1)),
                  )),
              Positioned(
                  top: -120,
                  left: 100,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.blue[100].withOpacity(0.1)),
                  )),
              Positioned(
                  top: -50,
                  left: 0,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue[100].withOpacity(0.1)),
                  )),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        color: Colors.blue[100].withOpacity(0.1)),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 72.0,
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Center(

                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text("Search Index Contact", style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                      ),


                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Container(

                      width: MediaQuery.of(context).size.width,

                      child: Form(
                        key: _searchFormKey,
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Material(
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(5.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,

                                suffixIcon: IconButton(
                                    icon: Icon(Icons.search,
                                        color: Colors.blue),
                                    onPressed: () async {
                                      if (_searchFormKey.currentState.validate()) {
                                        _searchFormKey.currentState.save();
                                        await searchPatient(searchItem);
                                      }
                                    }),

                                contentPadding: EdgeInsets.all(15.0),
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              onSaved: (value) {
                                setState(() {
                                  searchItem = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.0),
                ],
              ),
            ],
          ),
          /*   SizedBox(
            height: 15.0,
          ), */



          _patientList == null
              ? SizedBox()
              : _patientList != null && _patientList.isNotEmpty
              ? Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: _patientList.map((patient_contact) {
                return ListTile(
                  leading: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: IconButton(
                      // For this situation your icon name should be humanFemale
                      icon: new Icon(patient_contact.sex == "MALE" ? MdiIcons.humanMale : MdiIcons.humanFemale,
                          color: Colors.blue, size: 35),
                      onPressed: () {},
                    ),
                  ),
                  title: Text(
                    patient_contact.firstName + " " + patient_contact.lastName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  subtitle: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'ID Number : ' + nullHandler(patient_contact.nationalId),
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'DOB : ' + nullHandler(DateFormat("yyyy/MM/dd").format(patient_contact.birthDate)),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                    child: Icon(
                      Icons.chevron_right,
                      size: 36,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientIndexOverview(widget.person_patient, patient_contact, widget.indexTestId, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId)));
                  },
                );
              }).toList(),
            ),
          )

              : Center (
            child: Text("No Patients Found"),
          ),

          SizedBox(
            height: 5,
          ),

          _patientList != null
              ? OutlineButton(

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Add Patient",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w500),
            ),
            borderSide: BorderSide(
              color: Colors.blue, //Color of the border
              style: BorderStyle.solid, //Style of the border
              width: 3.0, //width of the border
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPatientIndex(widget.person_patient,widget.indexTestId, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId)),
            ),
          )
              :   SizedBox( ),

          SizedBox(
            height: 15,
          ),

        ],


      ),

    );
  }

}
