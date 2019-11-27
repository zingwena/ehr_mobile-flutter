

import 'dart:convert';

import 'package:ehr_mobile/db/dao/person_dao.dart';
import 'package:ehr_mobile/db/db_helper.dart';
import 'package:ehr_mobile/model/dto/patient_dto.dart';
import 'package:ehr_mobile/model/person.dart';

import 'package:http/http.dart' as http;

syncPatient(String token, String url) async {
  var dbHandler=DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var personDao=PersonDao(adapter);
  List<Person> persons = await personDao.findAll();
  for(Person person in persons){
    var dto=PatientDto();
    dto.personDto=person;
    if(person.status=='0'){
      http.post('$url/data-sync/patient',headers: {'Authorization': 'Bearer $token', 'Content-Type':'application/json'},body: json.encode(dto)).then((value){
        personDao.setSyncd(person.id);
        print(jsonDecode(value.body));
      });
    }
    print(person);
  }
  //adapter.close();
}