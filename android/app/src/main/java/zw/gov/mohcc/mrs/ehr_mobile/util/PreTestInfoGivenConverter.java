package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.PreTestInfoGiven;

public class PreTestInfoGivenConverter {
    @TypeConverter
    public static PreTestInfoGiven toPreTestInfoGiven(int preTestInfoGiven) {

        System.out.println("preTestInfoGiven = " + preTestInfoGiven);
        if (preTestInfoGiven == PreTestInfoGiven.YES.getPreTestInfoGiven()) {
            return PreTestInfoGiven.YES;
        } else if (preTestInfoGiven == PreTestInfoGiven.NO.getPreTestInfoGiven()) {
            return PreTestInfoGiven.NO;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + preTestInfoGiven);
        }
    }

    @TypeConverter
    public static int toInt(PreTestInfoGiven preTestInfoGiven) {
        return preTestInfoGiven.getPreTestInfoGiven();
    }
}