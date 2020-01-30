

class FacilityWardTable{

  String ward_code;
  String ward_name;

  String facility_code;
  String facility_name;

  String department_code;
  String department_name;
  int beds;

  FacilityWardTable fromJson(Map map) {
    var fc = FacilityWardTable();
    fc.ward_code = map['ward_code'];
    fc.ward_name=map['ward_name'];

    fc.facility_code = map['facility_code'];
    fc.facility_name=map['facility_name'];

    fc.department_code=map['department_code'];
    fc.department_name=map['department_name'];

    fc.beds=map['beds'];

    return fc;
  }

  Map<String, dynamic> toJson() => {
  'ward_code': ward_code,
  'ward_name': ward_name,

  'facility_code': facility_code,
  'facility_name': facility_name,

  'department_code': department_code,
  'department_name': department_name,
  'beds': beds,
  };
}