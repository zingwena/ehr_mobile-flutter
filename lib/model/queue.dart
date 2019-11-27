import 'package:json_annotation/json_annotation.dart';
import 'package:ehr_mobile/model/base_code.dart';
part 'queue.g.dart';

@JsonSerializable()
class Queue  extends BaseCode{

  Queue(String code , String name){
    this.code = code;
    this.name = name;
  }
  factory Queue.fromJson(Map<String, dynamic> json) =>_$QueueFromJson(json);

  Map<String, dynamic> toJson() => _$QueueToJson(this);

  static List<Queue> mapFromJson(List dynamicList){
    List<Queue> list=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        Queue queue=  Queue.fromJson(e);
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