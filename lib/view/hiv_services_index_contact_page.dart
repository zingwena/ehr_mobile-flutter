import 'dart:convert';

import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/search_patient_index.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/hiv_screening.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';

/*
import 'package:ehr_mobile/home_screen.dart';
*/
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

import '../sidebar.dart';
import 'art_reg.dart';


class HIVServicesIndexContactList extends StatefulWidget {

  final HtsRegistration htsRegistration;
  final String htsId ;
  final String personId;
  final String visitId;
  final Person person;
  final String indexTestId;
  final Person person_contact;
  HIVServicesIndexContactList(this.person,this.person_contact, this.visitId, this.htsId, this.htsRegistration, this.personId, this.indexTestId);
  @override
  HIVServicesIndexContactListState createState() {
    return new HIVServicesIndexContactListState();
  }
}

class HIVServicesIndexContactListState extends State<HIVServicesIndexContactList>
    with TickerProviderStateMixin {

  var selectedDate;
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =  MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  String person_string;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  List _religions= List();
  List<Person>_religionList = List();
  List<Person> _religionListDropdown= List();
  List<Person> _entryPointList = List();

  String _entryPoint;

  String facility_name;
  Age age;


  @override
  void initState() {
    getIndexContactList(widget.indexTestId);
    getAge(widget.person);
    getFacilityName();
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
  Future<void>getIndexContactList(String indexId)async{
    var response ;
    try{
      response = await htsChannel.invokeMethod('getIndexContactList', indexId);
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = Person.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
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
                    padding: const EdgeInsets.all(8.0),
                    child: Text("HIV Services Index Contact Page", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                  SizedBox(height: 6.0,),
                  Container(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                              child: Text("Age -"+age.years.toString()+"years", style: TextStyle(
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
                          ])),
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
                                                                onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(builder: (context) => SearchPatientIndex(widget.person,widget.indexTestId, widget.visitId, widget.personId)),
                                                                  );

                                                                }
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
                                                            children: <Widget>[                                                             // three line description
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

Widget getContactList(){
  if(_entryPointList.length > 0){
     return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
      child: DataTable(
          columns: [
            DataColumn(label: Text("First Name")),
            DataColumn(label: Text("Last Name")),
            DataColumn(label: Text(""))
          ],
          rows:_entryPointList.map((index_person)=>
              DataRow(
                  cells: [
                    DataCell(Text(index_person.firstName)),
                    DataCell(Text(index_person.lastName)),
                    DataCell(    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Overview(index_person)));

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


                    )])

          ).toList()


      ),
    );
  }else{
     return new Text("No Contacts Added");
  }
}


}
