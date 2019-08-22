import 'package:json_annotation/json_annotation.dart';
part 'visit.g.dart';

@JsonSerializable()
class Visit {
int visitId;
int patientId;

Visit();

factory Visit.fromJson(Map<String,dynamic> json) => _$VisitFromJson(json);

Map<String,dynamic> toJson() => _$VisitToJson(this);


}
