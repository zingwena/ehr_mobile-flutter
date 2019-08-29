import 'dart:convert';

import 'package:ehr_mobile/model/address.dart';
import 'package:ehr_mobile/model/patient.dart';
import 'package:ehr_mobile/model/town.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PatientAddress extends StatefulWidget {
  final Patient patient;

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
  String schoolHouse, suburbVillage, town;
  Patient registeredPatient;
  List<DropdownMenuItem<String>>  _dropDownMenuItemsTown;
  String _currentTown,_towns;
  List _townList = List();
  List townList= List();
  List<Town> _townListDropdown= List();

  @override
  void initState() {
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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Person Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextFormField(
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
                SizedBox(
                  height: 15.0,
                ),
                Divider(),
                TextFormField(
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
                SizedBox(
                  height: 15.0,
                ),
                Divider(),
                Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
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
                !_showError?
                     SizedBox.shrink()
                    : Text(
                  _townError ?? "",
                  style: TextStyle(color: Colors.red),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.blue,
                      padding: const EdgeInsets.all(20.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),

                      ),
                    ),
                    RaisedButton(
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
        Patient patient = widget.patient;
        patient.address = Address(schoolHouse, suburbVillage, _currentTown);
        await registerPatient(patient).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Overview(registeredPatient)));
        });


      }
    }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> registerPatient(Patient patient)async{
    int response;
    var patientResponse;
    try {
      String jsonPatient = jsonEncode(patient.toJson());
      response= await addPatient.invokeMethod('registerPatient',jsonPatient);

      patientResponse= await addPatient.invokeMethod("getPatientById", response);
      setState(() {
        registeredPatient = Patient.fromJson(jsonDecode(patientResponse));
      });

    }
    catch(e){
      print('Something went wrong...... cause $e');
    }
  }


  void changedDropDownItemTown(String selectedTown) {
    setState(() {
      _currentTown = selectedTown;
      _townError=null;
      _townIsValid=!_townIsValid;
    });
  }
  Future<void> getTowns() async{
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
