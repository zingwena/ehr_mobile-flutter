
import 'base_table.dart';

class PhoneNumberTable extends BaseTable{

  String personId;
  String phoneNumber1;
  String phoneNumber2;

  static PhoneNumberTable fromJson(Map map) {
    var phone = PhoneNumberTable();
    phone.id = map['id'];
    phone.personId = map['personId'];
    phone.phoneNumber1 = map['phoneNumber1'];
    phone.phoneNumber2 = map['phoneNumber2'];
    phone.status = map['status'];
    return phone;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'personId': personId,
    'phoneNumber1': phoneNumber1,
    'phoneNumber2': phoneNumber2,
    'status': status,
  };

}