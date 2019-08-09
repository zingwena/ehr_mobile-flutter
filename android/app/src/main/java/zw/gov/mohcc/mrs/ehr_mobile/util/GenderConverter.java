package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;

public class GenderConverter {
    @TypeConverter
    public static Gender toGender(String gender) {
        if (gender ==Gender.MALE.getGender()) {
            return Gender.MALE;
        } else if (gender ==Gender.FEMALE.getGender()) {
            return Gender.FEMALE;
        } else if (gender ==Gender.UNKNOWN.getGender()) {
            return Gender.UNKNOWN;

        }
        else if (gender ==Gender.NON_BINARY.getGender()) {
            return Gender.NON_BINARY;
        }
        else {
            throw new IllegalArgumentException("Could not recognize status");
        }
    }

    @TypeConverter
    public static String toString(Gender gender) {
        return gender.getGender();
    }
}