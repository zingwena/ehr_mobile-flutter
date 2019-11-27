
import 'package:ehr_mobile/model/department.dart';
import 'package:ehr_mobile/model/facility.dart';
import 'package:ehr_mobile/model/queue.dart';
import 'package:ehr_mobile/model/result.dart';
import 'package:ehr_mobile/model/testKit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'patient_queue.g.dart';
@JsonSerializable()
class PatientQueue{
  Queue queue;
  String visitId;
  PatientQueue(Queue queue, String visitId){
    this.queue = queue;
    this.visitId = visitId;
  }

  factory PatientQueue.fromJson(Map<String, dynamic> json) => _$PatientQueueFromJson(json);


  Map<String, dynamic> toJson() => _$PatientQueueToJson(this);

  static mapFromJson(List dynamicList){
    List<PatientQueue> patientquequeList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        PatientQueue patientQueue= PatientQueue.fromJson(e);
        patientquequeList.add(patientQueue);
      });
    }
    return patientquequeList;
  }



  @override
  String toString() {
    return 'PatientQueue{queue: $queue, visitId: $visitId}';
  }

  List<PatientQueue> fromJsonDecodedMap(List dynamicList) {
    List<PatientQueue> patientqueueList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        PatientQueue patientQueue = PatientQueue.fromJson(e);
        patientqueueList.add(patientQueue);
      });
    }
    return patientqueueList;
  }


}