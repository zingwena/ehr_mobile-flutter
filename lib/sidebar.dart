import 'dart:convert';
import 'package:ehr_mobile/landing_screen.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/artRegistration.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/artreg_overview.dart';
import 'package:ehr_mobile/view/hiv_services_index_contact_page.dart';
import 'package:ehr_mobile/view/hts_screening.dart';
import 'package:ehr_mobile/view/htsscreeningoverview.dart';
import 'package:ehr_mobile/view/sexualhistoryform.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/htsscreening.dart';
import 'model/person.dart';

class Sidebar extends StatefulWidget{
  final Person person;
  final HtsRegistration htsRegistration;
  final String patientId;
  final String visitId;
  final String htsId;

  Sidebar(this.person, this.patientId, this.visitId, this.htsRegistration, this.htsId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return sidebarstate();
  }
}

class sidebarstate extends State<Sidebar>{

  ArtRegistration artReg;
  HtsScreening htsScreening;
  String indextestid;
  String INDEXTEST;
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  @override
  void initState() {

    getArtRecord(widget.patientId);
    getHtsScreeningRecord(widget.patientId);
    getIndexTestByPersonId(widget.patientId);

  }

  Future<void> getArtRecord(String patientId) async {
    var  art;
    try {
      art = await htsChannel.invokeMethod('getArtRecord', patientId);
      setState(() {
        artReg = ArtRegistration.fromJson(jsonDecode(art));
        print("HERE IS THE ART REGISTRATION AFTER ASSIGNMENT >>>>>>>>>>>>>" + artReg.toString());

      });

      print('ART IN THE FLUTTER THE RETURNED ONE '+ artReg.toString());
    } catch (e) {
      print("channel failure: '$e'");
    }

  }

  Future<void> getHtsScreeningRecord(String patientId) async {
    var hts_screening;
    print("get screening method called here");
    try {
      hts_screening = await htsChannel.invokeMethod('getHtsScreening', patientId);
      setState(() {
        htsScreening = HtsScreening.fromJson(jsonDecode(hts_screening));
      });
    } catch (e) {
      print("channel failure at hts screening: '$e'");
    }
  }

  Future<void>saveIndexTest(IndexTest indexTest)async{
    var response ;
    print('GGGGGGGGGGGGGGGGGGGGGGGGG HERE IS THE INDEX '+ indexTest.toString());
    print('GGGGGGGGGGGGGGGGGGGGGGGGG HERE IS THE ID FOR PERSON WATIKUDEALER NAYE INDEX TEST'+ indexTest.personId);

    try{
      response = await htsChannel.invokeMethod('saveIndexTest', jsonEncode(indexTest));
      print('LLLLLLLLLLLLLLLLLLLLLLL hre is the indextest id'+ response );
      setState(() {
        indextestid = response;
        print("JJJJJJJJJJJJJJJJJJJJJ INDEX TEST ID IN FLUTTER RETURNED" + indextestid);

      });

    }catch(e){
      print("exception thrown in save index test method: '$e'");


    }

  }
  Future<void>  getIndexTestByPersonId(String personId)async{
    String response ;
    try{

      response = await htsChannel.invokeMethod('getIndexTestByPersonId', personId);
      setState(() {
        indextestid = response;
      });

    }catch(e){
      print("exception thrown in getIndex test method: '$e'");



    }

  }

  @override
  Widget build(BuildContext context) {
    return   Drawer(
      child: ListView(
        children: <Widget>[

          new  Padding(
            padding: const EdgeInsets.fromLTRB(7.0, 10.0, 0.0, 0.0),
            child:Image(
              image: AssetImage('images/mhc.png'),
              width: 120,
              height: 120,
            ), ),

          Padding(
            padding: const EdgeInsets.fromLTRB(75.0, 12.0, 0.0, 10.0),
            child: Text(
              "Impilo Mobile",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(75.0, 0.0, 0.0, 20.0),
            child: Text(
              "Logged In as admin",
              style: TextStyle(color: Colors.black45, fontSize: 16.0),
            ),
          ),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
          new ListTile(leading: new Icon(Icons.home, color: Colors.blue), title: new Text("Home "), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchPatient()),
          )),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
          new ListTile(leading: new Icon(Icons.settings_overscan, color: Colors.blue), title: new Text("Patient Overview "), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SummaryOverview(widget.person, widget.visitId, widget.htsRegistration, widget.htsId)),

          )),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
          new ListTile(leading: new Icon(Icons.add_box, color: Colors.blue), title: new Text("Vitals",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ReceptionVitals(widget.patientId, widget.visitId, widget.person, widget.htsId)),
          )),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
          new ListTile(leading: new Icon(Icons.healing, color: Colors.blue), title: new Text("HTS",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () {
            if(htsScreening == null ){
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>  Hts_Screening(widget.person.id, widget.htsId, widget.htsRegistration, widget.visitId, widget.person)
              ));
            } else {
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=> HtsScreeningOverview(widget.person, htsScreening, widget.htsId, widget.visitId,  widget.person.id)
              ));
            }
          }),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
          new ListTile(leading: new Icon(Icons.healing, color: Colors.blue), title: new Text("Index Testing",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () {
            if(indextestid == null){
              print("Index test id is null here ");
              IndexTest indexTest = IndexTest(widget.patientId, DateTime.now());
              saveIndexTest(indexTest);
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=> HIVServicesIndexContactList(widget.person,null, widget.visitId, widget.htsId, null, widget.patientId, indextestid)
              ));
            }else{
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=> HIVServicesIndexContactList(widget.person,null, widget.visitId, widget.htsId, null, widget.patientId, indextestid)
              ));
            }
          }),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
          new ListTile(leading: new Icon(Icons.art_track, color: Colors.blue), title: new Text("ART",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: (){
            if(artReg == null ){
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>  ArtReg(widget.patientId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)
              ));
            } else {

              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=> ArtRegOverview(artReg, widget.patientId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)

              ));
            }
          }),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
          new ListTile(leading: new Icon(Icons.history, color: Colors.blue), title: new Text("Sexual History",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CbsQuestions(widget.patientId, widget.htsId, widget.htsRegistration, widget.visitId, widget.person)),
          )),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
          new ListTile(leading: new Icon(Icons.add_to_home_screen, color: Colors.blue), title: new Text("Logout",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                LandingScreen()),
          )
          ),
          Divider(
            height: 10.0,
            color: Colors.blue.shade500,
          ),
        ],
      ),
    );
  }


}