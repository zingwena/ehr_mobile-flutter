package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.Gender;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsApproach;

public class HtsApproachConverter {
    @TypeConverter
    public static HtsApproach toHtsApproach(int htsApproach) {

        System.out.println("htsApproach = " + htsApproach);
        if (htsApproach == HtsApproach.PITC.getHtsApproach()) {
            return HtsApproach.PITC;
        } else if (htsApproach == HtsApproach.CICTC.getHtsApproach()) {
            return HtsApproach.CICTC;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + htsApproach);
        }
    }

    @TypeConverter
    public static int toInt(HtsApproach htsApproach) {
        return htsApproach.getHtsApproach();
    }
}