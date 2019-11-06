import 'package:ehr_mobile/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


storeString(String key,String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

storeInt(String key, int value) async {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<String> retrieveString(String key) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  if(prefs.containsKey(key)){
    return prefs.getString(key);
  }else {
    return EMPTY_STRING;
  }
}