import 'package:ehr_mobile/landing_screen.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/cbsquestion.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return   Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(accountName: new Text("admin"), accountEmail: new Text("admin@gmail.com"), currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage('images/mhc.png'))),
          new ListTile(leading: new Icon(Icons.person, color: Colors.blue), title: new Text("Home "), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchPatient()),
          )),
          new ListTile(leading: new Icon(Icons.person, color: Colors.blue), title: new Text("Patient Overview "), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Overview(widget.person)),
          )),
          new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Vitals",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ReceptionVitals(widget.patientId, widget.visitId, widget.person, widget.htsId)),
          )),
          new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("HTS",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () {
            if(widget.htsRegistration == null ){
              print('bbbbbbbbbbbbbb htsreg null in side bar  ');
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>  Registration(widget.visitId, widget.patientId, widget.person)
              ));
            } else {
              print('bbbbbbbbbbbbbb htsreg  not null in side bar ');

              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=> HtsRegOverview(widget.htsRegistration, widget.patientId, widget.htsId, widget.visitId, widget.person)
              ));
            }
          }),
          new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("ART",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ArtReg(widget.patientId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)),
          )),
          new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("Sexual History",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CbsQuestions(widget.patientId, widget.htsId, widget.htsRegistration, widget.visitId, widget.person)),
          )),
          new ListTile(leading: new Icon(Icons.home, color: Colors.blue), title: new Text("Logout",  style: new TextStyle(
              color: Colors.grey.shade700, fontWeight: FontWeight.bold)), onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                LandingScreen()),
          )),


        ],
      ),
    );

  }
}