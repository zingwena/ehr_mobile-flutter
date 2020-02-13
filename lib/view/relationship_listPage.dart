import 'dart:convert';

import 'package:ehr_mobile/model/relation_view_dto.dart';
import 'package:ehr_mobile/model/relationship.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/relationship_searchpage.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/search_patient_index.dart';
import 'package:flutter/material.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/hiv_screening.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

import '../sidebar.dart';
import 'art_reg.dart';


class RelationshipListPage extends StatefulWidget {

  final HtsRegistration htsRegistration;
  final String htsId ;
  final String personId;
  final String visitId;
  final Person person;
  RelationshipListPage(this.person, this.visitId, this.htsId, this.htsRegistration, this.personId);
  @override
  PelationshipListState createState() {
    return new PelationshipListState();
  }
}

class PelationshipListState extends State<RelationshipListPage>
    with TickerProviderStateMixin {

  var selectedDate;
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  static const patient_channel = MethodChannel('ehr_mobile.channel/patient');
  String person_string;
  Person __person;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  List _religions= List();
  List<Person>_religionList = List();
  List<Person> _religionListDropdown= List();
  List<RelationshipViewDto> _entryPointList = List();

  String _entryPoint;


  @override
  void initState() {
    getRelationContactList(widget.personId);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
      });
  }
  Future<void>getRelationContactList(String personId)async{
    var response ;
    var person_string;
    try{
      response = await patient_channel.invokeMethod('getRelationshipList', personId);
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = RelationshipViewDto.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        }
        );

        print('TTTTTTTTTTTTTTTTTTTTTTTTT  list of people added'+ _entryPointList.toString());
      });

    }catch(e){

    }
  }

  Future<void>getPersonById(String personId) async{
    String person_string;
    try{
      person_string = await patient_channel.invokeMethod('getPersonById', personId);
      setState(() {
        __person = Person.fromJson(jsonDecode(person_string));
        
      });
      
    }catch(e){
      
    }
  }

  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId),
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
            title: new Text("Impilo Mobile",   style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 25.0, ),

            ),
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
                            icon: Icon(Icons.exit_to_app), color: Colors.white,
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
                    child: Text("Relationship List", style: TextStyle(
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
                  //_buildButtonsRow(),
                  Expanded(child: WillPopScope(
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
                                                              padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 20.0),
                                                              child: RaisedButton(
                                                                // onPressed: () {},
                                                                color: Colors.blue,
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(left: 15, right: 15, top: 1, bottom: 1),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Icon(Icons.search, color: Colors.white, ),
                                                                      Text('Look Up Patient', style: TextStyle(color: Colors.white),),
                                                                    ],
                                                                  ),
                                                                ),
                                                                onPressed: () => Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => RelationshipSearch(widget.person, widget.visitId, widget.personId, widget.htsRegistration, widget.htsId)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Container(
                                                        padding: const EdgeInsets.symmetric(
                                                            vertical: 16.0, horizontal: 30.0),
                                                        child: GestureDetector(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.max,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[

                                                              Divider(
                                                                height: 10.0,
                                                                color: Colors.blue.shade500,
                                                              ),// three line description
                                                              getContactList(),

                                                              Divider(
                                                                height: 10.0,
                                                                color: Colors.blue.shade500,
                                                              ),
                                                              Container(
                                                                height: 2.0,
                                                                color: Colors.blue,
                                                              ),


                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              //Expanded(child: Container()),
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

  Widget getContactList(){
    if(_entryPointList.length > 0){
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
        child: DataTable(
            columns: [
              DataColumn(label: Text("First Name")),
              DataColumn(label: Text("Last Name")),
              DataColumn(label: Text("Relationship")),
              DataColumn(label: Text("")),

            ],
            rows:_entryPointList.map((relationship)=>
                DataRow(
                    cells: [
                      DataCell(Text(relationship.firstName)),
                      DataCell(Text(relationship.lastName)),
                      DataCell(Text(relationship.relation)),
                      DataCell(    Padding(
                          padding: const EdgeInsets.only(right: 0),
                          child: RaisedButton(
                            onPressed: () async {
                              getPersonById(relationship.personId);
                               Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Overview(__person)));

                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, top: 1, bottom: 1),
                              child: Text('View',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                      ),
                    ])

            ).toList()

        ),
      );
    }else{
      return new Text("No Relations Added");
    }
  }


}
