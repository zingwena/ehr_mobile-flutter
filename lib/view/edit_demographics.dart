import 'dart:convert';
import 'package:intl/intl.dart';
//import 'package:cbs_app/model/person.dart';
//import 'package:cbs_app/widgets/list_people.dart';
//import 'package:cbs_app/widgets/people_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'patient_address.dart';
 
class EditDemographics extends StatefulWidget {
  final String lastName, firstName, sex;
  final DateTime birthDate;

  EditDemographics(this.lastName, this.firstName, this.birthDate, this.sex);

  @override
  State createState() {
    return _EditDemographicsState();
  }
}

class _EditDemographicsState extends State<EditDemographics> {
  static const platform = MethodChannel('example.channel.dev/people');

  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  final _formKey = GlobalKey<FormState>();
  static var date = DateFormat("yyyy/MM/dd").format(DateTime.now());
  DateTime selectedDate = DateFormat("yyyy/MM/dd").parse(date);
  List<String> _list;

  String lastName, firstName;

  List<DropdownMenuItem<String>> _dropDownMenuItems,
      _dropDownMenuItemsIdentified,
      _dropDownMenuItemsMaritalStatus,
      _dropDownMenuItemsEducationLevel,
      _dropDownMenuItemsOccupation,
      _dropDownMenuItemsReligion,
      _dropDownMenuItemsNationality,
      _dropDownMenuItemsCountry;

  String _currentGender,
      _currentSiGender = 'Self Identified Gender',
      _currentMaritalStatus,
      _currentEducationLevel,
      _currentOccupation,
      _currentReligion,
      _currentNationality,
      _currentCountry;

  List _genderList = ["", "Male", "Female", "Other"];
  List _genderListIdentified = [
    "Self Identified Gender",
    "Male",
    "Female",
    "Other",
    "Non-Binary"
  ];
  List _maritalStatusList = [
    "Marital Status",
    "Never Married",
    "Married",
    "Divorced",
    "Widowed",
    "Other",
    "Seperated"
  ];
  List _educationLevelList = [
    "Education Level",
    "Non",
    "Primary",
    "Secondary",
    "Tertiary"
  ];
  List _occupationList = [
    "Occupation",
    "Self Employed",
    "Student",
    "Employed",
    "Unemployed",
    "N/A"
  ];
  List _religionList = [
    "Religion",
    "Christianity",
    "Hinduism",
    "Bhudaism",
    "Atheist"
  ];
  List _nationalityList = ["Nationality", "Zimbabwean", "Malawian"];
  List _countryList = ["Country", "Zimbabwe", "Malawi"];

