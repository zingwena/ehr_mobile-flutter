package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.Gender;

public class GenderConverter {
    @TypeConverter
    public static Gender toGender(int gender) {

        System.out.println("gender = " + gender);
        if (gender == Gender.MALE.getSex()) {
            return Gender.MALE;
        } else if (gender == Gender.FEMALE.getSex()) {
            return Gender.FEMALE;
        } else if (gender == Gender.UNKNOWN.getSex()) {
            return Gender.UNKNOWN;

        } else if (gender == (Gender.NON_BINARY.getSex())) {
            return Gender.NON_BINARY;
        } else {
            return Gender.NULL_VALS;
        }
    }

    @TypeConverter
    public static int toInt(Gender gender) {
        if (gender == null) {
            return -1;
        }
        return gender.getSex();
    }
}