package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.TestForPregnantLactatingMother;

public class TestForPregnantLactatingMotherConverter {

    @TypeConverter
    public static TestForPregnantLactatingMother toNewTestPregLact(int code) {

        if (code == TestForPregnantLactatingMother.NEW.getCode()) {
            return TestForPregnantLactatingMother.NEW;
        } else if (code == TestForPregnantLactatingMother.NONE.getCode()) {
            return TestForPregnantLactatingMother.NONE;
        } else if (code == TestForPregnantLactatingMother.RETEST.getCode()) {
            return TestForPregnantLactatingMother.RETEST;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + code);
        }
    }

    @TypeConverter
    public static int toInt(TestForPregnantLactatingMother newTestPregLact) {
        return newTestPregLact.getCode();
    }
}