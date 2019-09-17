import 'package:json_annotation/json_annotation.dart';
part 'patientphonenumber.g.dart';
@JsonSerializable()
class PatientPhoneNumber{

  String id;
  String personId;
  String phoneNumber1;
  String phoneNumber2;



  PatientPhoneNumber(String personId, String phoneNumber1, String phoneNumber2){

   this.personId = personId;
   this.phoneNumber1 = phoneNumber1;
   this.phoneNumber2 = phoneNumber2;
  }



  factory PatientPhoneNumber.fromJson(Map<String, dynamic> json) =>_$PatientPhoneNumberFromJson(json);


 Map<String, dynamic> toJson() => _$PatientPhoneNumberToJson(this);



  @override
  String toString() {
    return 'PatientPhoneNumber{id: $id, personId: $personId, phonenumber_1: $phoneNumber1, phonenumber_2: $phoneNumber2}';
  }

  static List<PatientPhoneNumber> fromJsonDecodedMap(List dynamicList) {
    List<PatientPhoneNumber> PatientPhoneNumberList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        PatientPhoneNumber patientPhoneNumber = PatientPhoneNumber.fromJson(e);
        PatientPhoneNumberList.add(patientPhoneNumber);

      });
    }


    return PatientPhoneNumberList;
  }

}
