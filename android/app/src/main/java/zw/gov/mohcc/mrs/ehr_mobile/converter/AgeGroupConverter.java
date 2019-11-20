package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;

public class AgeGroupConverter {

    @TypeConverter
    public static AgeGroup toAgeGroup(int ageGroup) {

        if (ageGroup == AgeGroup.ADULT.getAgeGroup()) {
            return AgeGroup.ADULT;
        } else if (ageGroup == AgeGroup.PEADS.getAgeGroup()) {
            return AgeGroup.PEADS;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(AgeGroup ageGroup) {
        if (ageGroup == null) {
            return -1;
        }
        return ageGroup.getAgeGroup();
    }
}
