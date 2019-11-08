import 'dart:convert';

import 'package:ehr_mobile/model/htsRegistration.dart';
import 'package:ehr_mobile/model/indextest.dart';
import 'package:ehr_mobile/model/postTest.dart';
import 'package:ehr_mobile/model/person.dart';
import 'package:ehr_mobile/model/reasonForNotIssuingResult.dart';
import 'package:ehr_mobile/view/posttest_overview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:ehr_mobile/view/art_reg.dart';
import 'package:ehr_mobile/view/search_patient.dart';
import 'package:ehr_mobile/view/reception_vitals.dart';
import 'package:ehr_mobile/view/patient_overview.dart';
import 'package:ehr_mobile/view/htsreg_overview.dart';
import 'package:ehr_mobile/view/hts_registration.dart';
class PatientPostTest extends StatefulWidget {
  String result;
  String patientId;
  String visitId;
  Person person;
  String htsId;
  PatientPostTest(this.result, this.patientId, this.visitId,  this.person, this.htsId);
  @override
  State createState() {
    return _PatientPostTest();
  }
}

class _PatientPostTest extends State<PatientPostTest> {
  static const platform = MethodChannel('example.channel.dev/people');
  static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');
  final _formKey = GlobalKey<FormState>();
  var selectedDate;
  DateTime date;
  List<ReasonForNotIssuingResult> _reasonForNotIssuingResultList=List();
  bool _resultReceived=false;
  String resultReceived="NO";
  bool _postTestCounselled = false;
  String postTestCounselled = "NO";
  bool _consenttoindex = false;
  String consenttoindex = "NO";
  HtsRegistration htsRegistration;

  @override
  void initState() {

    selectedDate = DateFormat("yyyy/MM/dd").format(DateTime.now());
    date = DateTime.now();
  getHtsRecord(widget.patientId);

  print('reasonForNotIssuingResultList${_reasonForNotIssuingResultList.length}');



    super.initState();

  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),

        firstDate: DateTime(1900, 8),

        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat("yyyy/MM/dd").format(picked);
      });
  }

  Future<void> insertPostTest(PostTest postTest) async {


    try {

          await htsChannel.invokeMethod('savePostTest',  jsonEncode(postTest));
    } catch (e) {
      print("channel failure: '$e'");
    }


  }
  Future<void> getHtsRecord(String patientId) async {
    var  hts;
    try {
      hts = await htsChannel.invokeMethod('getcurrenthts', patientId);
      print('HTS IN THE FLUTTER THE RETURNED ONE '+ hts);
    } catch (e) {
      print("channel failure: '$e'");
    }
    setState(() {

      htsRegistration = HtsRegistration.fromJson(jsonDecode(hts));
      print("HERE IS THE HTS AFTER ASSIGNMENT " + htsRegistration.toString());

    });


  }

  List<DropdownMenuItem<String>>
  getDropDownMenuItemsReasonForNotIssuingResult() {
    List<DropdownMenuItem<String>> items = new List();
    for (ReasonForNotIssuingResult reasonForNotIssuingResult in _reasonForNotIssuingResultList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: reasonForNotIssuingResult.code, child: Text(reasonForNotIssuingResult.name)));
    }
    return items;
  }

 /* List<DropdownMenuItem<String>>
  getDropDownMenuItemsPurposeOfTest() {
    List<DropdownMenuItem<String>> items = new List();
    for (PurposeOfTest purposeOfTest in _purposeOfTestList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(
          DropdownMenuItem(value: purposeOfTest.id.toString(), child: Text(purposeOfTest.name)));
    }
    return items;
  }*/




  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: new Column(children: <Widget>[
            new Text("Post Test"),
            new Text("Patient Name : " + " "+ widget.person.firstName + " " + widget.person.lastName)

          ],)
      ),
      drawer:  new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(accountName: new Text("admin"), accountEmail: new Text("admin@gmail.com"), currentAccountPicture: new CircleAvatar(backgroundImage: new AssetImage('images/mhc.png'))),
            new ListTile(leading: new Icon(Icons.home, color: Colors.blue),title: new Text("Home "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchPatient()),
            )),
            new ListTile(leading: new Icon(Icons.person, color: Colors.blue),title: new Text("Patient Overview "), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Overview(widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue),title: new Text("Reception Vitals"), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReceptionVitals(widget.patientId, widget.visitId, widget.person)),
            )),
            new ListTile(leading: new Icon(Icons.book, color: Colors.blue), title: new Text("HTS"), onTap: () {
              if(htsRegistration == null ){
                print('bbbbbbbbbbbbbb htsreg null in side bar  ');
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>  Registration(widget.visitId, widget.patientId, widget.person)
                ));
              } else {
                print('bbbbbbbbbbbbbb htsreg  not null in side bar ');

                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=> HtsRegOverview(htsRegistration, widget.patientId, widget.htsId, widget.visitId, widget.person)
                ));
              }
            }),
            new ListTile(title: new Text("ART"), onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArtReg(widget.patientId, widget.visitId, widget.person)),
            ))

          ],
        ),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Results Recieved"),
                      Checkbox(
                        value:_resultReceived,
                        onChanged: (bool value) {
                          setState(() {
                            _resultReceived=value;
                          });
                          if(value) {
                            setState(() {
                              resultReceived="YES";
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Post Test Counselled"),
                      Checkbox(
                        value:_postTestCounselled,
                        onChanged: (bool value) {
                          setState(() {
                            _postTestCounselled=value;
                          });
                          if(value) {
                            setState(() {
                              postTestCounselled="YES";
                            });
                          }
                        },
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: TextFormField(
                              controller:

                              TextEditingController(text: selectedDate),

                              validator: (value) {
                                return value.isEmpty ? 'Enter some text' : null;
                              },
                              decoration: InputDecoration(
                                  labelText: 'Date Post Test Counselled',
                                  border: OutlineInputBorder()),

                            ),
                          ),
                          width: 100,
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
                    height: 10.0,
                  ),
                  getIndexQuestion(),
                  SizedBox(
                    height: 20.0,
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
                        "Proceed",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        PostTest postTest = new PostTest(widget.htsId, date, true, null, widget.result, false);
                        insertPostTest(postTest);
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context)=> PostTestOverview(postTest, widget.patientId, widget.visitId, widget.person, widget.htsId, _consenttoindex, widget.result)
                        ));
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
    );

  }

  Widget getIndexQuestion(){
    if(widget.result == 'POSITIVE' || widget.result == 'Positive' || widget.result == 'positive'){
      return  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("Consent to Index testing"),
          Checkbox(
            value:_consenttoindex,
            onChanged: (bool value) {
              setState(() {
                _consenttoindex=value;
              });
              if(value) {
                setState(() {
                  consenttoindex="YES";
                });
              }
            },
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 10.0,
      );
    }

  }

}
