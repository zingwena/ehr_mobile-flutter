package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.Gender;

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
            throw new IllegalArgumentException("Could not recognize status  " + gender);
        }
    }

    @TypeConverter
    public static int toInt(Gender gender) {
        return gender.getSex();
    }
}