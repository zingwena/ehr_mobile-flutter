import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
/*
import 'package:ehr_mobile/view/link_bar.dart';
*/
import 'package:ehr_mobile/view/hiv_screening.dart';
import 'package:ehr_mobile/view/edit_demographics.dart';
import 'package:ehr_mobile/view/hiv_information.dart';
import 'package:ehr_mobile/view/home_page.dart';
/*
import 'package:ehr_mobile/view/bottomnavigation.dart';
*/
/*
import 'package:cbs_app/home_screen.dart';
*/
import 'package:intl/intl.dart';
/*import 'package:cbs_app/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/person_bloc.dart';*/

class PatientIndexContactDetails extends StatefulWidget {
  String indexTestId;
  PatientIndexContactDetails(this.indexTestId);
  @override
  State createState() {
    return _PatientIndexContactDetails();
  }
}

class _PatientIndexContactDetails extends State<PatientIndexContactDetails> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String lastName, firstName;
  var selectedDate;
  DateTime date;

  String _currentMaritalStatus;

  List<DropdownMenuItem<String>> _dropDownMenuItemsMaritalStatus;

  List _maritalStatusList = [
    "Select Relationship",
    "Grand Father",
    "Grand Mother",
    "Father",
    "Mother",
    "Uncle",
  ];

  @override
  void initState() {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    _dropDownMenuItemsMaritalStatus = getDropDownMenuItemsIdentifiedRelationshipStatus();
    _currentMaritalStatus = _dropDownMenuItemsMaritalStatus[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedRelationshipStatus() {
    List<DropdownMenuItem<String>> items = new List();
    for (String maritalStatus in _maritalStatusList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: maritalStatus, child: Text(maritalStatus)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
/*
    final PersonBloc _personBloc = BlocProvider.of<PersonBloc>(context);
*/
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
                    child: Text("Patient Index Contact Details", style: TextStyle(
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
                                Icons.person_pin, size: 25.0, color: Colors.white,),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text("Tom Wilson", style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14.0,color: Colors.white ),),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Icon(
                                Icons.verified_user, size: 25.0, color: Colors.white,),

                            ),
                          ])
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
                                 // _buildLinkBar(),
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
                                                      Container(
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60.0),
                                                        width: double.infinity,
                                                        child: OutlineButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5.0)),
                                                          color: Colors.white,
                                                          padding: const EdgeInsets.all(0.0),
                                                          child: Container(
                                                            width: double.infinity,
                                                            padding:
                                                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                            child: DropdownButton(
                                                              isExpanded: true,
                                                              icon: Icon(Icons.keyboard_arrow_down),
                                                              iconEnabledColor: Colors.black,
                                                              value: _currentMaritalStatus,
                                                              items: _dropDownMenuItemsMaritalStatus,
                                                              onChanged: changedDropDownItemMaritalStatus,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                          borderSide: BorderSide(
                                                            color: Colors.blue, //Color of the border
                                                            style: BorderStyle.solid, //Style of the border
                                                            width: 2.0, //width of the border
                                                          ),
                                                          onPressed: () {},
                                                        ),
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
                                                                      labelText: 'Contact Phone Number',
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
                                                                      labelText: 'Contact Address',
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
                                                                      labelText: 'Surburb / Village',
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
                                                                      labelText: 'Town',
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
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
                                                                      Text('Proceed to Index Contact HIV Information', style: TextStyle(color: Colors.white),),
                                                                      Icon(Icons.navigate_next, color: Colors.white, ),
                                                                    ],
                                                                  ),
                                                                 // onPressed: () {}
                                                                  onPressed: () {
                                                               /*     Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(builder: (context) => HivInformation(widget.indexTestId, )),),*/

                              }
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

/*
  Widget _buildLinkBar({bool showFirstOption}) {
    return
      Row(
        children: <Widget>[
          new LinkBarItems(
            text: "Personal Details />",

          ),
          new LinkBarItems(
            text: "Address & Phone No. />",
            selected: true,
          ),
          new LinkBarItems(
            text: "HIV Info />",
          ),
          new LinkBarItems(
            text: "HIV Disclosure />",

          ),

        ],
      );
  }
*/

  void changedDropDownItemMaritalStatus(String selectedMaritalStatus) {
    setState(() {
      _currentMaritalStatus = selectedMaritalStatus;
    });
  }

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