  @override
  void initState() {
    _retrieveMetaDataFromDB();
    _dropDownMenuItems = getDropDownMenuItems();
    _dropDownMenuItemsIdentified = getDropDownMenuItemsIdentified();
    _dropDownMenuItemsMaritalStatus =
        getDropDownMenuItemsIdentifiedMaritalStatus();
    _dropDownMenuItemsEducationLevel =
        getDropDownMenuItemsIdentifiedEducationLevel();
    _dropDownMenuItemsOccupation = getDropDownMenuItemsOccupation();
    _dropDownMenuItemsReligion = getDropDownMenuItemsReligion();
    _dropDownMenuItemsNationality = getDropDownMenuItemsNationality();
    _dropDownMenuItemsCountry = getDropDownMenuItemsCountry();

    _currentGender = widget.sex;
    firstName = widget.firstName;
    lastName = widget.lastName;
    selectedDate = widget.birthDate;
    date = DateFormat("yyyy/MM/dd").format(widget.birthDate);
    _currentSiGender = _dropDownMenuItemsIdentified[0].value;
    _currentMaritalStatus = _dropDownMenuItemsMaritalStatus[0].value;
    _currentEducationLevel = _dropDownMenuItemsEducationLevel[0].value;
    _currentOccupation = _dropDownMenuItemsOccupation[0].value;
    _currentReligion = _dropDownMenuItemsReligion[0].value;
    _currentNationality = _dropDownMenuItemsNationality[0].value;
    _currentCountry = _dropDownMenuItemsCountry[0].value;
  
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
    for (String maritalStatus in _maritalStatusList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: maritalStatus, child: Text(maritalStatus)));
    }
    return items;
  }

  List<DropdownMenuItem<String>>
      getDropDownMenuItemsIdentifiedEducationLevel() {
    List<DropdownMenuItem<String>> items = new List();
    for (String educationLevel in _educationLevelList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: educationLevel, child: Text(educationLevel)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsOccupation() {
    List<DropdownMenuItem<String>> items = new List();
    for (String occupation in _occupationList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: occupation, child: Text(occupation)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsReligion() {
    List<DropdownMenuItem<String>> items = new List();
    for (String religion in _religionList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: religion, child: Text(religion)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsNationality() {
    List<DropdownMenuItem<String>> items = new List();
    for (String nationality in _nationalityList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: nationality, child: Text(nationality)));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemsCountry() {
    List<DropdownMenuItem<String>> items = new List();
    for (String country in _countryList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: country, child: Text(country)));
    }
    return items;
  }

  String nullValidator(var cell) {
    return cell == null ? "" : cell;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget.birthDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        date = DateFormat("yyyy/MM/dd").format(picked);
        selectedDate = DateFormat("yyyy/MM/dd").parse(date);
      });
    }
  }

  DataTable table() {
    print("=============================================================");
    print(_list);
    return DataTable(
        sortColumnIndex: 0,
        columns: [
          DataColumn(
            label: Text('Name'),
          ),
          DataColumn(
            label: Text('Action'),
          ),
        ],
        rows: _list
            .map(
              (item) => DataRow(cells: [
                DataCell(Text(nullValidator(item))),
                DataCell(
                  RaisedButton(
                      child: Text("Select"),
                      color: Colors.teal,
                      onPressed: () {}),
                ),
              ]),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Continue Patient Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 300.0,
                  child: DropdownButton(
                    value: _currentMaritalStatus,
                    items: _dropDownMenuItemsMaritalStatus,
                    onChanged: changedDropDownItemMaritalStatus,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 300.0,
                  child: DropdownButton(
                    value: _currentEducationLevel,
                    items: _dropDownMenuItemsEducationLevel,
                    onChanged: changedDropDownItemEducationLevel,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 300.0,
                  child: DropdownButton(
                    value: _currentOccupation,
                    items: _dropDownMenuItemsOccupation,
                    onChanged: changedDropDownItemOccupation,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 300.0,
                  child: DropdownButton(
                    value: _currentReligion,
                    items: _dropDownMenuItemsReligion,
                    onChanged: changedDropDownItemReligion,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 300.0,
                  child: DropdownButton(
                    value: _currentNationality,
                    items: _dropDownMenuItemsNationality,
                    onChanged: changedDropDownItemNationality,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 300.0,
                  child: DropdownButton(
                    value: _currentCountry,
                    items: _dropDownMenuItemsCountry,
                    onChanged: changedDropDownItemCountry,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.teal,
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
//                        Person person = Person(
//                            firstName,
//                            lastName,
//                            _currentGender,
//                            selectedDate,
//                            _currentSiGender,
//                            _currentReligion,
//                            _currentOccupation,
//                            _currentMaritalStatus,
//                            _currentEducationLevel,
//                            _currentNationality,
//                            _currentCountry);
//
//                        Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                                builder: (context) => PersonAddress(person)));
                      },
                    ),
                    Row(
                      children: <Widget>[
                        RaisedButton(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Colors.teal,
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Skip",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
//                            if (_formKey.currentState.validate()) {
//                              _formKey.currentState.save();
//                              Person person = Person.basic(
//                                  widget.firstName,
//                                  widget.lastName,
//                                  widget.sex,
//                                  widget.birthDate);
//
//                              addPerson(person);

//                        _personBloc.dispatch(Create(firstName: firstName, lastName: lastName, sex: gender,birthDate: selectedDate));

//
//              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Contact saved')));
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => ListPeople()));
//                            }
                          },
                        ),
                      ],
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
  
  Future<void> _retrieveMetaDataFromDB() async{
    String result;
    try{
      result= await dataChannel.invokeMethod('metaData');
      
      print('result  $result');
    }
    catch(e){
      print('something went wrong $e');
    }
  }

//  _handleAdd(String dataType) async {
//    confirmDialog(context).then((bool value) async {});
//  }

//  Future<void> addPerson(Person person) async {
//    print("==============================================");
//
//    try {
//      await platform.invokeMethod('savePerson', jsonEncode(person));
//    } on PlatformException catch (e) {
//      print("failed to save : '${e.message}'");
//    }
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => PeopleTable()));
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
    });
  }

  void changedDropDownItemMaritalStatus(String selectedMaritalStatus) {
    setState(() {
      _currentMaritalStatus = selectedMaritalStatus;
    });
  }

  void changedDropDownItemEducationLevel(String selectedEducationLevel) {
    setState(() {
      _currentEducationLevel = selectedEducationLevel;
    });
  }

  void changedDropDownItemOccupation(String selectedOccupation) {
    setState(() {
      _currentOccupation = selectedOccupation;
    });
  }

  void changedDropDownItemReligion(String selectedReligion) {
    setState(() {
      _currentReligion = selectedReligion;
    });
  }

  void changedDropDownItemNationality(String selectedNationality) {
    setState(() {
      _currentNationality = selectedNationality;
    });
  }

  void changedDropDownItemCountry(String selectedCountry) {
    setState(() {
      _currentCountry = selectedCountry;
    });
  }
}
