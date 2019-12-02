import 'package:ehr_mobile/model/response.dart';
part 'sexualhistorydto.g.dart';

class SexualHistoryDto{
  String personId;
  String sexualHistoryId;
  Response question;

  SexualHistoryDto(String personId,String sexualHistoryId, Response question){
    this.personId = personId;
    this.sexualHistoryId = sexualHistoryId;
    this.question = question;
  }

  factory SexualHistoryDto.fromJson(Map<String, dynamic> json) =>_$SexualHistoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SexualHistoryDtoToJson(this);

  static List<SexualHistoryDto> mapFromJson(List dynamicList){
    List<SexualHistoryDto> list=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        SexualHistoryDto sexualHistoryDto=  SexualHistoryDto.fromJson(e);
        list.add(sexualHistoryDto);
      });
    }
    return list;
  }
  static List<SexualHistoryDto> fromJsonDecodedMap(List dynamicList) {
    List<SexualHistoryDto> sexualHistoryList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        SexualHistoryDto sexualHistoryDto = SexualHistoryDto.fromJson(e);
        sexualHistoryList.add(sexualHistoryDto);
      });
    }
  }
}








/*
private String personId;
@NonNull
private String sexualHistoryId;
@NonNull
NameCodeResponse question;*/
