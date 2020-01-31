package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;

public class GenderConverter {
    @TypeConverter
    public static Gender toGender(String gender) {

        if (gender.equals(Gender.MALE.getSex())) {
            return Gender.MALE;
        } else if (gender.equals(Gender.FEMALE.getSex())) {
            return Gender.FEMALE;
        } else if (gender.equals(Gender.UNKNOWN.getSex())) {
            return Gender.UNKNOWN;

        } else if (gender.equals(Gender.NON_BINARY.getSex())) {
            return Gender.NON_BINARY;
        } else {
            return Gender.NULL_VALS;
        }
    }

    @TypeConverter
    public static String toString(Gender gender) {
        if (gender == null) {
            return null;
        }
        return gender.getSex();
    }
}