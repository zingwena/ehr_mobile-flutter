package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.HtsType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ResponseType;

public class ResponseTypeConverter {

    @TypeConverter
    public static ResponseType toResponseType(int responseType) {

        if (responseType == ResponseType.YES.getResponseType()) {
            return ResponseType.YES;
        } else if (responseType == ResponseType.NO.getResponseType()) {
            return ResponseType.NO;
        } else if (responseType == ResponseType.REFUSED.getResponseType()) {
            return ResponseType.REFUSED;
        }
        return null;
    }

    @TypeConverter
    public static int toInt(HtsType htsType) {
        return htsType.getHtsType();
    }
}
