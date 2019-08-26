package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.NewTestPregLact;
import zw.gov.mohcc.mrs.ehr_mobile.model.OptOutOfTest;

public class NewPregLactConverter {
    @TypeConverter
    public static NewTestPregLact toNewTestPregLact(int newTestPregLact) {

        System.out.println("NewTestPregLact = " + newTestPregLact);
        if (newTestPregLact == NewTestPregLact.YES.getNewTestPregLact()) {
            return NewTestPregLact.YES;
        } else if (newTestPregLact == NewTestPregLact.NO.getNewTestPregLact()) {
            return NewTestPregLact.NO;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + newTestPregLact
            );
        }
    }

    @TypeConverter
    public static int toInt(NewTestPregLact newTestPregLact) {
        return newTestPregLact.getNewTestPregLact();
    }
}