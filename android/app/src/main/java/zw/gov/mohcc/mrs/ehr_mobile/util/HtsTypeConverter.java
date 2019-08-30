package zw.gov.mohcc.mrs.ehr_mobile.util;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.model.HtsType;

public class HtsTypeConverter {
    @TypeConverter
    public static HtsType toHtsType(int htsType) {

        System.out.println("HtsType = " + htsType);
        if (htsType == HtsType.SELF.getHtsType()) {
            return HtsType.SELF;
        } else if (htsType == HtsType.RAPID.getHtsType()) {
            return HtsType.RAPID;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + htsType);
        }
    }

    @TypeConverter
    public static int toInt(HtsType htsType) {
        return htsType.getHtsType();
    }
}

