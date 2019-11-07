import 'package:json_annotation/json_annotation.dart';
part 'disclosuremethod.g.dart';

@JsonSerializable()
class DisclosureMethod{
   String id;
   String name;
   DisclosureMethod(this.id, this.name);

   factory DisclosureMethod.fromJson(Map<String, dynamic> json) =>_$DisclosureMethodFromJson(json);

   Map<String, dynamic> toJson() => _$DisclosureMethodToJson(this);

   static List<DisclosureMethod> mapFromJson(List dynamicList){
     List<DisclosureMethod> disclosureMethodList=[];
     if(dynamicList!=null){
       dynamicList.forEach((e){
         DisclosureMethod disclosureMethod=  DisclosureMethod.fromJson(e);
         disclosureMethodList.add(disclosureMethod);
       });
     }
     return disclosureMethodList;
   }
}