import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../login_screen.dart';


class HtsTesting extends StatefulWidget {
  HtsTesting({Key key, this.title}) : super(key: key);

  final String title;
  var selectedDate;

  @override
  _HtsTestingState createState() => _HtsTestingState();
}



class _HtsTestingState extends State<HtsTesting> {

  String sample;
  String test;
  String Status;
  String testDate;
  List<DropdownMenuItem<String>> _sampleDropdownMenuItem;
  String _currentSample;
    static const htsChannel = MethodChannel('zw.gov.mohcc.mrs.ehr_mobile/htsChannel');

  List _sampleList = [
    "Blood",
    "Oral Fluid",
  ];

  List<DropdownMenuItem<String>> getIdentifierDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String sample in _sampleList) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(DropdownMenuItem(value: sample, child: Text(sample)));
    }
    return items;
  }



  @override
  void initState() {
   _currentSample = _sampleList[0].value;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
      //  backgroundColor: Colors.blue,
      //  title: Text('Reception Vitals'),
      //  ),
      backgroundColor: Colors.blue.shade200,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 380,
                        child: Card(
                          margin: new EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 50.0, bottom: 5.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          elevation: 0.0,
                          child: new Padding(
                            padding: new EdgeInsets.all(25.0),
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  child: new Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: double.infinity,
                                              padding:
                                              EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
                                              child: DropdownButton(
                                                icon: Icon(Icons.keyboard_arrow_down),
                                                iconEnabledColor: Colors.black,
                                                value: _currentSample,
                                                items: _sampleDropdownMenuItem,
                                                onChanged: changedDropDownItemSamples
                                              ),
                                            ),
                                          ),
                                          width: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: TextEditingController(
                                                  text: 'HIV'),
                                              decoration: InputDecoration(
                                                labelText: 'Test',
                                                border: OutlineInputBorder(),
                                              ),
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          width: 20,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                new Container(
                                  child: new Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              controller: TextEditingController(
                                                  text: 'Pending'),
                                              decoration: InputDecoration(
                                                labelText: 'Status',
                                                hintText: '',
                                                border: OutlineInputBorder(),
                                              ),
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          width: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextFormField(


                                              validator: (value) {
                                                return value.isEmpty
                                                    ? 'Enter some text'
                                                    : null;
                                              },
                                              decoration: InputDecoration(
                                                  labelText: 'HIV Test Date',
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

                                          }),

                                    ],
                                  ),
                                ),


                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: RaisedButton(
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(5.0)),
                                            color: Colors.blue,
                                            padding: const EdgeInsets.all(20.0),
                                            child: Text(
                                              "Add Test",
                                              style: TextStyle(

                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
//                                            onPressed: () => Navigator.push(
//                                              context,
//                                              MaterialPageRoute(
//                                                  builder: (context) =>
//                                                      HtsScreeningTest()),
//                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void changedDropDownItemSamples(String selectedSample) {
    setState(() {
      _currentSample = selectedSample;
    });
  }
}
