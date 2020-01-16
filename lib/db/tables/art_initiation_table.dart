
import 'package:json_annotation/json_annotation.dart';
import 'base_table.dart';
@JsonSerializable(explicitToJson: true)


class ArtInitiationTable extends BaseTable{

  String personId;
  String artRegimenId;
  String artReasonId;

  static ArtInitiationTable fromJson(Map map) {
    var art = ArtInitiationTable();

    art.id=map['id'];
    art.status=map['status'];

    art.personId = map['personId'];
    art.artRegimenId = map['artRegimenId'];
    art.artReasonId = map['artReasonId'];

    return art;
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'status':status,
    'personId':personId,

    'artRegimenId':artRegimenId,
    'artReasonId':artReasonId
  };
}
