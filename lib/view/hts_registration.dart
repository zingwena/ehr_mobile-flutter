import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'edit_demographics.dart';

class Registration extends StatefulWidget {
  @override
  State createState() {
    return _Registration();
  }
}

class _Registration extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  String lastName, firstName;
  var selectedDate;
  DateTime date;
  int _htsType = 0;
  String htsType = "";
  List<DropdownMenuItem<String>> _identifierDropdownMenuItem;
  List _identifierList = [
    "Select Identifier",
    "Passport",
    "Birth Certificate",
    "National Id",
    "Driver's Licence"
  ];

  @override
  void initState() {
    _dropDownMenuItemsEducationLevel =
        getDropDownMenuItemsIdentifiedEducationLevel();
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    _identifierDropdownMenuItem = getIdentifierDropdownMenuItems();


    _currentEducationLevel = _dropDownMenuItemsEducationLevel[0].value;
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

  void _handleHtsTypeChange(int value) {
    setState(() {
      _htsType = value;

      switch (_htsType) {
        case 1:
          htsType = "Self";
          break;
        case 2:
          htsType = "Rapid";
          break;
      }
    });
  }

  List<DropdownMenuItem<String>> _dropDownMenuItems,
      _dropDownMenuItemsEducationLevel;

  String _currentGender, _currentEducationLevel;

  List<DropdownMenuItem<String>> getIdentifierDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String identifier in _identifierList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: identifier, child: Text(identifier)));
    }
    return items;
  }

  List _educationLevelList = [
    "Default HTS Campaign",
    "Entry Point 1",
    "Entry Point 2",
    "Entry Point 3",
    "Entry Point 4"
  ];

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /* appBar: AppBar(
        title: Text('Patient Registration'),
      ), */
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          })
                    ],
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Text('HTS Type'),
                          ),
                          width: 250,
                        ),
                      ),
                      Text('Self'),
                      Radio(
                          value: 1,
                          groupValue: _htsType,
                          onChanged: _handleHtsTypeChange),
                      Text('Rapid'),
                      Radio(
                          value: 2,
                          groupValue: _htsType,
                          onChanged: _handleHtsTypeChange)
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
//                  Container(
//                    padding:
//                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
//                    width: double.infinity,
//                    child: OutlineButton(
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5.0)),
//                      color: Colors.white,
//                      padding: const EdgeInsets.all(0.0),
//                      child: Container(
//                        width: double.infinity,
//                        padding: EdgeInsets.symmetric(
//                            vertical: 8.0, horizontal: 30.0),
//                        child: DropdownButton(
//                          icon: Icon(Icons.keyboard_arrow_down),
//                          iconEnabledColor: Colors.black,
//                          value: _currentEducationLevel,
//                          items: _dropDownMenuItemsEducationLevel,
//                          onChanged: changedDropDownItemEducationLevel,
//                        ),
//                      ),
//                      borderSide: BorderSide(
//                        color: Colors.blue, //Color of the border
//                        style: BorderStyle.solid, //Style of the border
//                        width: 2.0, //width of the border
//                      ),
//                      onPressed: () {},
//                    ),
//                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.blue,
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "SAVE",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          Navigator.push(
                              context,
                              MaterialPageRoute(

//              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Contact saved')));
                          ));}
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void changedDropDownItemEducationLevel(String selectedEducationLevel) {
    setState(() {
      _currentEducationLevel = selectedEducationLevel;
    });
  }
}
