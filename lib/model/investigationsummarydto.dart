import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'investigationsummarydto.g.dart';
class InvestigationSummaryDto{
  String testName;
  DateTime testDate;
  String result;

  InvestigationSummaryDto(String testName, DateTime testDate, String result){
    this.testName = testName;
    this.testDate = testDate;
    this.result = result;
  }

  factory InvestigationSummaryDto.fromJson(Map<String, dynamic> json) =>_$InvestigationSummaryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InvestigationSummaryDtoToJson(this);

  static String listToJson(List<InvestigationSummaryDto> investigations) {
    List<Map<String, String>> x = investigations
        .map((f) =>
    {'testName': f.testName, 'testDate': f.testDate.toIso8601String(), 'result': f.result})
        .toList();

    Map<String, dynamic> map() => {'investigations': x};
    String result = jsonEncode(map());
    return result;
  }
  static List<InvestigationSummaryDto> mapFromJson(List dynamicList){
    List<InvestigationSummaryDto> list=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        InvestigationSummaryDto investigationSummaryDto=  InvestigationSummaryDto.fromJson(e);
        list.add(investigationSummaryDto);
      });
    }
    return list;
  }
  static List<InvestigationSummaryDto> fromJsonDecodedMap(List dynamicList) {
    List<InvestigationSummaryDto> valueDateList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        InvestigationSummaryDto investigationSummaryDto = InvestigationSummaryDto.fromJson(e);
        valueDateList.add(investigationSummaryDto);
      });
    }
  }
}