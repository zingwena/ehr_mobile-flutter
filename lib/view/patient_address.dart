import 'dart:convert';

import 'package:ehr_mobile/model/address.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/town.dart';
import 'package:ehr_mobile/model/patientphonenumber.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';

class PatientAddress extends StatefulWidget {
  final Person patient;

  PatientAddress(this.patient);

  @override
  State createState() {
    return _PatientAddressState();
  }
}

class _PatientAddressState extends State<PatientAddress> {
  static const platform = MethodChannel('example.channel.dev/people');
  static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');

  static const patientPlatform =
  MethodChannel('example.channel.dev/singlePatient');

  final _formKey = GlobalKey<FormState>();
  bool _showError=false;
  bool _townIsValid=false;
  bool _formIsValid=false;
  String _townError="Select Town";
  String schoolHouse, suburbVillage, town, phonenumber_1, phonenumber_2, patient_phonenumber_string;
  PatientPhoneNumber patientPhoneNumber;
  Person registeredPatient;
  List<DropdownMenuItem<String>>  _dropDownMenuItemsTown;
  String _currentTown,_towns;
  List _townList = List();
  List townList= List();
  List<Town> _townListDropdown= List();

  @override
  void initState() {
    print("=======");
 getTowns();
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsTown() {
    List<DropdownMenuItem<String>> items = new List();
    for (Town town in _townList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: town.name, child: Text(town.name)));
    }
    return items;
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
            title: new Text("Patient Address"),
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
                    child: new Card( elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: DefaultTabController(
                        child: new LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return Column(
                              children: <Widget>[
                                //  _buildTabBar(),

                                SizedBox(
                                  height: 15.0,
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
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: <Widget>[

                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: 16.0,
                                                                  horizontal: 60.0),
                                                              child: TextFormField(
                                                                onSaved: (value) => setState(() {
                                                                  phonenumber_1 = value; }),
                                                                  keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                    labelText: 'Phone No 1.',
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
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: 16.0, horizontal: 60.0),
                                                              child: TextFormField(
                                                                onSaved: (value) => setState(() {
                                                                  phonenumber_2 = value;
                                                                }),
                                                                keyboardType: TextInputType.number,
                                                                decoration: InputDecoration(
                                                                    labelText: 'Phone No 2.',
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
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  vertical: 16.0, horizontal: 60.0),
                                                              child:         TextFormField(
                                                                validator: (value) {
                                                                  return value.isEmpty ? 'Enter some text' : null;
                                                                },
                                                                onSaved: (value) => setState(() {
                                                                  schoolHouse = value;
                                                                }),
                                                                decoration: InputDecoration(
                                                                    labelText: 'School/House No.',
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
                                                            child: Padding( padding: EdgeInsets.symmetric(
                                                                vertical: 16.0,
                                                                horizontal: 60.0),
                                                              child: TextFormField(
                                                                validator: (value) {
                                                                  return value.isEmpty ? 'Enter some text' : null;
                                                                },
                                                                onSaved: (value) => setState(() {
                                                                  suburbVillage = value;
                                                                }),
                                                                decoration: InputDecoration(
                                                                    labelText: 'Suburb/Village',
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
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint: Text("Town"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentTown,
                                                            items: _dropDownMenuItemsTown,
                                                            onChanged: changedDropDownItemTown,
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
                                                      height: 35.0,
                                                    ),

                                                    Container(
                                                      width: double.infinity,
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 0.0,
                                                          horizontal: 30.0),
                                                      child:   RaisedButton(
                                                        elevation: 4.0,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0)),
                                                        color: Colors.blue,
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: Text(
                                                          "Save",
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                        onPressed: () async {
                                                          if (_formKey.currentState.validate()) {
                                                            _formKey.currentState.save();
                                                            if (_townIsValid) {
                                                              setState(() {
                                                                _formIsValid=true;
                                                              });
                                                            }
                                                            else{
                                                              setState(() {
                                                                _showError=true;
                                                              });
                                                            }
                                                            if(_formIsValid){
                                                              Person patient = widget.patient;

                                                              patient.address = Address(schoolHouse, suburbVillage, _currentTown);
                                                              await registerPatient(patient).then((value) {

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => Overview(registeredPatient)));
                                                              });
                                                              SnackBar(
                                                                content: Text("Patient saved"),
                                                              );
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      height: 25.0,
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "Edit Demographics",

          ),

          new RoundedButton(
            text: "Patient Address",
            selected: true,
          ),
          new RoundedButton(
            text: "Close",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> registerPatient(Person patient)async{
    String response;
    var patientResponse;
    try {
      String jsonPatient = jsonEncode(patient.toJson());
      response= await addPatient.invokeMethod('registerPatient',jsonPatient);

      patientResponse= await addPatient.invokeMethod("getPatientById", response);
      setState(() {
        registeredPatient = Person.fromJson(jsonDecode(patientResponse));
        savephonenumber();
      });


    }
    catch(e){
      print('Something went wrong...... cause $e');
    }
  }

  Future <void> savephonenumber()async{
    var phonenumber_response;
    var patientphonenumberresponse, patientphonenumber;

    print('SAVE PHONE NUMBER HERE');

    PatientPhoneNumber patientphone = PatientPhoneNumber(registeredPatient.id, phonenumber_1, phonenumber_2);
    String jsonPatientPhoneNumber = jsonEncode(patientphone.toJson());
    print('PATIENT PHONENUMBER FROM JSON'+ jsonPatientPhoneNumber);
    phonenumber_response = await addPatient.invokeMethod("savephonenumber", jsonPatientPhoneNumber);


  }

  void changedDropDownItemTown(String selectedTown) {
    setState(() {
      _currentTown = selectedTown;
      _townError=null;
      _townIsValid=!_townIsValid;
    });
  }
  Future<void> getTowns() async{
    print("here");
    String towns;
    try{
      towns= await dataChannel.invokeMethod('townOptions');
   print('****************************** $towns');
      setState(() {
        _towns=towns;
        townList =jsonDecode(_towns);
        _townListDropdown= Town.mapFromJson(townList);
        _townListDropdown.forEach((e){
          _townList.add(e);
        });
        _dropDownMenuItemsTown= getDropDownMenuItemsTown();
      });

    }catch(e){
      print(e);
    }
  }
}


