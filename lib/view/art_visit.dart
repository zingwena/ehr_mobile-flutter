import 'dart:convert';


import 'package:ehr_mobile/landing_screen.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/artvisit.dart';
import 'package:ehr_mobile/model/artvisitstatus.dart';
import 'package:ehr_mobile/model/artvisittype.dart';
import 'package:ehr_mobile/model/country.dart';
import 'package:ehr_mobile/model/familyplanningstatus.dart';
import 'package:ehr_mobile/model/followupstatus.dart';
import 'package:ehr_mobile/model/functionalstatus.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/lactatingstatus.dart';
import 'package:ehr_mobile/model/person.dart';

import 'package:ehr_mobile/view/patient_address.dart';
import 'package:ehr_mobile/view/rounded_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'art_Visit_Overview.dart';
//import 'patient_address.dart';
//import 'rounded_button.dart';
//import 'package:ehr_mobile/login_screen.dart';

class ArtVisitView extends StatefulWidget {

  final Person person;
  final String personId;
  final String visitId;
  final String htsId;
  final HtsRegistration htsRegistration;


  ArtVisitView(this.person, this.personId, this.visitId, this.htsId, this.htsRegistration);

  @override
  State createState() {
    return _ArtVisit();
  }
}

class _ArtVisit extends State<ArtVisitView> {
  static const platform = MethodChannel('example.channel.dev/people');
  static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
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

  Age age;

  bool _formValid=false;
  bool showError=false;
  int _clinicalStage = 0;
  String clinicalStage = "";

  String _visitType;
  List  visitTypes= List();
  List _dropDownVisitTypes = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsVisitType;
  List<ArtVisitType> _artVisitList = List();

  String _functionalStatus;
  List functionalStatuses = List();
  List _dropDownFunctionalStatuses = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsFunctionalStatuses;
  List<FunctionalStatus> _functionalStatusList = List();


  String _followUpStatus;
  List followUpStatuses = List();
  List _dropDownFollowUpStatuses = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsFollowUpStatuses;
  List<FollowUpStatus> _followUpStatusList = List();



  String _visitStatus;
  List visitStatuses = List();
  List _dropDownVisitStatuses = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsVisitStatuses;
  List<ArtVisitStatus> _visitStatusList = List();


  String _familyPlanningStatus;
  List familyPlanningStatuses = List();
  List _dropDownFamilyPlanningStatuses = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsFamilyPlanningStatuses;
  List<FamilyPlanningStatus> _familyPlanningStatusList = List();



  String _lactatingstatus;
  List lactatingstatuses = List();
  List _dropDownLactatingStatuses = List();
  List<DropdownMenuItem<String>> _dropDownMenuItemsLactatingStatuses;
  List<LactatingStatus> _lactatingStatusList = List();

  ArtVisit _artVisit;
  ArtVisit _artVisitResponse;


  String  _currentVisitType, _currentFunctionalStatus, _currentFollowUpStatus, _currentVisitStatus, _currentFamilyPlanningStatus, _currentPregnancyStatus;

  @override
  void initState() {
    getArtVist(widget.personId);
   getVisitTypes();
   getFunctionalStatus();
   getFollowUp();
   getVisitStatus();
   getFamilyPlanningStatus();
   getPregnancyStatus();
   getAge(widget.person);
    super.initState();
  }


