import 'package:flutter/material.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/hiv_screening.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
/*
import 'package:ehr_mobile/home_screen.dart';
*/
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/register_index_patient.dart';
import 'package:ehr_mobile/view/hiv_testing_index_contact_search.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';


class HIVServicesIndexContactList extends StatefulWidget {

  final HtsRegistration htsRegistration;
  final String htsId ;
  final String personId;
  final String visitId;
  final Person person;

  HIVServicesIndexContactList(this.person, this.visitId, this.htsId, this.htsRegistration, this.personId);
  @override
  HIVServicesIndexContactListState createState() {
    return new HIVServicesIndexContactListState();
  }
}

class HIVServicesIndexContactListState extends State<HIVServicesIndexContactList>
    with TickerProviderStateMixin {

  var selectedDate;


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

  bool showInput = true;
  bool showInputTabOptions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              fontWeight: FontWeight.w300, fontSize: 25.0, ), ),
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
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
                                                                //onPressed: () {},
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
                                                                      Text('Register Patient', style: TextStyle(color: Colors.white,),),
                                                                    ],
                                                                  ),

                                                                ),
                                                                onPressed: () => Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => RegisterIndexPatient()),
                                                                ),
                                                              ),

                                                            ),
                                                          ),

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
                                                                  MaterialPageRoute(builder: (context) => HivTestingIndexContactPage()),
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
                                                            children: <Widget>[                                                             // three line description

                                                              Divider(
                                                                height: 10.0,
                                                                color: Colors.blue.shade500,
                                                              ),
                                                              Container(
                                                                height: 2.0,
                                                                color: Colors.blue,
                                                              ),

                                                              Row(
                                                                mainAxisSize: MainAxisSize.max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Container(
                                                                      padding: EdgeInsets.all(3.0),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Full Name',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black54),
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(top: 3.0),
                                                                            child: Text(
                                                                              'Tom Wilson',
                                                                              style: TextStyle(
                                                                                  fontSize: 15.0,
                                                                                  color: Colors.black87),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )),
                                                                  Container(
                                                                      padding: EdgeInsets.all(3.0),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Relationship',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black54),
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(top: 3.0),
                                                                            child: Text(
                                                                              'Brother',
                                                                              style: TextStyle(
                                                                                  fontSize: 15.0,
                                                                                  color: Colors.black87),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                  Container(
                                                                      padding: EdgeInsets.all(3.0),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Sex',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black54),
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(top: 3.0),
                                                                            child: Text(
                                                                              'Male',
                                                                              style: TextStyle(
                                                                                  fontSize: 15.0,
                                                                                  color: Colors.black87),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                  Container(
                                                                      padding: EdgeInsets.all(3.0),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Age',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black54),
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(top: 3.0),
                                                                            child: Text(
                                                                              '44',
                                                                              style: TextStyle(
                                                                                  fontSize: 15.0,
                                                                                  color: Colors.black87),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )),
                                                                  Container(
                                                                      padding: EdgeInsets.all(3.0),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Adress',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black54),
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(top: 3.0),
                                                                            child: Text(
                                                                              '22 Northway Road Harare',
                                                                              style: TextStyle(
                                                                                  fontSize: 15.0,
                                                                                  color: Colors.black87),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                  ),

                                                                  Container(
                                                                      padding: EdgeInsets.all(3.0),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Phone Number',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black54),
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(top: 3.0),
                                                                            child: Text(
                                                                              '+263 774563473',
                                                                              style: TextStyle(
                                                                                  fontSize: 15.0,
                                                                                  color: Colors.black87),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                  ),

                                                                  Container(
                                                                      padding: EdgeInsets.all(3.0),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Status Disclosed',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black54),
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(top: 3.0),
                                                                            child: Text(
                                                                              'Yes',
                                                                              style: TextStyle(
                                                                                  fontSize: 15.0,
                                                                                  color: Colors.black87),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                  ),

                                                                ],
                                                              ),
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
                                           /*       Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16.0, top: 8.0),
                                              child: FloatingActionButton(
                                                onPressed: () =>
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()),
                                                    ),
                                                child: Icon(
                                                    Icons.home, size: 36.0),
                                              ),
                                            ), */
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

/*  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "VITALS", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ReceptionVitals()),
          ),
          ),
          new RoundedButton(text: "HTS", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HivScreening()),
          ),
          ),
          new RoundedButton(text: "HomePage", onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()),
          ),
          ),
        ],
      ),
    );
  }*/


}