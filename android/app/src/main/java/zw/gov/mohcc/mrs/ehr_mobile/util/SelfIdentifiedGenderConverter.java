package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.SelfIdentifiedGender;

public class SelfIdentifiedGenderConverter {

    @TypeConverter
    public static SelfIdentifiedGender toSelfIdentifiedGender(int gender) {
        System.out.println("gender = " + gender);
        if (gender==SelfIdentifiedGender.MALE.getSelfIdentifiedGender()) {
            return SelfIdentifiedGender.MALE;
        } else if (gender==SelfIdentifiedGender.FEMALE.getSelfIdentifiedGender()) {
            return SelfIdentifiedGender.FEMALE;
        } else if (gender==SelfIdentifiedGender.OTHER.getSelfIdentifiedGender()) {
            return SelfIdentifiedGender.OTHER;

        }
        else if (gender==(SelfIdentifiedGender.NON_BINARY.getSelfIdentifiedGender())) {
            return SelfIdentifiedGender.NON_BINARY;
        }
        else {
            return SelfIdentifiedGender.NULL_VALS;
        }
    }

    @TypeConverter
    public static int toInt(SelfIdentifiedGender gender) {
        if (gender == null) {
            return SelfIdentifiedGender.NULL_VALS.getSelfIdentifiedGender();
        }
        return gender.getSelfIdentifiedGender();
    }


}