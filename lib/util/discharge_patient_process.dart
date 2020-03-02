import 'package:ehr_mobile/db/dao/PatientQueueDao.dart';
import 'package:ehr_mobile/db/tables/visit_table.dart';
import 'package:ehr_mobile/util/custom_date_converter.dart';
import 'package:ehr_mobile/db/dao/visit_dao.dart';
import 'package:ehr_mobile/db/db_helper.dart';

void dischargePatient(List<VisitTable> visits, DateTime dischargedDate) async {

  var dbHandler = DatabaseHelper();
  var adapter = await dbHandler.getAdapter();
  var visitDao = VisitDao(adapter);
  var patientQueueDao = PatientQueueDao(adapter);

  for (VisitTable visit in visits) {
    print("Discharging patient process");
    visit.discharged = CustomDateTimeConverter().toSqlDate(dischargedDate);

    visitDao.updateDischargedDate(visit);
    print("Updated patient visit, visit now dicharged : " + visit.discharged);

    if (patientQueueDao.findByVisitId(visit.id) != null) {
      patientQueueDao.deleteByVisitId(visit.id);
      print("Removed patient from out patient queue : " + visit.id);
    }

    // ward section will be implemented once wards are operational
    /*if (ehrMobileDatabase.patientWardDao().existsByVisitId(visitId) >= 1) {
      ehrMobileDatabase.patientWardDao().deleteByVisitid(visitId);
      Log.d(TAG, "Removed patient from in patient queue : " + visit);
    }*/
  }

}