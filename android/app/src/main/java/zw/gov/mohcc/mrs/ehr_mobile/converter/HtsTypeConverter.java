package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.HtsType;

public class HtsTypeConverter {

    @TypeConverter
    public static HtsType toHtsType(String htsType) {

        if (htsType == null) {
            return null;
        }
        if (htsType.equals(HtsType.SELF.getHtsType())) {
            return HtsType.SELF;
        } else if (htsType.equals(HtsType.RAPID.getHtsType())) {
            return HtsType.RAPID;
        } else {
            throw new IllegalArgumentException("Could not recognize status  " + htsType);
        }
    }

    @TypeConverter
    public static String toString(HtsType htsType) {
        return htsType.getHtsType();
    }
}

