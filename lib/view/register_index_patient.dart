import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
/*
import 'package:ehr_mobile/view/link_bar.dart';
*/
import 'package:ehr_mobile/view/hiv_screening.dart';
import 'package:ehr_mobile/view/patient_index_contact_details.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/home_page.dart';
/*
import 'package:ehr_mobile/view/bottomnavigation.dart';
*/
/*
import 'package:ehr_mobile/home_screen.dart';
*/
import 'package:intl/intl.dart';
/*import 'package:cbs_app/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/person_bloc.dart';*/

class RegisterIndexPatient extends StatefulWidget {
  @override
  State createState() {
    return _RegisterIndexPatient();
  }
}

class _RegisterIndexPatient extends State<RegisterIndexPatient> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String lastName, firstName;
  var selectedDate;
  DateTime date;
  int _gender = 0;
  String gender = "";

  List<DropdownMenuItem<String>> _identifierDropdownMenuItem;


  @override
  void initState() {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();

    super.initState();
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

  void _handleGenderChange(int value) {
    setState(() {
      _gender = value;

      switch (_gender) {
        case 1:
          gender = "Male";
          break;
        case 2:
          gender = "Female";
          break;
      }
    });
  }

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
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Add Index Patient", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                  //    _buildButtonsRow(),
                  Expanded(
                    child: WillPopScope(
                      child: new Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.all(8.0),
                        child: DefaultTabController(
                          child: new LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints viewportConstraints) {
                              return Column(
                                children: <Widget>[
                                  //_buildLinkBar(),
                                  Container(
                                    height: 2.0,
                                    color: Colors.blue,
                                  ),
                                  //   _buildTabBar(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: new ConstrainedBox(
                                        constraints: new BoxConstraints(
                                          minHeight:
                                          viewportConstraints.maxHeight -
                                              48.0,
                                        ),
                                        child: new IntrinsicHeight(
                                            child:
                                            Column(
                                              children: <Widget>[
                                                Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 16.0,
                                                                    horizontal: 60.0),
                                                                child:
                                                                TextFormField(

                                                                  onSaved: (value) =>
                                                                      setState(
                                                                              () {
                                                                            lastName = value;
                                                                          }),
                                                                  decoration: InputDecoration(
                                                                      labelText: "ID Number",
                                                                      hintText: "63-456784321V18",
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child:
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 16.0,
                                                                    horizontal: 60.0),
                                                                child:
                                                                TextFormField(
                                                                  validator:
                                                                      (value) {
                                                                    return value.isEmpty
                                                                        ? 'Enter some text'
                                                                        : null;
                                                                  },
                                                                  onSaved: (value) =>
                                                                      setState( () {
                                                                        lastName = value;
                                                                      }),
                                                                  decoration: InputDecoration(
                                                                      labelText: 'Last Name',
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child:
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 16.0, horizontal: 60.0),
                                                                child:
                                                                TextFormField(
                                                                  validator:
                                                                      (value) {
                                                                    return value.isEmpty
                                                                        ? 'Enter some text'
                                                                        : null;
                                                                  },
                                                                  onSaved: (value) =>
                                                                      setState(
                                                                              () {
                                                                            firstName =
                                                                                value;
                                                                          }),
                                                                  decoration: InputDecoration(
                                                                      labelText: 'First Name',
                                                                      border:
                                                                      OutlineInputBorder()),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 0.0),
                                                                  child: Text('Sex'),
                                                                ),
                                                                width: 100,
                                                              ),
                                                            ),
                                                            Text('Male',
                                                              style: TextStyle(
                                                                color: Colors.grey.shade500,
                                                              ),),
                                                            Radio(
                                                                value: 1,
                                                                groupValue: _gender,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleGenderChange),
                                                            Text('Female',
                                                              style: TextStyle(
                                                                color: Colors.grey.shade500,
                                                              ),
                                                            ),
                                                            Radio(
                                                                value: 2,
                                                                groupValue: _gender,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleGenderChange)
                                                          ],
                                                        ),
                                                      ),

                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child:
                                                                Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: 0.0, horizontal: 0.0),
                                                                  child:
                                                                  TextFormField(
                                                                    controller: TextEditingController(
                                                                        text: selectedDate),
                                                                    validator:
                                                                        (value) {
                                                                      return value.isEmpty
                                                                          ? 'Enter some text'
                                                                          : null;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        labelText: 'Date Of Birth',

                                                                        border: OutlineInputBorder()),
                                                                  ),
                                                                ),
                                                                width: 60,
                                                              ),
                                                            ),
                                                            IconButton(
                                                                icon: Icon(Icons.calendar_today),
                                                                color: Colors.blue,
                                                                onPressed: () { _selectDate(context);
                                                                })
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),


                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                              child: RaisedButton(
                                                                elevation: 4.0,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(5.0)),
                                                                color: Colors.blue,
                                                                padding: const EdgeInsets.all(20.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Text('Proceed to Index Contact Address', style: TextStyle(color: Colors.white),),
                                                                      Icon(Icons.navigate_next, color: Colors.white, ),
                                                                    ],
                                                                  ),
                                                                 // onPressed: () {}
                                                                  onPressed: () => Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => PatientIndexContactDetails()),),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 16.0, top: 8.0),
                                                  child: FloatingActionButton(
                                                    onPressed: () =>
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SearchPatient()),
                                                        ),
                                                    child: Icon(
                                                        Icons.home, size: 30.0),
                                                  ),
                                                ),
                                              ],
                                            )

                                        ),
                                      ),
                                    ),
                                  )
                                ],
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
      // bottomNavigationBar: BottomNavigation(),
    );
  }

/*  Widget _buildLinkBar({bool showFirstOption}) {
    return
      Row(
        children: <Widget>[
          new LinkBarItems(
            text: "Personal Details />",
            selected: true,
          ),
          new LinkBarItems(
            text: "Address & Phone No. />",
          ),
          new LinkBarItems(
            text: "HIV Info />",
          ),
          new LinkBarItems(
            text: "HIV Disclosure />",

          ),

        ],
      );
  }*/

  /* Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "VITALS",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReceptionVitals()),
            ),
          ),
          new RoundedButton(
            text: "HTS",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HivScreening()),
            ),
          ),
          new RoundedButton(
            text: "ART",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReceptionVitals()),
            ),
          ),
        ],
      ),
    );
  }

  */

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "Personal Details",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            ),
          ),
          new RoundedButton(
            text: "Address & Phone No.", selected: true,

          ),
          new RoundedButton(
            text: "HIV Info",

          ),
          new RoundedButton(
            text: "Disclosure & Partner Testing",

          ),
        ],
      ),
    );
  }


}
