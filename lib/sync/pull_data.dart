//[ehr_url, token.id_token]
//http://192.168.88.145:8080/api/graphql



import 'package:ehr_mobile/db/dao/person_dao.dart';
import 'package:ehr_mobile/db/db_helper.dart';

import 'package:http/http.dart' as http;
syncPatient(String ehr_url, String token) async {

//  http.post('$ehr_url',headers: {'Authorization': 'Bearer $token', 'Content-Type':'application/json'},body: json.encode(dto)).then((value){
//    log.i(value.statusCode);
//    log.i(json.decode(value.body));
//  }).catchError((error){
//    log.i(error);
//  });
//  var dbHandler=DatabaseHelper();
//  var adapter = await dbHandler.getAdapter();
//  var personDao=PersonDao(adapter);
}