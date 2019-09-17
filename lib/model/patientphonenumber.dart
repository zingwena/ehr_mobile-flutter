import 'package:json_annotation/json_annotation.dart';
part 'patientphonenumber.g.dart';
@JsonSerializable()
class PatientPhoneNumber{

  int id;
  int patientId;
  String phonenumber_1;
  String phonenumber_2;



  PatientPhoneNumber( int patientId, String phonenumber_1, String phonenumber_2){

   this.patientId =patientId;
   this.phonenumber_1 = phonenumber_1;
   this.phonenumber_2 = phonenumber_2;
  }



  factory PatientPhoneNumber.fromJson(Map<String, dynamic> json) =>_$PatientPhoneNumberFromJson(json);


 Map<String, dynamic> toJson() => _$PatientPhoneNumberToJson(this);



  @override
  String toString() {
    return 'PatientPhoneNumber{id: $id, personId: $patientId, phonenumber_1: $phonenumber_1, phonenumber_2: $phonenumber_2}';
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
