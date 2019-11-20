package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;

public class RegimenTypeConverter {

    @TypeConverter
    public static RegimenType toRegimenType(int regimenType) {

        if (regimenType == RegimenType.FIRST_LINE.getRegimenType()) {
            return RegimenType.FIRST_LINE;
        } else if (regimenType == RegimenType.SECOND_LINE.getRegimenType()) {
            return RegimenType.SECOND_LINE;
        } else if (regimenType == RegimenType.THIRD_LINE.getRegimenType()) {
            return RegimenType.THIRD_LINE;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(RegimenType regimenType) {
        if (regimenType == null) {
            return -1;
        }
        return regimenType.getRegimenType();
    }
}
