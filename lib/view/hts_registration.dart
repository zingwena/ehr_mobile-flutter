import 'dart:convert';

import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/model/personInvestigation.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/sidebar.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:ehr_mobile/view/hts_testscreening.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/art_reg.dart';

import 'package:ehr_mobile/view/patient_post_test.dart';
import 'package:ehr_mobile/view/patient_pretest.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'sexualhistoryform.dart';
import 'rounded_button.dart';

class Registration extends StatefulWidget {
  String visitId;
  String patientId;
  Person person;
  Registration(this.visitId, this.patientId, this.person);

  @override
  State createState() {
    return _Registration();
  }
}

class _Registration extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  static const dataChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  static const htsChannel =
      MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  String visitId;
  String patientId;
  Person patient;
  var selectedDate;
  bool _showError = false;
  bool _entryPointIsValid = false;
  bool _formIsValid = false;
  bool showTypeError = false;
  bool typeselected = false;
  String _entryPointError = "Select Entry Point";
  DateTime date;
  int _htsType = 0;
  String htsType = "";
  String _entryPoint;
  List entryPoints = List();
  List _dropDownListEntryPoints = List();
  String hts_id;
  HtsRegistration htsRegistration;
  bool showInput = true;
  bool showInputTabOptions = true;
  List<DropdownMenuItem<String>> _dropDownMenuItemsEntryPoint;
  List<EntryPoint> _entryPointList = List();
  HtsRegistration _htsRegistration;
  String _currentEntryPoint;
  Age age;
  var facility_name;

  @override
  void initState() {
    visitId = widget.visitId;
    patientId = widget.patientId;
    getEntryPoints();
    getHtsRecord(patientId);
    getAge(widget.person);
    getFacilityName();
    selectedDate = '';
    date = DateTime.now();
    super.initState();
  }

  Future<void> getEntryPoints() async {
    String response;
    try {
      response = await dataChannel.invokeMethod('getEntryPointsOptions');
      setState(() {
        _entryPoint = response;
        entryPoints = jsonDecode(_entryPoint);
        _dropDownListEntryPoints = EntryPoint.mapFromJson(entryPoints);
        _dropDownListEntryPoints.forEach((e) {
          _entryPointList.add(e);
        });
        _dropDownMenuItemsEntryPoint =
            getDropDownMenuItemsIdentifiedEntryPoint();
      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
        date = DateFormat("yyyy/MM/dd").parse(selectedDate);
      });
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


  void _handleHtsTypeChange(int value) {
    print("hts value : $value");
    setState(() {
      _htsType = value;

      switch (_htsType) {
        case 1:
          htsType = "Self";
          print("hts value : $htsType");
          typeselected = true;

          break;
        case 2:
          htsType = "Rapid";
          print("hts value : $htsType");
          typeselected = true;

          break;
      }
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedEntryPoint() {
    List<DropdownMenuItem<String>> items = new List();
    for (EntryPoint entryPoint in _entryPointList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: entryPoint.code, child: Text(entryPoint.name)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.patientId, widget.visitId, htsRegistration, hts_id),
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
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("HTS Registration", style: TextStyle(
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
                              child: Text("Age "+age.years.toString()+ "years", style: TextStyle(
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
                                          child: Column(
                                            children: <Widget>[
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 30.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 10.0,
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 8.0, horizontal: 30.0 ),
                                                                child: TextFormField(
                                                                  controller: TextEditingController(text: selectedDate),
                                                                  validator: (value) {
                                                                    return value.isEmpty ? 'Enter some text' : null;
                                                                  },
                                                                  decoration: InputDecoration(
                                                                      suffixIcon: IconButton(
                                                                          icon: Icon(Icons.calendar_today),
                                                                          color: Colors.blue,
                                                                          onPressed: () {
                                                                            _selectDate(context);
                                                                          }),
                                                                      labelText: 'Date of HIV Test',
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 90.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding( padding: EdgeInsets.symmetric( vertical: 8.0, horizontal: 30.0 ),
                                                                child: Text('HTS Type'),
                                                              ),
                                                              width: 250,
                                                            ),
                                                          ),
                                                          Text('Rapid'),
                                                          Radio(
                                                              value: 2,
                                                              groupValue: _htsType,
                                                              onChanged: _handleHtsTypeChange)
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15.0,
                                                    ),
                                                    showTypeError == true ? SizedBox(
                                                      height: 20.0, width: 300.0, child: Text("Select HTS type ", style: TextStyle(color: Colors.red, fontSize: 15),),
                                                    ):SizedBox(height: 0.0, width: 0.0,),
                                                    Container(
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 90.0),
                                                      width: double.infinity,
                                                      child: OutlineButton(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0)),
                                                        color: Colors.white,
                                                        padding: const EdgeInsets.all(0.0),
                                                        child: Container(
                                                          width: double.infinity,
                                                          padding: EdgeInsets.symmetric( vertical: 8.0, horizontal: 30.0 ),
                                                          child: DropdownButton(
                                                            isExpanded:true,
                                                            hint: Text('Select Entry Point'),
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentEntryPoint,
                                                            items: _dropDownMenuItemsEntryPoint,
                                                            onChanged: changedDropDownItemEntryPoint,
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
                                                    SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    !_showError
                                                        ? SizedBox.shrink()
                                                        : Row(
                                                           children: <Widget>[
                                                              Expanded( child: SizedBox(
                                                                  child: Padding( padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 60.0 ),
                                                                    child: Text( _entryPointError ??
                                                               "",
                                                           style: TextStyle(
                                                color: Colors.red),
                                          ),
                                        ),),),], ),
                                                    SizedBox(
                                                      height: 35.0,
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 80.0),
                                                      child: RaisedButton(
                                                        elevation: 4.0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0)),
                                                        color: Colors.blue,
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: <Widget>[
                                                            Text('Save', style: TextStyle(color: Colors.white),),
                                                            Spacer(),
                                                            Icon(Icons.save_alt, color: Colors.white, ),
                                                          ],
                                                        ),
                                                        onPressed: () async {
                                                          if (_formKey.currentState.validate()) {
                                                            _formKey.currentState.save();
                                                            if (_entryPointIsValid & typeselected) {
                                                              setState(() {
                                                                _formIsValid = true;
                                                              });
                                                            } else {
                                                              setState(() {
                                                                _showError = true;
                                                                showTypeError = true;
                                                              });
                                                            }
                                                            if (_formIsValid) {
                                                              HtsRegistration htsDetails = HtsRegistration(null, widget.patientId,
                                                                  visitId, htsType, date, _currentEntryPoint, null);
                                                              await registration(htsDetails);
                                                              Navigator.push(context, MaterialPageRoute(builder: (context)=> HtsRegOverview(_htsRegistration, patientId, hts_id, visitId, widget.person)));

                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "HTS Registration",selected: true,
          ),
          new RoundedButton(
            text: "HTS Pre-Testing",
           /* onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PatientPretest(widget.patientId, hts_id)),
            ),*/
          ),
          new RoundedButton(text: "HTS Testing",
          ),
        ],
      ),
    );
  }

  Future<void> registration(HtsRegistration htsRegistration) async {
    String id;
    String htsresponse ;
    try {
      id = await htsChannel.invokeMethod('htsRegistration', jsonEncode(htsRegistration));
      hts_id = id;
      htsresponse = await htsChannel.invokeMethod('getHtsRegDetails', hts_id);
      setState(() {
        _htsRegistration = HtsRegistration.fromJson(jsonDecode(htsresponse));
        print("HTS REGISTRATION ON RETURN FROM FLUTTER AFTER SAVE"+ _htsRegistration.toString());
      });

      String patientid = patientId.toString();
      DateTime date = htsRegistration.dateOfHivTest;
      PersonInvestigation personInvestigation = new PersonInvestigation(
          patientid, "36069471-adee-11e7-b30f-3372a2d8551e", date, null);
    //  await htsChannel.invokeMethod('htsRegistration',jsonEncode(personInvestigation));

      print('---------------------saved file id  $id');
    } catch (e) {
      print('--------------something went wrong  $e');
    }
  }

  Future<void> getHtsRecord(String patientId) async {
    var  hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      setState(() {

        htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
        print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());

      });
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
  }

  void changedDropDownItemEntryPoint(String selectedEntryPoint) {
    setState(() {
      _currentEntryPoint = selectedEntryPoint;
      _entryPointError = null;
      _entryPointIsValid = !_entryPointIsValid;
    });
  }
}
