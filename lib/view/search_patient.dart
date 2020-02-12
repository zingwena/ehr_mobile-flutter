import 'dart:convert';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/sync/data_sync.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'add_patient.dart';
import 'patient_overview.dart';

class SearchPatient extends StatefulWidget {
  @override
  _SearchPatientState createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient> {
  static const platform = MethodChannel('ehr_mobile.channel/patient');
  static const platformDataSync=MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataSyncChannel');
  String searchItem;
  final _searchFormKey = GlobalKey<FormState>();
  List<Person> _patientList;
  String facility_name;

  String token='';
  String url='';
  var alertStyle = AlertStyle(
    overlayColor: Colors.blue[400],
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    descStyle: TextStyle(fontWeight: FontWeight.bold),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
      side: BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: TextStyle(
      color: Colors.blue,
    ),
  );

  @override
  initState(){
    getSiteName();
    retrieveString(AUTH_TOKEN).then((value){
      token=value;
    });
    retrieveString(SERVER_IP).then((value){
      url=value;
    });
    super.initState();
  }

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

  Future<void> getSiteName() async {
   String response;
    try {
       response = await retrieveString(FACILITY_NAME);
       setState(() {
         facility_name = response;
       });
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  syncPatients() async {
//     var result = await platformDataSync.invokeMethod('syncPatients',[token,'$url/api/']);
//     print(result);
    await syncPatient(token,'$url/api');
//    setState(() {
//      isLoading=false;
//    });
    Alert(
      context: context,
      style: alertStyle,
      title: 'Sync Successfull',
      type: AlertType.success,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.blue,
          radius: BorderRadius.circular(10.0),
        ),
      ],
    ).show();
  }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }
  bool isLoading=false;

  String uploadingInfo='';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        facility_name!= null?Text(
                          facility_name,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 30),
                        ):Text(
                          "Impilo Mobile",
                          style:  TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 30),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        //syncWidget,
                        isLoading ?
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          semanticsLabel: 'Loading ...',
                        ):
                        RoundedButton(
                          onTap: (){
//                            setState(() {
//                              isLoading=true;
//                            });
                            Alert(
                              context: context,
                              style: alertStyle,
                              title: 'Sync with EHR?',
                              type: AlertType.info,
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: Colors.red,
                                  radius: BorderRadius.circular(10.0),
                                ),
                                DialogButton(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: (){
                                    Navigator.pop(context);
//                                    setState(() {
//                                      isLoading=true;
//                                    });
                                    syncPatients();
                                  },
                                  color: Colors.blue,
                                  radius: BorderRadius.circular(10.0),
                                ),
                              ],
                            ).show();
                            //syncPatients();
                          },
                          text: 'Sync',
                          //selected: true,
                        ),

                        Container(
                            padding: EdgeInsets.all(3.0),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: IconButton(
                                      icon: Icon(Icons.exit_to_app), iconSize:32, color: Colors.white,
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
                  ),



                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Text(
                      "Search For Patient",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.80),
                          fontWeight: FontWeight.w400),
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
                            elevation: 0,
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
                  SizedBox(height: 0),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 5,
          ),

          _patientList == null
              ? SizedBox()
              : _patientList != null && _patientList.isNotEmpty
              ? Expanded(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: _patientList.map((patient) {
                return ListTile(
                  leading: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: IconButton(
                      // For this situation your icon name should be humanFemale
                      icon: new Icon(patient.sex == "MALE" ? MdiIcons.humanMale : MdiIcons.humanFemale,
                          color: Colors.blue, size: 35),
                      onPressed: () {},
                    ),
                  ),
                  title: Text(
                    patient.firstName + " " + patient.lastName,
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
                          'ID Number : ' + nullHandler(patient.nationalId),
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
                          'DOB : ' + nullHandler(DateFormat("yyyy/MM/dd").format(patient.birthDate)),
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
                            builder: (context) => Overview(patient)));
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

          Center (
            child: _patientList != null
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
                MaterialPageRoute(builder: (context) => AddPatient()),
              ),
            )
                : SizedBox(height: 5,),
          ),

          SizedBox(
            height: 15,
          ),

        ],
      ),

    );
  }
}
