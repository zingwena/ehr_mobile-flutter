package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.NewTest;

public class NewTestConverter {
    @TypeConverter
    public static NewTest toNewTest(int newTest) {

        System.out.println("newTest = " + newTest);
        if (newTest == NewTest.PITC.getNewTest()) {
            return NewTest.PITC;
        } else if (newTest == NewTest.CICTC.getNewTest()) {
            return NewTest.CICTC;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + newTest);
        }
    }

    @TypeConverter
    public static int toInt(NewTest newTest) {
        return newTest.getNewTest();
    }
}