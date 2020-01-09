import 'package:json_annotation/json_annotation.dart';
part 'bintype_id_name.g.dart';
@JsonSerializable(explicitToJson: true)

class BinTypeIdName {

  String binType;
  String name;
  String id;

  BinTypeIdName(this.binType, this.name, this.id);

  factory BinTypeIdName.fromJson(Map<String, dynamic> json) => _$BinTypeIdNameFromJson(json);


  Map<String, dynamic> toJson() => _$BinTypeIdNameToJson(this);

  static mapFromJson(List dynamicList){
    List<BinTypeIdName> bintypidnameList=[];
    if(dynamicList!=null){
      dynamicList.forEach((e){
        BinTypeIdName binTypeIdName= BinTypeIdName.fromJson(e);
        bintypidnameList.add(binTypeIdName);
      });
    }
    return bintypidnameList;
  }



  @override
  String toString() {
    return 'BinTypeIdName{binType: $binType, name: $name, id: $id}';
  }

  List<BinTypeIdName> fromJsonDecodedMap(List dynamicList) {
    List<BinTypeIdName> binTypeList = [];

    if (dynamicList != null) {
      dynamicList.forEach((e) {
        BinTypeIdName binTypeIdName = BinTypeIdName.fromJson(e);
        binTypeList.add(binTypeIdName);
      });
    }
    return binTypeList;
  }




}