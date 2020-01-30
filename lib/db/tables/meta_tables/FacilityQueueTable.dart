

class FacilityQueueTable{

  String queue_code;
  String queue_name;

  String facility_code;
  String facility_name;

  String department_code;
  String department_name;
  int beds;

  FacilityQueueTable fromJson(Map map) {
    var fc = FacilityQueueTable();
    fc.queue_code = map['queue_code'];
    fc.queue_name=map['queue_name'];

    fc.facility_code = map['facility_code'];
    fc.facility_name=map['facility_name'];

    fc.department_code=map['department_code'];
    fc.department_name=map['department_name'];

    fc.beds=map['beds'];

    return fc;
  }

  Map<String, dynamic> toJson() => {
    'queue_code': queue_code,
    'queue_name': queue_name,

    'facility_code': facility_code,
    'facility_name': facility_name,

    'department_code': department_code,
    'department_name': department_name,
    'beds': beds,
  };
}