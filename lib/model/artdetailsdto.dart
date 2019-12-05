import 'package:json_annotation/json_annotation.dart';
part 'artdetailsdto.g.dart';
@JsonSerializable()
class ArtDetailsDto{
    DateTime dateRegistered;
    String artNumber;
    String whoStage;
    String arvRegimen;

    ArtDetailsDto(DateTime dateRegistered, String artNUmber, String whoStage, String arvRegimen){
      this.dateRegistered = dateRegistered;
      this.artNumber = artNUmber;
      this.whoStage = whoStage;
      this.arvRegimen = arvRegimen;
    }

    factory ArtDetailsDto.fromJson(Map<String, dynamic> json) =>_$ArtDetailsDtoFromJson(json);

    Map<String, dynamic> toJson() => _$ArtDetailsToJson(this);

    static List<ArtDetailsDto> mapFromJson(List dynamicList){
      List<ArtDetailsDto> list=[];
      if(dynamicList!=null){
        dynamicList.forEach((e){
          ArtDetailsDto artDetailsDto=  ArtDetailsDto.fromJson(e);
          list.add(artDetailsDto);
        });
      }
      return list;
    }
    static List<ArtDetailsDto> fromJsonDecodedMap(List dynamicList) {
      List<ArtDetailsDto> artdetailsList = [];

      if (dynamicList != null) {
        dynamicList.forEach((e) {
          ArtDetailsDto artDetailsDto = ArtDetailsDto.fromJson(e);
          artdetailsList.add(artDetailsDto);
        });
      }
    }

}