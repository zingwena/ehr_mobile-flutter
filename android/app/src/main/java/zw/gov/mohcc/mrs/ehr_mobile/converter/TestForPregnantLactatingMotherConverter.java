package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestForPregnantLactatingMother;

public class TestForPregnantLactatingMotherConverter {

    @TypeConverter
    public static TestForPregnantLactatingMother toNewTestPregLact(String code) {

        if (code == null) {
            return null;
        }
        if (code.equals(TestForPregnantLactatingMother.NEW.getCode())) {
            return TestForPregnantLactatingMother.NEW;
        } else if (code.equals(TestForPregnantLactatingMother.NONE.getCode())) {
            return TestForPregnantLactatingMother.NONE;
        } else if (code.equals(TestForPregnantLactatingMother.RETEST.getCode())) {
            return TestForPregnantLactatingMother.RETEST;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + code);
        }
    }

    @TypeConverter
    public static String toString(TestForPregnantLactatingMother newTestPregLact) {
        if (newTestPregLact == null) {
            return null;
        }
        return newTestPregLact.getCode();
    }
}