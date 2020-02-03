package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.HivTestUsed;

public class HivTestUsedConverter {

    @TypeConverter
    public static HivTestUsed toHivTestUsed(String hivTestUsed) {

        if (hivTestUsed == null) {
            return null;
        }
        if (hivTestUsed.equals(HivTestUsed.AB.getHivTestUsed())) {
            return HivTestUsed.AB;
        } else if (hivTestUsed.equals(HivTestUsed.PCR.getHivTestUsed())) {
            return HivTestUsed.PCR;
        }
        return null;
    }

    @TypeConverter
    public static String toString(HivTestUsed hivTestUsed) {
        return hivTestUsed.getHivTestUsed();
    }
}

