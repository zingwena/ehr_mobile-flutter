package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.BinType;

public class BinTypeConverter {

    @TypeConverter
    public static BinType toBinType(int binType) {

        if (binType == BinType.QUEUE.getBinType()) {
            return BinType.QUEUE;
        } else if (binType == BinType.WARD.getBinType()) {
            return BinType.WARD;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(BinType binType) {
        if (binType == null) {
            return -1;
        }
        return binType.getBinType();
    }
}
