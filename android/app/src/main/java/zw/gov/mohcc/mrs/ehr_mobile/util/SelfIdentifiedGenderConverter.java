package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.SelfIdentifiedGender;

public class SelfIdentifiedGenderConverter {
    @TypeConverter
    public static SelfIdentifiedGender toSelfIdentifiedGender(String gender) {
        if (gender ==SelfIdentifiedGender.MALE.getName()) {
            return SelfIdentifiedGender.MALE;
        } else if (gender ==SelfIdentifiedGender.FEMALE.getName()) {
            return SelfIdentifiedGender.FEMALE;
        } else if (gender ==SelfIdentifiedGender.OTHER.getName()) {
            return SelfIdentifiedGender.OTHER;

        }
        else if (gender ==SelfIdentifiedGender.NON_BINARY.getName()) {
            return SelfIdentifiedGender.NON_BINARY;
        }
        else {
            throw new IllegalArgumentException("Could not recognize status"+gender);
        }
    }

    @TypeConverter
    public static String toString(SelfIdentifiedGender gender) {
        return gender.getName();
    }
}