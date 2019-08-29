import 'dart:convert';

import 'package:ehr_mobile/model/entry_point.dart';
import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';


class Registration extends StatefulWidget {

  int visitId;
  Registration(this.visitId);
  @override
  State createState() {

    return _Registration();
  }
}

class _Registration extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
   static const dataChannel= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
   static const htsChannel= MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  int visitId;
  var selectedDate;
  bool _showError=false;
  bool _entryPointIsValid=false;
  bool _formIsValid=false;
  String _entryPointError="Select Entry Point";
  DateTime date;
  int _htsType = 0;
  String htsType = "";
  String _entryPoint;
  List entryPoints=List();
  List _dropDownListEntryPoints=List();

  List<DropdownMenuItem<String>>
  _dropDownMenuItemsEntryPoint;
  List<EntryPoint> _entryPointList = List();

  String _currentEntryPoint;


  @override
  void initState() {
    visitId=widget.visitId;
  getFacilities();
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    super.initState();
  }

  Future<void> getFacilities() async{
   String response;
   try{
     response= await dataChannel.invokeMethod('getEntryPointsOptions');
     setState(() {
       _entryPoint=response;
       entryPoints=jsonDecode(_entryPoint);
       _dropDownListEntryPoints= EntryPoint.mapFromJson(entryPoints);
       _dropDownListEntryPoints.forEach((e){
         _entryPointList.add(e);
       });
       _dropDownMenuItemsEntryPoint=getDropDownMenuItemsIdentifiedEntryPoint();
     });

   }catch(e){
     print('--------------------Something went wrong  $e');
   }
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
        date=DateFormat("yyyy/MM/dd").parse(selectedDate);
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




  List<DropdownMenuItem<String>>
      getDropDownMenuItemsIdentifiedEntryPoint() {
    List<DropdownMenuItem<String>> items = new List();
    for (EntryPoint entryPoint in _entryPointList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value:entryPoint.code , child: Text(entryPoint.name)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('HTS Registration'),
      ),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30.0),
                        child: DropdownButton(
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
                  !_showError?
                  SizedBox.shrink()
                      : Text(
                    _entryPointError ?? "",
                    style: TextStyle(color: Colors.red),
                  ),
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
                      onPressed: () async{
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (_entryPointIsValid) {
                            setState(() {
                              _formIsValid = true;
                            });
                          }
                          else {
                            setState(() {
                              _showError = true;
                            });
                          }
                          if (_formIsValid) {
                            HtsRegistration htsDetails= HtsRegistration(visitId, htsType, date, _currentEntryPoint);
                           await  registration(htsDetails);
                            Navigator.push(
                                context,
                                MaterialPageRoute(

                                ));
                          }
                        }
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

Future<void> registration(HtsRegistration htsRegistration) async{
    int id;
    try{
      id= await htsChannel.invokeMethod('htsRegistration', jsonEncode(htsRegistration));
      print('---------------------saved file id  $id');
    }
    catch(e){
      print('--------------something went wrong  $e');
    }
}

  void changedDropDownItemEntryPoint(String selectedEntryPoint) {
    setState(() {
      _currentEntryPoint = selectedEntryPoint;
      _entryPointError=null;
      _entryPointIsValid=!_entryPointIsValid;
    });
  }
}
