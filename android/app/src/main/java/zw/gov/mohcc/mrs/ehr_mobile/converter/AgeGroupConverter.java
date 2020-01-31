package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;

public class AgeGroupConverter {

    @TypeConverter
    public static AgeGroup toAgeGroup(String ageGroup) {

        if (ageGroup.equals(AgeGroup.ADULT.getAgeGroup())) {
            return AgeGroup.ADULT;
        } else if (ageGroup.equals(AgeGroup.PEADS.getAgeGroup())) {
            return AgeGroup.PEADS;
        }
        return null;
    }

    @TypeConverter
    public static String toString(AgeGroup ageGroup) {
        if (ageGroup == null) {
            return null;
        }
        return ageGroup.getAgeGroup();
    }
}
