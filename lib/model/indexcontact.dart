import 'package:json_annotation/json_annotation.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';

part 'indexcontact.g.dart';
@JsonSerializable()
@CustomDateTimeConverter()
class IndexContact{
  String indexTestId;
  String personId;
  String relation;
  String hivStatus;
  DateTime dateOfHivStatus;
  bool  fearOfIpv;
  String disclosureMethodPlanId;
  String testingPlanId;
  bool  disclosureStatus;
  String disclosureMethodId;

  IndexContact(String indexTestId, String personId, String relation, String hivStatus, DateTime dateofHivstatus,
      bool fearOfIpv, String disclosureMethodPlanId, String testingPlanId, bool disclosureStatus, String disclosureMethodId){
    this.indexTestId = indexTestId;
    this.personId = personId;
    this.relation = relation;
    this.hivStatus = hivStatus;
    this.dateOfHivStatus = dateofHivstatus;
    this.fearOfIpv = fearOfIpv;
    this.disclosureMethodPlanId = disclosureMethodPlanId;
    this.testingPlanId = testingPlanId;
    this.disclosureStatus = disclosureStatus;
    this.disclosureMethodId = disclosureMethodId;
  }

  factory IndexContact.fromJson(Map<String, dynamic> json) => _$IndexContactFromJson(json);

  Map<String, dynamic> toJson() => _$IndexContactToJson(this);

  static mapFromJson(List dynamicList) {
    List<IndexContact> indexcontactList = [];
    if (dynamicList != null) {
      dynamicList.forEach((e) {
        IndexContact indexContact = IndexContact.fromJson(e);
        indexcontactList.add(indexContact);
      });
    }
    return indexcontactList;
  }

  @override
  String toString() {
    return 'IndexContact{indexTestId: $indexTestId, personId: $personId, '
        'relation: $relation, hivStatus: $hivStatus,dateOfHivStatus: $dateOfHivStatus,'
        'fearOfIpv:$fearOfIpv,disclosureMethodPlanId:$disclosureMethodPlanId,'
        'testingPlanId:$testingPlanId,disclosureStatus:$disclosureStatus,disclosureMethodId:$disclosureMethodId}';
  }



}

