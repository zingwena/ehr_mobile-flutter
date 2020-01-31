package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.BinType;

public class BinTypeConverter {

    @TypeConverter
    public static BinType toBinType(String binType) {

        if (binType.equals(BinType.QUEUE.getBinType())) {
            return BinType.QUEUE;
        } else if (binType.equals(BinType.WARD.getBinType())) {
            return BinType.WARD;
        }
        return null;
    }

    @TypeConverter
    public static String toString(BinType binType) {
        if (binType == null) {
            return null;
        }
        return binType.getBinType();
    }
}
