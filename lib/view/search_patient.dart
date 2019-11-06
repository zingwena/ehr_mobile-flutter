import 'dart:convert';


import 'package:ehr_mobile/datasync/stored_preferences.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'add_patient.dart';
import 'patient_overview.dart';
import 'package:http/http.dart' as http;

class SearchPatient extends StatefulWidget {
  _SearchPatientState createState() => _SearchPatientState();
}

class _SearchPatientState extends State<SearchPatient> {
  static const platform = MethodChannel('ehr_mobile.channel/patient');
  static const platformDataSync=MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataSyncChannel');
  String searchItem;
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

  Future<void>syncPatients(String tokenString) async {
    String url=await retrieveString(SERVER_IP);
    await platformDataSync.invokeMethod('syncPatients',[tokenString,'$url/api/']).then((value){
      print("sync method called----->$value");
    });
  }

  String nullHandler(String value) {
    return value == null ? "" : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    /*  appBar: AppBar(
        title: Text('Search Patient'),
      ),*/
      backgroundColor: Colors.white,

      body: Column(

        children: <Widget>[

          Stack(
            children: <Widget>[
              Container(
                height: 200.0,
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
                    height: 70.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Impilo Mobile",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 30),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        RoundedButton(
                          onTap: (){
                              retrieveString(AUTH_TOKEN).then((value){
                                syncPatients(value).then((value){
                                print('Sync Done');
                                }).catchError((error){
                                  print('Sync Done');
                                });
                              });
                          },
                          text: 'Sync',
                          //selected: true,
                        ),

//                        RaisedButton(
//                          child: Text(
//                            "Sync",
//                            style: TextStyle(
//                                color: Colors.blue,
//                                fontWeight: FontWeight.w500,
//                                fontSize: 16),
//                          ),
//                          onPressed: () {
//                            authenticate().then((value){
//                              syncPatients(value);
//                            });
//                          },
//                          elevation: 1.0,
//                          color: Colors.white,
//                        ),
//                        new InkWell(
//                          onTap: (){
//                              retrieveString(AUTH_TOKEN).then((value){
//                                syncPatients(value);
//                              });
//                          },
//                          child: new Container(
//                            height: 36.0,
//                            decoration: new BoxDecoration(
//                              color: Colors.white,
//                              border: new Border.all(color: Colors.white, width: 1.0),
//                              borderRadius: new BorderRadius.circular(10.0),
//                            ),
//                            child: new Center(
//                              child: new Text(
//                                "Sync",
//                                style: new TextStyle(color: Colors.blue),
//                              ),
//                            ),
//                          ),
//                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                  SizedBox(
                    height: 15,
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
                            elevation: 5.0,
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
                  SizedBox(height: 15.0),
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
                      fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
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
                            fontWeight: FontWeight.bold,
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
            height: 15,
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
              MaterialPageRoute(builder: (context) => AddPatient()),
            ),
          )
              :   SizedBox( ),

          SizedBox(
            height: 125,
          ),

        ],


      ),

    );
  }

  Future<String> authenticate() async {
    var body = json.encode({"username": "admin", "password": "admin"});
    final response = await http.post("http://192.168.43.66:8080/api/authenticate",
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json",
        },
        body: body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return json.decode(response.body)['id_token'];

    } else {
      print(response.body);
      throw Exception('Failed to authenticate');
    }
  }


}
