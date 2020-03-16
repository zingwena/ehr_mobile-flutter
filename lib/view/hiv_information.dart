import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indexcontact.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/age.dart';
import 'package:ehr_mobile/preferences/stored_preferences.dart';
import 'package:ehr_mobile/util/constants.dart';
import 'package:ehr_mobile/login_screen.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:flutter/material.dart';
import 'package:ehr_mobile/view/rounded_button.dart';
/*import 'package:ehr_mobile/view/link_bar.dart';*/
import 'package:ehr_mobile/view/hiv_screening.dart';
import 'package:ehr_mobile/view/edit_demographics.dart';
import 'package:ehr_mobile/view/disclosure_and_partner_testing_info.dart';
import 'package:ehr_mobile/view/home_page.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../sidebar.dart';


class HivInformation extends StatefulWidget {
  String indexId;
  Person person;
  Person person_contact;
  String personId;
  String visitId;
  String htsId;
  HtsRegistration htsRegistration;
  HivInformation( this.person_contact, this.indexId, this.person, this.personId, this.visitId, this.htsRegistration, this.htsId);

  @override
  State createState() {
    return _HivInformation();
  }
}

class _HivInformation extends State<HivInformation> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  String lastName, firstName;
  var selectedDate;
  static const dataChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/dataChannel');
  DateTime date;
  int _options = 0;
  int _relation = 0;
  String relations = "";
  String options = "";
  int _option = 0;
  String option = "";
  int _result = 0;
  String result = "";
  List _relations = [
    "CHILD",
    "SPOUSE",
    "SEXUAL_PARTNER",
    "PARENT",
    "OTHER",
  ];
  String _currentRelation;
  List<DropdownMenuItem<String>>_dropDownMenuItemsRelations;
  bool tested_for_hiv = false;
  Age age;
  var facility_name;

  List<DropdownMenuItem<String>> getDropDownMenuItemsIdentifiedRelations() {
    List<DropdownMenuItem<String>> items = new List();
    for (String relation in _relations) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: relation, child: Text(relation)));
    }
    return items;
  }
  void changedDropDownItemDisclosurePlanStatus(String selectedDisclosurePlanStatus) {
    setState(() {
      _currentRelation = selectedDisclosurePlanStatus;
    });
  }
  @override
  void initState() {
    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
    _dropDownMenuItemsRelations = getDropDownMenuItemsIdentifiedRelations();
    getFacilityName();
    getAge(widget.person);
    print('KKKKKKKKKKK here is the person to be added'+ widget.person.toString()+ "RRRRRRR Here is the person contact"+ widget.person_contact.toString());
    super.initState();
  }

  void _handleOptionsChange(int value) {
    setState(() {
      _options = value;

      switch (_options) {
        case 1:
          options = "Yes";
          tested_for_hiv = true;
          break;
        case 2:
          options = "No";
          tested_for_hiv = false;
          break;
        case 3:
          options = "Not Known";
          tested_for_hiv = false;
          break;
      }
    });
  }

  void _handleResultChange(int value) {
    setState(() {
      _result = value;

      switch (_result) {
        case 1:
          result = "POSITIVE";
          break;
        case 2:
          result = "NEGATIVE";
          break;
        case 3:
          result = "NOT KNOWN";
          break;
      }
    });
  }
  void _handleRelationChange(int value) {
    setState(() {
      _relation = value;

      switch (_relation) {
        case 1:
          relations = "CHILD";
          break;
        case 2:
          relations = "PARENT";
          break;
        case 3:
          relations = "SPOUSE";
          break;
        case 4:
          relations = "SIBLING";
          break;
        case 5:
          relations = "SEXUAL_PARTNER";
          break;
      }
    });
  }

  void _handleOptionChange(int value) {
    setState(() {
      _option = value;

      switch (_options) {
        case 1:
          option = "Positive";
          break;
        case 2:
          option = "Negative";
          break;
        case 3:
          option = "Not Known";
          break;
      }
    });
  }
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950, 8),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(widget.person, widget.personId, widget.visitId, widget.htsRegistration, widget.htsId),
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
            title:new Text(
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
                    child: Text("HIV Information", style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16.0,color: Colors.white ),),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          ])),

                  //    _buildButtonsRow(),
                  Expanded(
                    child: WillPopScope(
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
                                            child:
                                            Column(
                                              children: <Widget>[
                                                Form(
                                                  key: _formKey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 60),
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
                                                              isExpanded:true,
                                                              icon: Icon(Icons.keyboard_arrow_down),
                                                              iconEnabledColor: Colors.black,

                                                              hint: Text('Select Relation'),
                                                              value: _currentRelation,
                                                              items: _dropDownMenuItemsRelations,
                                                              onChanged: changedDropDownItemDisclosurePlanStatus,
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
                                                        height: 20.0,
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 0.0),
                                                                  child: Text('Tested For HIV'),
                                                                ),
                                                                width: 100,
                                                              ),
                                                            ),
                                                            Text('Yes'),
                                                            Radio(
                                                                value: 1,
                                                                groupValue: _options,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleOptionsChange),
                                                            Text('No'),
                                                            Radio(
                                                                value: 2,
                                                                groupValue: _options,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleOptionsChange),
                                                            Text('Not Known'),
                                                            Radio(
                                                                value: 3,
                                                                groupValue: _options,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleOptionsChange)
                                                          ],
                                                        ),
                                                      ),

                                                      tested_for_hiv ?Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical: 0.0, horizontal: 0.0),
                                                                  child: TextFormField(
                                                                    controller: TextEditingController(
                                                                        text: selectedDate),
                                                                    validator: (value) {
                                                                      return value.isEmpty
                                                                          ? 'Enter some text'
                                                                          : null;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        suffixIcon: IconButton(
                                                                            icon: Icon(Icons.calendar_today), color: Colors.blue,
                                                                            onPressed: () {_selectDate(context);}),
                                                                        labelText: 'Last Date Tested For HIV',
                                                                        border: OutlineInputBorder()),
                                                                  ),
                                                                ),
                                                                width: 60,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ): SizedBox(height: 0.0,),

                                                      tested_for_hiv ?Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: SizedBox(
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 0.0),
                                                                  child: Text('HIV Result'),
                                                                ),
                                                                width: 100,
                                                              ),
                                                            ),
                                                            Text('Positive'),
                                                            Radio(
                                                                value: 1,
                                                                groupValue: _result,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleResultChange),
                                                            Text('Negative'),
                                                            Radio(
                                                                value: 2,
                                                                groupValue: _result,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleResultChange),
                                                            Text('Not Known'),
                                                            Radio(
                                                                value: 3,
                                                                groupValue: _result,
                                                                activeColor: Colors.blue,
                                                                onChanged: _handleResultChange)
                                                          ],
                                                        ),
                                                      ): SizedBox(height: 0.0,),

                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric( vertical: 16.0, horizontal: 60.0),
                                                              child: RaisedButton(
                                                                elevation: 4.0,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(5.0)),
                                                                color: Colors.blue,
                                                                padding: const EdgeInsets.all(20.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Text('Proceed to Disclosure & Partner Testing Information', style: TextStyle(color: Colors.white),),
                                                                      Spacer(),
                                                                      Icon(Icons.navigate_next, color: Colors.white, ),
                                                                    ],
                                                                  ),
                                                                  //onPressed: () {}
                                                                  onPressed: () {
                                                                IndexContact indexcontact = new IndexContact('', widget.indexId, widget.person_contact.id, _currentRelation, result, date, null, null, null, null, null);
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(builder: (context) => PatientIndexHivInfo(widget.person_contact,indexcontact, widget.personId, widget.person, widget.visitId, widget.htsRegistration, widget.htsId)),);

                                                                }
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15.0,
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigation(),
    );
  }

}
