package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.BinType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Normality;

public class NormalityConverter {

    @TypeConverter
    public static Normality toNormality(String normality) {

        if (normality == null) {
            return null;
        }
        if (normality.equals(Normality.NONE.getNormality())) {
            return Normality.NONE;
        } else if (normality.equals(Normality.NORMAL.getNormality())) {
            return Normality.NORMAL;
        } else if (normality.equals(Normality.ABNORMAL.getNormality())) {
            return Normality.ABNORMAL;
        }
        return null;
    }

    @TypeConverter
    public static String toString(Normality normality) {
        if (normality == null) {
            return null;
        }
        return normality.getNormality();
    }
}
