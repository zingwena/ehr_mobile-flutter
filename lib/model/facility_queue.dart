
import 'package:ehr_mobile/model/department.dart';
import 'package:ehr_mobile/model/facility.dart';
import 'package:ehr_mobile/model/queue.dart';
import 'package:ehr_mobile/model/result.dart';
import 'package:ehr_mobile/model/testKit.dart';
import 'package:json_annotation/json_annotation.dart';
part 'facility_queue.g.dart';
@JsonSerializable()
class FacilityQueue{
  Queue queue;
  Facility facility;
  Department department;
  int beds;
  FacilityQueue(Queue queue, Facility facility, Department department, int beds){
    this.queue = queue;
    this.facility = facility;
    this.department = department;
    this.beds = beds;
  }

  factory FacilityQueue.fromJson(Map<String, dynamic> json) => _$FacilityQueueFromJson(json);


  Map<String, dynamic> toJson() => _$LaboratoryInvestigationTestToJson(this);

  static mapFromJson(List dynamicList){
    List<FacilityQueue> facilityquequeList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        FacilityQueue facilityQueue= FacilityQueue.fromJson(e);
        facilityquequeList.add(facilityQueue);
      });
    }
    return facilityquequeList;
  }



  @override
  String toString() {
    return 'FacilityQueue{queue: $queue, facility: $facility, department: $department, beds: $beds}';
  }

  List<FacilityQueue> fromJsonDecodedMap(List dynamicList) {
    List<FacilityQueue> facilityqueueList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        FacilityQueue facilityQueue = FacilityQueue.fromJson(e);
        facilityqueueList.add(facilityQueue);
      });
    }
    return facilityqueueList;
  }


}