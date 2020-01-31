package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.CoupleCounselling;

public class CoupleCounsellingConverter {
    @TypeConverter
    public static CoupleCounselling toCoupleCounselling(String coupleCounselling) {

        if (coupleCounselling.equals(CoupleCounselling.YES.getCoupleCounselling())) {
            return CoupleCounselling.YES;
        } else if (coupleCounselling.equals(CoupleCounselling.NO.getCoupleCounselling())) {
            return CoupleCounselling.NO;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + coupleCounselling);
        }
    }

    @TypeConverter
    public static String toString(CoupleCounselling coupleCounselling) {
        return coupleCounselling.getCoupleCounselling();
    }
}