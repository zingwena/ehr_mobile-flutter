import 'package:ehr_mobile/model/queue.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ehr_mobile/model/base_code.dart';
part 'patient_admission.g.dart';
@JsonSerializable()
class PatientAdmission  extends BaseCode {
  String personId;
  Queue queue;

  PatientAdmission(String personId, Queue queue) {
    this.queue = queue;
    this.personId = personId;
  }

  factory PatientAdmission.fromJson(Map<String, dynamic> json) =>
      _$PatientAdmissionFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAdmissionToJson(this);

  static List<Queue> mapFromJson(List dynamicList) {
    List<Queue> list = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Queue queue = Queue.fromJson(e);
        list.add(queue);
      });
    }
    return list;
  }

  static List<Queue> fromJsonDecodedMap(List dynamicList) {
    List<Queue> queueList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        Queue queue = Queue.fromJson(e);
        queueList.add(queue);
      });
    }
  }
}
