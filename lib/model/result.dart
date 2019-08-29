import 'package:json_annotation/json_annotation.dart';
part 'result.g.dart';
@JsonSerializable()
class Result{
    int id;
    String code ;
    String name ;

   Result(this.code, this.name);

   factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

   Map<String, dynamic> toJson() => _$ResultToJson(this);


    @override
    String toString() {
       return 'Result{code: $code, name: $name}';
    }

    List<Result> fromJsonDecodedMap(List dynamicList) {
      List<Result> resultList = [];

      if (dynamicList != null) {
         dynamicList.forEach((e) {
            Result labInvestTest = Result.fromJson(e);
            resultList.add(labInvestTest);
         });
      }


      return resultList;
   }
}