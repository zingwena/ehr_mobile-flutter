package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.PatientType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TypeOfContact;

public class PatientTypeConverter {

    @TypeConverter
    public static PatientType toPatientType(String patientType) {

        if (patientType.equals(PatientType.INPATIENT.getPatientType())) {
            return PatientType.INPATIENT;
        } else if (patientType.equals(PatientType.OUTPATIENT.getPatientType())) {
            return PatientType.OUTPATIENT;
        }
        return null;
    }

    @TypeConverter
    public static String toString(PatientType patientType) {
        if (patientType == null) {
            return null;
        }
        return patientType.getPatientType();
    }
}