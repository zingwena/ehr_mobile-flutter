package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.PatientType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TypeOfContact;

public class PatientTypeConverter {

    @TypeConverter
    public static PatientType toPatientType(int patientType) {

        if (patientType == PatientType.INPATIENT.getPatientType()) {
            return PatientType.INPATIENT;
        } else if (patientType == PatientType.OUTPATIENT.getPatientType()) {
            return PatientType.OUTPATIENT;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(PatientType patientType) {
        if (patientType == null) {
            return -1;
        }
        return patientType.getPatientType();
    }
}