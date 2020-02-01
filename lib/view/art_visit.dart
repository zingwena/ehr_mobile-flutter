import 'dart:convert';


import 'package:ehr_mobile/landing_screen.dart';
import 'package:ehr_mobile/model/country.dart';
import 'package:ehr_mobile/model/person.dart';

import 'package:ehr_mobile/view/patient_address.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'patient_address.dart';
//import 'rounded_button.dart';
//import 'package:ehr_mobile/login_screen.dart';

class ArtVisit extends StatefulWidget {


  ArtVisit();

  @override
  State createState() {
    return _ArtVisit();
  }
}

class _ArtVisit extends State<ArtVisit> {
  static const platform = MethodChannel('example.channel.dev/people');
  static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');

  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();

  List<String> _list;
  DateTime birthDate;
  Person registeredPatient;
  String lastName,  firstName,nationalId, religion, country,occupation,educationLevel,nationality,maritalStatus;

  String _visitTypeError="Select Visit TYpe";
  String _functionalStatusError="Select Functional Status";
  String _followUpStatusError="Select Follow Up Status";
  String _visitStatusError="Select Visit Status";
  String _familyPlanningError="Select Family Planning Status";
  String _pregnancyStatusError="Select Pregnancy Status";

  bool visitTypeIsValid=false;
  bool functionalStatusIsValid=false;
  bool followUpStatusIsValid=false;
  bool visitStatusIsValid=false;
  bool familyPlanningStatusIsValid=false;
  bool pregnancyStatusIsValid=false;

  bool _formValid=false;
  bool showError=false;
  int _clinicalStage = 0;
  String clinicalStage = "";

  List<DropdownMenuItem<String>>_dropDownMenuVisitItemsIdentified, _dropDownMenuFunctionalStatusItemsIdentified, _dropDownMenuFollowUpStatusItemsIdentified, _dropDownMenuVisitStatusItemsIdentified,
      _dropDownMenuFamilyPlanningStatusItemsIdentified, _dropDownMenuPregnancyStatusItemsIdentified   ;

  String  _currentVisitType, _currentFunctionalStatus, _currentFollowUpStatus, _currentVisitStatus, _currentFamilyPlanningStatus, _currentPregnancyStatus;

  List _visitTypeListIdentified = [ "Visit Type 1", "Visit Type 2", "Visit Type 3", "Visit Type 4", ];
  List _functionalStatusListIdentified = [ "Functional Status 1", "Functional Status 2", "Functional Status 3", "Functional Status 4", ];
  List _followUpStatusListIdentified = [ "Follow Up 1", "Follow Up 2", "Follow Up 3", "Follow Up 4", ];
  List _visitStatusListIdentified = [ "Visit Status 1", "Visit Status 2", "Visit Status 3", "Visit Status 4", ];
  List _familyPlanningStatusListIdentified = [ "Family Planning State Type 1", "Family Planning State  2", "Family Planning State  3", "Family Planning State  4", ];
  List _pregnancyStatusListIdentified = [ "Pregnancy Status 1", "Pregnancy Status 2", "Pregnancy Status 3", "Pregnancy Status 4", ];

  @override
  void initState() {

    _dropDownMenuVisitItemsIdentified = getDropDownMenuVisitItemsIdentified();
    _dropDownMenuFunctionalStatusItemsIdentified = getDropDownMenuFunctionalStatusItemsIdentified();
    _dropDownMenuFollowUpStatusItemsIdentified = getDropDownMenuFollowUpStatusItemsIdentified();
    _dropDownMenuVisitStatusItemsIdentified = getDropDownMenuVisitStatusItemsIdentified();
    _dropDownMenuFamilyPlanningStatusItemsIdentified = getDropDownMenuFamilyPlanningStatusItemsIdentified();
    _dropDownMenuPregnancyStatusItemsIdentified = getDropDownMenuPregnancyStatusItemsIdentified();

    super.initState();
  }


