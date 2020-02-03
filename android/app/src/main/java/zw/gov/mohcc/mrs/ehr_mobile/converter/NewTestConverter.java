package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.NewTest;

public class NewTestConverter {
    @TypeConverter
    public static NewTest toNewTest(String newTest) {

        if (newTest == null) {
            return null;
        }
        if (newTest.equals(NewTest.PITC.getNewTest())) {
            return NewTest.PITC;
        } else if (newTest.equals(NewTest.CICTC.getNewTest())) {
            return NewTest.CICTC;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + newTest);
        }
    }

    @TypeConverter
    public static String toString(NewTest newTest) {
        return newTest.getNewTest();
    }
}