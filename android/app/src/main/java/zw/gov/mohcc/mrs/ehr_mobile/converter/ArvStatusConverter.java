package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ArvStatus;

public class ArvStatusConverter {

    @TypeConverter
    public static ArvStatus toArvStatus(String arvStatus) {

        if (arvStatus == null) {
            return null;
        }
        if (arvStatus.equals(ArvStatus.NO_ARV.getArvStatus())) {
            return ArvStatus.NO_ARV;
        } else if (arvStatus.equals(ArvStatus.START_ARV.getArvStatus())) {
            return ArvStatus.START_ARV;
        } else if (arvStatus.equals(ArvStatus.CONTINUE.getArvStatus())) {
            return ArvStatus.CONTINUE;
        } else if (arvStatus.equals(ArvStatus.CHANGE.getArvStatus())) {
            return ArvStatus.CHANGE;
        } else if (arvStatus.equals(ArvStatus.STOP.getArvStatus())) {
            return ArvStatus.STOP;
        } else if (arvStatus.equals(ArvStatus.RESTART.getArvStatus())) {
            return ArvStatus.RESTART;
        } else if (arvStatus.equals(ArvStatus.PMTCT_PROPHLAXIS.getArvStatus())) {
            return ArvStatus.PMTCT_PROPHLAXIS;
        }
        return null;
    }

    @TypeConverter
    public static String toString(ArvStatus arvStatus) {
        if (arvStatus == null) {
            return null;
        }
        return arvStatus.getArvStatus();
    }
}
