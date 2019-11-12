import 'dart:convert';


import 'package:ehr_mobile/model/country.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/religion.dart';
import 'package:ehr_mobile/model/education_level.dart';
import 'package:ehr_mobile/model/nationality.dart';
import 'package:ehr_mobile/model/occupation.dart';
import 'package:ehr_mobile/model/religion.dart';
import 'package:ehr_mobile/view/add_patient.dart';
import 'package:ehr_mobile/view/index_patient_address.dart';
import 'package:ehr_mobile/view/patient_address.dart';
import 'package:ehr_mobile/view/patient_overview.dart';

import 'package:intl/intl.dart';
import 'package:ehr_mobile/model/marital_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'patient_address.dart';
import 'rounded_button.dart';
import 'package:ehr_mobile/login_screen.dart';

class EditDemographicsIndex extends StatefulWidget {
  final String lastName, firstName, sex, nationalId, indexTestId, personId;
  final DateTime birthDate;

  EditDemographicsIndex(this.lastName, this.firstName, this.birthDate, this.sex, this.nationalId, this.indexTestId, this.personId);

  @override
  State createState() {
    return _EditDemographicsState();
  }
}

class _EditDemographicsState extends State<EditDemographicsIndex> {
  static const platform = MethodChannel('example.channel.dev/people');
  static final MethodChannel addPatient= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/addPatient');

  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();

  List<String> _list;
  DateTime birthDate;
  Person registeredPatient;
  String lastName,  firstName,nationalId, religion, country,occupation,educationLevel,nationality,maritalStatus;
  String _dropdownError="Select Country of birth";
  String _maritalStatusError="Select Marital status";
  String _nationalityError="Select Nationality";
  String _educationLevelError="Select Education Level";
  String _religionError="Select Religion";
  String _selfIdentifiedGenderError="Select Self Identified gender";
  String _occupationError="Select Occupation";

  bool occupationIsValid=false;
  bool countryIsValid=false;
  bool maritalStatusIsValid=false;
  bool nationalityIsValid=false;
  bool educationLevelIsValid=false;
  bool religionIsValid=false;
  bool selfIdentifiedGenderIsValid=false;

  bool _formValid=false;
  bool showError=false;
  List _religions= List();
  List<Religion> _religionListDropdown= List();

  List _countries= List();
  List<Country> _countryListDropdown= List();

  List _occupations= List();
  List<Occupation> _occupationListDropdown= List();

  List _nationalities= List();
  List<Nationality> _nationalityListDropdown= List();

  List _educationLevels= List();
  List<EducationLevel> _educationLevelListDropdown= List();

  List _maritalStatuses= List();
  List<MaritalStatus> _maritalStatusListDropdown= List();




  List<DropdownMenuItem<String>> _dropDownMenuItems,
      _dropDownMenuItemsIdentified,
      _dropDownMenuItemsMaritalStatus,
      _dropDownMenuItemsEducationLevel,
      _dropDownMenuItemsOccupation,
      _dropDownMenuItemsReligion,
      _dropDownMenuItemsNationality,
      _dropDownMenuItemsCountry;

  String _currentGender,
      _currentSiGender,
      _currentMaritalStatus,
      _currentEducationLevel,
      _currentOccupation,
      _currentReligion,
      _currentNationality,
      _currentCountry;

  List _genderList = ["", "Male", "Female", "Other"];
  List _genderListIdentified = [
    "MALE",
    "FEMALE",
    "OTHER",
    "NON_BINARY"
  ];
  List _maritalStatusList = List();
  List _educationLevelList = List();
  List _occupationList = List();
  List _religionList = List();
  List _nationalityList = List();
  List _countryList = List();

