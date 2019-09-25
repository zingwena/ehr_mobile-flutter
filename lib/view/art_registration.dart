import 'dart:convert';
import 'dart:core';
import 'package:ehr_mobile/model/artRegistration.dart';
import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'art_initiation.dart';
import 'rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Art_Registration extends StatefulWidget {

String patientId ;
Art_Registration(this.patientId);

@override
  State createState() {
    return _Art_Registration();
  }
}

class _Art_Registration extends State<Art_Registration> {
  final _formKey = GlobalKey<FormState>();
  static const artChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile.channel/art');
  String personId;
  DateTime dateOfEnrolmentIntoCare;
  DateTime dateOfHivTest;
  String oiArtNumber;
  var selectedDate, selectedDateOfEnrollment;
  bool _formIsValid = true;



  @override
  void initState() {


    /*getFacilities();*/
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    dateOfHivTest = DateTime.now();
    dateOfEnrolmentIntoCare = DateTime.now();
    super.initState();
  }



  /*Future<void> getFacilities() async {
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

      });
    } catch (e) {
      print('--------------------Something went wrong  $e');
    }
  }*/

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
        dateOfHivTest = DateFormat("yyyy/MM/dd").parse(selectedDate);
      });
  }

  Future<Null> _selectedDateOfEnrollment(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateOfEnrollment)
      setState(() {
        selectedDateOfEnrollment = DateFormat("yyyy/MM/dd").format(picked);
        print(">>>>>>>>>>>>>>>>>>>>> selected starttime date" + selectedDateOfEnrollment);
        dateOfEnrolmentIntoCare = DateFormat("yyyy/MM/dd").parse(selectedDateOfEnrollment);
      });
  }

  /*void _handleHtsTypeChange(int value) {
    print("hts value : $value");
    setState(() {
      _selecType = value;

      switch (_selecType) {
        case 1:
          clientType = "New Client";
          print("client value : $clientType");

          break;
        case 2:
          clientType = "Old Client";
          print("client value : $clientType");

          break;
      }
    });
  }*/

  /*List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedEntryPoint() {
    List<DropdownMenuItem<String>> items = new List();
    for (EntryPoint entryPoint in _entryPointList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: entryPoint.code, child: Text(entryPoint.name)));
    }
    return items;
  }*/

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
            title: new Text(
                "Art Registration"
            ),
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
                  _buildButtonsRow(),
                  Expanded(
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

                                                      SizedBox(
                                                        height: 20.0,
                                                      ),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 0.0, horizontal: 30.0),
                                                                child: TextFormField(
                                                                  controller:
                                                                  TextEditingController(text: selectedDate),
                                                                  validator: (value) {
                                                                    return value.isEmpty ? 'Enter some text' : null;
                                                                  },
                                                                  decoration: InputDecoration(
                                                                      labelText: 'Date of Enrolment into Care',
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(Icons.calendar_today),
                                                            color: Colors.blue,
                                                            onPressed: () {
                                                              _selectedDateOfEnrollment(context);
                                                            },
                                                          ),

                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: 0.0, horizontal: 30.0),
                                                                child: TextFormField(
                                                                  controller:
                                                                  TextEditingController(text: selectedDate),
                                                                  validator: (value) {
                                                                    return value.isEmpty ? 'Enter some text' : null;
                                                                  },
                                                                  decoration: InputDecoration(
                                                                      labelText: 'Date of HIV Test',
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(Icons.calendar_today),
                                                            color: Colors.blue,
                                                            onPressed: () {
                                                              _selectDate(context);
                                                            },
                                                          ),
                                                        ],
                                                      ),


                                                      SizedBox(
                                                        height: 10.0,
                                                      ),

                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                                child:
                                                                TextFormField(
                                                                  validator: (value) {
                                                                    return value.isEmpty ? 'Enter some text' : null;
                                                                  },
                                                                  onSaved: (value) => setState(() {
                                                                    oiArtNumber = value;
                                                                  }),
                                                                  decoration: InputDecoration(
                                                                      labelText: 'Oi Art Number',
                                                                      border: OutlineInputBorder()),
                                                                ),
                                                              ),
                                                              width: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),



                                                      SizedBox(
                                                        height: 35.0,
                                                      ),

                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 30.0 ),
                                                        child: RaisedButton(
                                                          elevation: 4.0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(5.0)),
                                                          color: Colors.blue,
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: Text("Register",
                                                            style: TextStyle( fontSize: 15,
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w500),
                                                          ),
                                                          onPressed: () async {
                                                          if (_formKey.currentState.validate()) {
                                                            _formKey
                                                                .currentState
                                                                .save();
                                                          }

                                                                ArtRegistration artRegistrationDetails = ArtRegistration(widget.patientId, dateOfEnrolmentIntoCare, dateOfHivTest, oiArtNumber);
                                                                print('*************************artReg number ${artRegistrationDetails.oiArtNumber}');
                                                                await artRegistration(
                                                                    artRegistrationDetails);

                                                                await artRegistration(artRegistrationDetails);

                                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> Art_Initiation(widget.patientId)));


                                                          },
 /*   onPressed: () async {
    if (_formKey.currentState.validate()) {
    _formKey.currentState.save();
    if (_formIsValid) {
    print('FORM IS VALID FORM IS VALID '+ _formIsValid.toString());

    LaboratoryInvestigationTest labInvestTest = LaboratoryInvestigationTest(id, "laboratoryInvestigationId", startTime, readingTime, result, visit_id);
    print('************************* SAVE LAB TEST ${labInvestTest.toString()}');



    Navigator.push(context, MaterialPageRoute(
    builder:(context)=> PatientPostTest()
    ));*/
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 25.0,
                                                      ),
                                                    ],
                                                  ),
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
         /* new RoundedButton(text: "ART Initiation",
          ),
*/


          new RoundedButton(text: "ART Initiation", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Art_Initiation(widget.patientId)),
          ),),



          new RoundedButton(text: "Art Registration",selected: true,
          ),
          new RoundedButton(text: "CLOSE", onTap: () =>     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchPatient()),
          ),
          ),
        ],
      ),
    );
  }

  Future<void> artRegistration(ArtRegistration artRegistration) async {
    int id;
    print('*************************artRegistration ${artRegistration.toString()}');
    try {
      id = await artChannel.invokeMethod(
          'saveArtRegistration', jsonEncode(artRegistration));
      String patientid = personId;


    print('---------------------saved file id  $id');
  } catch (e) {
  print('--------------something went wrong  $e');
  }

  }
}



