package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.CoupleCounselling;

public class CoupleCounsellingConverter {
    @TypeConverter
    public static CoupleCounselling toCoupleCounselling(int coupleCounselling) {

        System.out.println("coupleCounselling = " + coupleCounselling);
        if (coupleCounselling == CoupleCounselling.YES.getCoupleCounselling()) {
            return CoupleCounselling.YES;
        } else if (coupleCounselling == CoupleCounselling.NO.getCoupleCounselling()) {
            return CoupleCounselling.NO;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + coupleCounselling);
        }
    }

    @TypeConverter
    public static int toInt(CoupleCounselling coupleCounselling) {
        return coupleCounselling.getCoupleCounselling();
    }
}