  @override
  void initState() {
    _retrieveMetaDataFromDB();
    _dropDownMenuItems = getDropDownMenuItems();
    _dropDownMenuItemsIdentified = getDropDownMenuItemsIdentified();
    nationalId=widget.nationalId;
    _currentGender = widget.sex;
    firstName = widget.firstName;
    lastName = widget.lastName;
    birthDate = widget.birthDate;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String gender in _genderList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: gender, child: Text(gender)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentified() {
    List<DropdownMenuItem<String>> items = new List();
    for (String genderIdentified in _genderListIdentified) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(
          value: genderIdentified, child: Text(genderIdentified)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedMaritalStatus() {
    List<DropdownMenuItem<String>> items = new List();
    for (MaritalStatus maritalStatus in _maritalStatusList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: maritalStatus.code, child: Text(maritalStatus.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>>
  getDropDownMenuItemsIdentifiedEducationLevel() {
    List<DropdownMenuItem<String>> items = new List();
    for (EducationLevel educationLevel in _educationLevelList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: educationLevel.code, child: Text(educationLevel.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsOccupation() {
    List<DropdownMenuItem<String>> items = new List();
    for (Occupation occupation in _occupationList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: occupation.code, child: Text(occupation.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsReligion() {
    List<DropdownMenuItem<String>> items = new List();
    for (Religion religion in _religionList) {

      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: religion.code, child: Text(religion.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsNationality() {
    List<DropdownMenuItem<String>> items = new List();
    for (Nationality nationality in _nationalityList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: nationality.code, child: Text(nationality.name)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsCountry() {
    List<DropdownMenuItem<String>> items = new List();
    for (Country country in _countryList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: country.code, child: Text(country.name)));
    }
    return items;
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
            title: new Text("Continue Patient Registration"),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 40.0),
              child: new Column(
                children: <Widget>[
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
                                              Form(key: _formKey,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 15.0,
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
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint:Text("Self Identified Gender"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentSiGender,
                                                            items: _dropDownMenuItemsIdentified,
                                                            onChanged: changedDropDownItemSi,
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
                                                      _selfIdentifiedGenderError ?? "",
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
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint: Text("Marital Status"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentMaritalStatus,
                                                            items: _dropDownMenuItemsMaritalStatus,
                                                            onChanged: changedDropDownItemMaritalStatus,
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
                                                      _maritalStatusError ?? "",
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
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint: Text("Education Level"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentEducationLevel,
                                                            items: _dropDownMenuItemsEducationLevel,
                                                            onChanged: changedDropDownItemEducationLevel,
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
                                                      _educationLevelError ?? "",
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
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint: Text("Occupation"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentOccupation,
                                                            items: _dropDownMenuItemsOccupation,
                                                            onChanged: changedDropDownItemOccupation,
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
                                                      _occupationError ?? "",
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
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint: Text("Religion"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentReligion,
                                                            items: _dropDownMenuItemsReligion,
                                                            onChanged: changedDropDownItemReligion,
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
                                                      _religionError ?? "",
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
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint: Text("Nationality"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentNationality,
                                                            items: _dropDownMenuItemsNationality,
                                                            onChanged: changedDropDownItemNationality,
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
                                                      _nationalityError ?? "",
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
                                                          padding:
                                                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                                          child: DropdownButton(
                                                            icon: Icon(Icons.keyboard_arrow_down),
                                                            hint: Text("Country of Birth"),
                                                            iconEnabledColor: Colors.black,
                                                            value: _currentCountry,
                                                            items: _dropDownMenuItemsCountry,
                                                            onChanged: changedDropDownItemCountry,
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
                                                      _dropdownError ?? "",
                                                      style: TextStyle(color: Colors.red),
                                                    ),

                                                    SizedBox(
                                                      height: 10.0,
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
                                                        child: Text(
                                                          "Next",
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            _formValid = true;
                                                          });
                                                          /*   if (countryIsValid && maritalStatusIsValid && educationLevelIsValid
                            && religionIsValid && selfIdentifiedGenderIsValid
                            && nationalityIsValid && occupationIsValid ) {
                          print('ALL FIELDS ARE VALID');
                          setState(() {
                            _formValid = true;
                          });
                        }
                        else{
                          print('9999999999999999999999999999999999999999999999999999 country $countryIsValid');
                          print('9999999999999999999999999999999999999999999999999999 marital $maritalStatusIsValid');
                          print('9999999999999999999999999999999999999999999999999999 education $educationLevelIsValid');
                          print('9999999999999999999999999999999999999999999999999999 religious $religionIsValid');
                          print('9999999999999999999999999999999999999999999999999999  gender $selfIdentifiedGenderIsValid');
                          print('9999999999999999999999999999999999999999999999999999 nationality $nationalityIsValid');
                          print('9999999999999999999999999999999999999999999999999999 occupation $occupationIsValid');


                          setState(() {
                            showError= true;
                          });
                        }*/

                                                          if (_formValid) {
                                                            _formKey.currentState.save();

                                                            Person patient = Person.basic(
                                                                firstName,
                                                                lastName,
                                                                _currentGender,
                                                                nationalId,
                                                                birthDate,
                                                                _currentReligion,
                                                                _currentMaritalStatus,
                                                                _currentEducationLevel,
                                                                _currentNationality,
                                                                _currentCountry,
                                                                _currentSiGender,
                                                                _currentOccupation);

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        IndexPatientAddress(patient, widget.indexTestId, widget.personId)));
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

  Widget _buildButtonsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          new RoundedButton(
            text: "Edit Demographics",
            selected: true,
          ),

          new RoundedButton(
            text: "Patient Address",
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


  Future<void>  _retrieveMetaDataFromDB() async{
    String result, countries, occupations,educationLevels,nationalities,maritalStates;
    try{
      result= await dataChannel.invokeMethod('religionOptions');
      countries= await dataChannel.invokeMethod('countryOptions');
      occupations= await dataChannel.invokeMethod('occupationOptions');
      educationLevels= await dataChannel.invokeMethod('educationLevelOptions');
      nationalities= await dataChannel.invokeMethod('nationalityOptions');
      maritalStates=await dataChannel.invokeMethod('maritalStatusOptions');
      setState(() {
        religion=result;
        _religions=jsonDecode(religion);
        _religionListDropdown= Religion.mapFromJson(_religions);
        _religionListDropdown.forEach((e){
          _religionList.add(e);
        });

        _dropDownMenuItemsReligion = getDropDownMenuItemsReligion();

        country=countries;
        _countries= jsonDecode(country);
        _countryListDropdown=Country.mapFromJson(_countries);
        _countryListDropdown.forEach((e){
          _countryList.add(e);
        });
        _dropDownMenuItemsCountry = getDropDownMenuItemsCountry();

      });

      occupation=occupations;
      _occupations=jsonDecode(occupation);
      _occupationListDropdown= Occupation.mapFromJson(_occupations);
      _occupationListDropdown.forEach((e){
        _occupationList.add(e);
      });
      _dropDownMenuItemsOccupation = getDropDownMenuItemsOccupation();


      maritalStatus=maritalStates;
      _maritalStatuses=jsonDecode(maritalStatus);
      _maritalStatusListDropdown= MaritalStatus.mapFromJson(_maritalStatuses);
      _maritalStatusListDropdown.forEach((e){
        _maritalStatusList.add(e);
      });
      _dropDownMenuItemsMaritalStatus =
          getDropDownMenuItemsIdentifiedMaritalStatus();

      nationality=nationalities;
      _nationalities=jsonDecode(nationality);
      _nationalityListDropdown= Nationality.mapFromJson(_nationalities);
      _nationalityListDropdown.forEach((e){
        _nationalityList.add(e);
      });
      _dropDownMenuItemsNationality = getDropDownMenuItemsNationality();

      educationLevel=educationLevels;
      _educationLevels= jsonDecode(educationLevel);
      _educationLevelListDropdown= EducationLevel.mapFromJson(_educationLevels);
      _educationLevelListDropdown.forEach((e){
        _educationLevelList.add(e);
      });
      _dropDownMenuItemsEducationLevel =
          getDropDownMenuItemsIdentifiedEducationLevel();

    }
    catch(e){
      print('something went wrong--------------------------- $e');
    }
  }

//  _handleAdd(String dataType) async {
//    confirmDialog(context).then((bool value) async {});
//  }


//
//  Future<bool> confirmDialog(BuildContext context) async {
//    return showDialog<bool>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text("Nationality List"),
//          content: Container(
//            child: SingleChildScrollView(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                children: <Widget>[
//                  table(),
//                ],
//              ),
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//                onPressed: () {
//                  Navigator.of(context).pop(true);
//                },
//                child: Text("Cancel"))
//          ],
//        );
//      },
//    );
//  }

  void changedDropDownItem(String selectedGender) {
    setState(() {
      _currentGender = selectedGender;
    });
  }

  void changedDropDownItemSi(String selectedGenderIdentified) {
    setState(() {
      _currentSiGender = selectedGenderIdentified;
      selfIdentifiedGenderIsValid=!selfIdentifiedGenderIsValid;
      _selfIdentifiedGenderError=null;
    });
  }

  void changedDropDownItemMaritalStatus(String selectedMaritalStatus) {
    setState(() {
      _currentMaritalStatus = selectedMaritalStatus;
      maritalStatusIsValid=!maritalStatusIsValid;
      _maritalStatusError=null;
    });
  }

  void changedDropDownItemEducationLevel(String selectedEducationLevel) {
    setState(() {
      _currentEducationLevel = selectedEducationLevel;
      educationLevelIsValid=!educationLevelIsValid;
      _educationLevelError=null;
    });
  }

  void changedDropDownItemOccupation(String selectedOccupation) {
    setState(() {
      _currentOccupation = selectedOccupation;
      occupationIsValid=!occupationIsValid;
      _occupationError=null;
    });
  }

  void changedDropDownItemReligion(String selectedReligion) {
    setState(() {
      _currentReligion = selectedReligion;
      religionIsValid=!religionIsValid;
      _religionError=null;
    });

    print('@@@@@@@@@@@@@@@@@@ $_currentReligion');
  }

  void changedDropDownItemNationality(String selectedNationality) {
    setState(() {
      _currentNationality = selectedNationality;
      nationalityIsValid=!nationalityIsValid;
      _nationalityError=null;
    });
  }

  void changedDropDownItemCountry(String selectedCountry) {
    if(selectedCountry!=null) {
      setState(() {
        _currentCountry = selectedCountry;
        _dropdownError = null;
        countryIsValid = !countryIsValid;
      });
    }
  }

  Future<void> registerPatient(Person person)async{
    String response;
    String patientResponse;
    try {
      String jsonPatient = jsonEncode(person.toJson());
      response= await addPatient.invokeMethod('registerPatient',jsonPatient);
      patientResponse= await addPatient.invokeMethod("getPatientById", response);

      setState(() {
        registeredPatient = Person.fromJson(jsonDecode(patientResponse));
      });
      print('========================= $response');
    }
    catch(e){
      print('Something went wrong...... cause $e');
    }
  }

}