  List<DropdownMenuItem<String>> getDropDownMenuVisitTypeItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (ArtVisitType visitTypeIdentified in _artVisitList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: visitTypeIdentified.code, child: Text(visitTypeIdentified.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuFunctionalStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (FunctionalStatus functionalStatusIdentified in _functionalStatusList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: functionalStatusIdentified.code, child: Text(functionalStatusIdentified.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuFollowUpStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (FollowUpStatus followUpStatusIdentified in _followUpStatusList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: followUpStatusIdentified.code, child: Text(followUpStatusIdentified.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuVisitStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (ArtVisitStatus visitStatusIdentified in _visitStatusList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: visitStatusIdentified.code, child: Text(visitStatusIdentified.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuFamilyPlanningStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (FamilyPlanningStatus familyPlanningIdentified in _familyPlanningStatusList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: familyPlanningIdentified.code, child: Text(familyPlanningIdentified.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuPregnancyStatusItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (LactatingStatus pregnancyStatusIdentified in _lactatingStatusList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: pregnancyStatusIdentified.code, child: Text(pregnancyStatusIdentified.name)));
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

  Future<void> getVisitTypes() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getArtVisitType');
      setState(() {
        _visitType = response;
        visitTypes = jsonDecode(_visitType);
        _dropDownVisitTypes = ArtVisitType.mapFromJson(visitTypes);
        _dropDownVisitTypes.forEach((e) {
          _artVisitList.add(e);
        });
        _dropDownMenuItemsVisitType =
            getDropDownMenuVisitTypeItemsIdentified();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
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

  Future<void> getFunctionalStatus() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getFunctionalStatus');
      setState(() {
        _functionalStatus = response;
        functionalStatuses = jsonDecode(_functionalStatus);
        _dropDownFunctionalStatuses = FunctionalStatus.mapFromJson(functionalStatuses);
        _dropDownFunctionalStatuses.forEach((e) {
          _functionalStatusList.add(e);
        });
        _dropDownMenuItemsFunctionalStatuses =
            getDropDownMenuFunctionalStatusItemsIdentified();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  Future<void> getFollowUp() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getFollowUpStatus');
      setState(() {
        _followUpStatus = response;
        followUpStatuses = jsonDecode(_followUpStatus);
        _dropDownFollowUpStatuses = FollowUpStatus.mapFromJson(followUpStatuses);
        _dropDownFollowUpStatuses.forEach((e) {
          _followUpStatusList.add(e);
        });
        _dropDownMenuItemsFollowUpStatuses =
            getDropDownMenuFollowUpStatusItemsIdentified();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  Future<void> getVisitStatus() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getArtVisitStatus');
      setState(() {
        _visitStatus = response;
        visitStatuses = jsonDecode(_visitStatus);
        _dropDownVisitStatuses = ArtVisitStatus.mapFromJson(visitStatuses);
        _dropDownVisitStatuses.forEach((e) {
          _visitStatusList.add(e);
        });
        _dropDownMenuItemsVisitStatuses =
            getDropDownMenuVisitStatusItemsIdentified();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }


  Future<void> getFamilyPlanningStatus() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getFamilyPlanningStatus');
      setState(() {
        _familyPlanningStatus = response;
        familyPlanningStatuses = jsonDecode(_familyPlanningStatus);
        _dropDownFamilyPlanningStatuses = FamilyPlanningStatus.mapFromJson(familyPlanningStatuses);
        _dropDownFamilyPlanningStatuses.forEach((e) {
          _familyPlanningStatusList.add(e);
        });
        _dropDownMenuItemsFamilyPlanningStatuses =
            getDropDownMenuFamilyPlanningStatusItemsIdentified();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }


  Future<void> getPregnancyStatus() async {
    String response;
    try {
      response = await artChannel.invokeMethod('getLactatingStatus');
      setState(() {
        _lactatingstatus = response;
        lactatingstatuses = jsonDecode(_lactatingstatus);
        _dropDownLactatingStatuses = LactatingStatus.mapFromJson(lactatingstatuses);
        _dropDownLactatingStatuses.forEach((e) {
          _lactatingStatusList.add(e);
        });
        _dropDownMenuItemsLactatingStatuses =
            getDropDownMenuPregnancyStatusItemsIdentified();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
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
                          ])
                  ),
                  _buildButtonsRow(),
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
                                                            items: _dropDownMenuItemsVisitType,
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
                                                            items: _dropDownMenuItemsFunctionalStatuses,
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
                                                            items: _dropDownMenuItemsFollowUpStatuses,
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
                                                            items: _dropDownMenuItemsVisitStatuses,
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
                                                                    text: 'admin '),
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
                                                            items: _dropDownMenuItemsFamilyPlanningStatuses,
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
                                                            items: _dropDownMenuItemsLactatingStatuses,
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
                                                            Text('Save', style: TextStyle(color: Colors.white),),
                                                            Icon(Icons.navigate_next, color: Colors.white, ),
                                                          ],
                                                        ),
                                                        onPressed: () async{
                                                          setState(() {
                                                            _formValid = true;
                                                          });


                                                          if (_formValid) {
                                                            _formKey.currentState.save();
                                                             _artVisit.visitType = _currentVisitType;
                                                             _artVisit.functionalStatus = _currentFunctionalStatus;
                                                             _artVisit.visitStatus = _currentVisitStatus;
                                                             _artVisit.ancFirstBookingDate = DateTime.now();
                                                             _artVisit.lactatingStatus = _currentPregnancyStatus;
                                                             _artVisit.familyPlanningStatus = _currentFamilyPlanningStatus;
                                                             _artVisit.tbStatus = '';
                                                             _artVisit.stage = clinicalStage;
                                                             _artVisit.followUpStatus = _currentFollowUpStatus;


                                                             await saveArtVist(_artVisit);

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        ArtVisitOverview(this._artVisitResponse, widget.personId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)
                                                                ));
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

  Future<void> saveArtVist(ArtVisit artVisit) async {
    var art_visit_response;
    try {
      art_visit_response = await artChannel.invokeMethod('saveArtVisit', jsonEncode(artVisit));
      setState(() {
        _artVisitResponse = ArtVisit.fromJson(jsonDecode(art_visit_response));
      });

    } catch (e) {
      print('--------------something went wrong in art visit save method  $e');
    }

  }

  Future<void> getArtVist(String  personId) async {
    var art_visit_response;
    try {
      art_visit_response = await artChannel.invokeMethod('getArtVisit', personId);
      setState(() {
        _artVisit = ArtVisit.fromJson(jsonDecode(art_visit_response));
      });

    } catch (e) {
      print('--------------something went wrong in art visit get  method  $e');
    }

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


  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(text: "Art Visit", onTap: () {

            if(_artVisit.visitType == null ){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ArtVisitView(widget.person, widget.personId, widget.visitId, widget.htsId, widget.htsRegistration)),
              );
            } else {
              print("ART DTO DATE IS NOT NULL");
              Navigator.push(context,MaterialPageRoute(
                  builder: (context)=>  ArtVisitOverview(this._artVisit, widget.personId, widget.visitId, widget.person, widget.htsRegistration, widget.htsId)

              ));
            }
          }

            // ArtVisitView(this.person, this.personId, this.visitId, this.htsId, this.htsRegistration);

          ),

          new RoundedButton(text: "ART Registration",),
          new RoundedButton(text: "ART Initiation", selected: true,
          ),



        ],
      ),
    );
  }

}