  List<DropdownMenuItem<String>> getDropDownMenuVisitItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (String visitTypeIdentified in _visitTypeListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: visitTypeIdentified, child: Text(visitTypeIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuFunctionalStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (String functionalStatusIdentified in _functionalStatusListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: functionalStatusIdentified, child: Text(functionalStatusIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuFollowUpStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (String followUpStatusIdentified in _followUpStatusListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: followUpStatusIdentified, child: Text(followUpStatusIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuVisitStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (String visitStatusIdentified in _visitStatusListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: visitStatusIdentified, child: Text(visitStatusIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuFamilyPlanningStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (String familyPlanningIdentified in _familyPlanningStatusListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: familyPlanningIdentified, child: Text(familyPlanningIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuPregnancyStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (String pregnancyStatusIdentified in _pregnancyStatusListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: pregnancyStatusIdentified, child: Text(pregnancyStatusIdentified)));
    }
    return items;
  }

  void _handleClinicalStageChange(int value) {
    setState(() {
      _clinicalStage = value;

      switch (_clinicalStage) {
        case 1:
          clinicalStage = "ONE";
          break;
        case 2:
          clinicalStage = "TWO";
          break;
        case 3:
          clinicalStage = "THREE";
          break;
        case 4:
          clinicalStage = "FOUR";
          break;
      }
    });
  }

  String nullValidator(var cell) {
    return cell == null ? "" : cell;
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
                    child: Text("Art Visit", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),
                 // _buildButtonsRow(),
                  Expanded(
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
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: new ConstrainedBox(
                                      constraints: new BoxConstraints(
                                        minHeight:
                                        viewportConstraints.maxHeight -
                                            48.0,
                                      ),
                                      child: new IntrinsicHeight(
                                          child: Column(
                                            children: <Widget>[
                                              Form(key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 25.0,
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
                                                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint:Text("Visit Type"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentVisitType,
                                                            items: _dropDownMenuVisitItemsIdentified,
                                                            onChanged: changedDropDownVisitItems,
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

                                                    !showError
                                                        ? SizedBox.shrink()
                                                        : Text(
                                                      _visitTypeError ?? "",
                                                      style: TextStyle(color: Colors.red),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                      EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0 ),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets.all(8.0),
                                                                child: Text('WHO Clinical Stage'),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('One'),
                                                          Radio(
                                                              value: 1,
                                                              groupValue: _clinicalStage,
                                                              activeColor:
                                                              Colors.blue,
                                                              onChanged: _handleClinicalStageChange),
                                                          Text('Two'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _clinicalStage,
                                                              activeColor: Colors.blue,
                                                              onChanged: _handleClinicalStageChange),
                                                          Text('Three'),
                                                          Radio(
                                                              value: 3,
                                                              groupValue: _clinicalStage,
                                                              activeColor:
                                                              Colors.blue,
                                                              onChanged: _handleClinicalStageChange),
                                                          Text('Four'),
                                                          Radio(
                                                              value: 4,
                                                              groupValue: _clinicalStage,
                                                              activeColor: Colors.blue,
                                                              onChanged: _handleClinicalStageChange)
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.0,
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
                                                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint:Text("Functional Status"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentFunctionalStatus,
                                                            items: _dropDownMenuFunctionalStatusItemsIdentified,
                                                            onChanged: changedDropDownFunctionalStatusItems,
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

                                                    !showError
                                                        ? SizedBox.shrink()
                                                        : Text(
                                                      _functionalStatusError ?? "",
                                                      style: TextStyle(color: Colors.red),
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
                                                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint:Text("Follow Up Status"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentFollowUpStatus,
                                                            items: _dropDownMenuFollowUpStatusItemsIdentified,
                                                            onChanged: changedDropDownFollowUpItems,
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

                                                    !showError
                                                        ? SizedBox.shrink()
                                                        : Text(
                                                      _followUpStatusError ?? "",
                                                      style: TextStyle(color: Colors.red),
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
                                                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint:Text("Visit Status"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentVisitStatus,
                                                            items: _dropDownMenuVisitStatusItemsIdentified,
                                                            onChanged: changedDropDownVisitStatusItems,
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

                                                    !showError
                                                        ? SizedBox.shrink()
                                                        : Text(
                                                      _visitStatusError ?? "",
                                                      style: TextStyle(color: Colors.red),
                                                    ),

                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(vertical: 16.0,
                                                                  horizontal: 60.0),
                                                              child: TextFormField(
                                                                controller: TextEditingController(
                                                                    text: 'Jane Doe'),
                                                                decoration: InputDecoration(
                                                                    labelText:
                                                                    'Name Of Clinician ',
                                                                    border: OutlineInputBorder()),
                                                              ),
                                                            ),
                                                            width: 100,
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: 10.0,
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
                                                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint:Text("Family Planning Status "),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentFamilyPlanningStatus,
                                                            items: _dropDownMenuFamilyPlanningStatusItemsIdentified,
                                                            onChanged: changedDropDownFamilyPlanningItems,
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

                                                    !showError
                                                        ? SizedBox.shrink()
                                                        : Text(
                                                      _familyPlanningError ?? "",
                                                      style: TextStyle(color: Colors.red),
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
                                                          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint:Text("Pregnancy Status"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentPregnancyStatus,
                                                            items: _dropDownMenuPregnancyStatusItemsIdentified,
                                                            onChanged: changedDropDownPregnancyStatusItems,
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

                                                    !showError
                                                        ? SizedBox.shrink()
                                                        : Text(
                                                      _pregnancyStatusError ?? "",
                                                      style: TextStyle(color: Colors.red),
                                                    ),


                                                    SizedBox(
                                                      height: 20.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 0.0,
                                                          horizontal: 30.0),
                                                      child: RaisedButton(
                                                        elevation: 8.0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0)),
                                                        color: Colors.blue,
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Text('Proceed to Contact Details', style: TextStyle(color: Colors.white),),
                                                            Icon(Icons.navigate_next, color: Colors.white, ),
                                                          ],
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            _formValid = true;
                                                          });


                                                          if (_formValid) {
                                                            _formKey.currentState.save();



                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        LandingScreen()));
                                                          }

                                                        },
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: 20.0,
                                                    ),

                                                  ],
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  void changedDropDownVisitItems(String selectedVisitType) {
    setState(() {
      _currentVisitType = selectedVisitType;
      visitTypeIsValid=!visitTypeIsValid;
      _visitTypeError=null;
    });
  }

  void changedDropDownFunctionalStatusItems(String selectedFunctionalStatus) {
    setState(() {
      _currentFunctionalStatus = selectedFunctionalStatus;
      functionalStatusIsValid=!functionalStatusIsValid;
      _functionalStatusError=null;
    });
  }

  void changedDropDownFollowUpItems(String selectedFollowUpStatus) {
    setState(() {
      _currentFollowUpStatus = selectedFollowUpStatus;
      followUpStatusIsValid=!followUpStatusIsValid;
      _followUpStatusError=null;
    });
  }

  void changedDropDownVisitStatusItems(String selectedVisitStatus) {
    setState(() {
      _currentVisitStatus = selectedVisitStatus;
      visitStatusIsValid=!visitStatusIsValid;
      _visitStatusError=null;
    });
  }

  void changedDropDownFamilyPlanningItems(String selectedFamilyPlanningStatus) {
    setState(() {
      _currentFamilyPlanningStatus = selectedFamilyPlanningStatus;
      familyPlanningStatusIsValid=!familyPlanningStatusIsValid;
      _familyPlanningError=null;
    });
  }

  void changedDropDownPregnancyStatusItems(String selectedPregnancyStatus) {
    setState(() {
      _currentPregnancyStatus = selectedPregnancyStatus;
      pregnancyStatusIsValid=!pregnancyStatusIsValid;
      _pregnancyStatusError=null;
    });
  }

}

