package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.OptOutOfTest;

public class OptOutOfTestConverter {
    @TypeConverter
    public static OptOutOfTest toOptOutOfTest(int optOutOfTest) {

        System.out.println("OptOutOfTest = " + optOutOfTest);
        if (optOutOfTest == OptOutOfTest.YES.getOptOutOfTest()) {
            return OptOutOfTest.YES;
        } else if (optOutOfTest == OptOutOfTest.NO.getOptOutOfTest()) {
            return OptOutOfTest.NO;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + optOutOfTest
            );
        }
    }

    @TypeConverter
    public static int toInt(OptOutOfTest optOutOfTest) {
        return optOutOfTest.getOptOutOfTest();
    }
}