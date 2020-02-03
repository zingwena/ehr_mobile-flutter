package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.HtsApproach;

public class HtsApproachConverter {
    @TypeConverter
    public static HtsApproach toHtsApproach(String htsApproach) {

        if (htsApproach == null) {
            return null;
        }
        if (htsApproach.equals(HtsApproach.PITC.getHtsApproach())) {
            return HtsApproach.PITC;
        } else if (htsApproach.equals(HtsApproach.CICTC.getHtsApproach())) {
            return HtsApproach.CICTC;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + htsApproach);
        }
    }

    @TypeConverter
    public static String toString(HtsApproach htsApproach) {
        return htsApproach.getHtsApproach();
    }
}