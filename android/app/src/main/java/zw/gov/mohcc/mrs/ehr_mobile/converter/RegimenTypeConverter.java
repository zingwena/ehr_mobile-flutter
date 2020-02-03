package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;

public class RegimenTypeConverter {

    @TypeConverter
    public static RegimenType toRegimenType(String regimenType) {

        if (regimenType == null) {
            return null;
        }
        if (regimenType.equals(RegimenType.FIRST_LINE.getRegimenType())) {
            return RegimenType.FIRST_LINE;
        } else if (regimenType.equals(RegimenType.SECOND_LINE.getRegimenType())) {
            return RegimenType.SECOND_LINE;
        } else if (regimenType.equals(RegimenType.THIRD_LINE.getRegimenType())) {
            return RegimenType.THIRD_LINE;
        }
        return null;
    }

    @TypeConverter
    public static String toString(RegimenType regimenType) {
        if (regimenType == null) {
            return null;
        }
        return regimenType.getRegimenType();
    }
}
