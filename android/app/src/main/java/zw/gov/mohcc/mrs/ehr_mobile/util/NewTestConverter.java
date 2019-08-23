package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsApproach;
import zw.gov.mohcc.mrs.ehr_mobile.model.NewTest;

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