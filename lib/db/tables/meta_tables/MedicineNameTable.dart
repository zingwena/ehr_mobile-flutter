
class MedicineNameTable {


  String medicineCategory;
  String medicineLevel;
  int otc;
  String code;
  String name;

  MedicineNameTable fromJson(Map map) {
    var obj = MedicineNameTable();
    obj.medicineCategory=map['medicineCategory'];
    obj.medicineLevel=map['medicineLevel'];
    obj.otc=map['otc'];
    obj.code=map['code'];
    obj.name=map['name'];
    return obj;
  }

  Map<String, dynamic> toJson() => {
    'medicineCategory':medicineCategory,
    'medicineLevel':medicineLevel,

    'otc':otc,
    'code':code,
    'name':name,
  };
}