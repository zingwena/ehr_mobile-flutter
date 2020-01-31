package zw.gov.mohcc.mrs.ehr_mobile.converter;

import androidx.room.TypeConverter;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.HtsType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ResponseType;

public class ResponseTypeConverter {

    @TypeConverter
    public static ResponseType toResponseType(String responseType) {

        if (responseType.equals(ResponseType.YES.getResponseType())) {
            return ResponseType.YES;
        } else if (responseType.equals(ResponseType.NO.getResponseType())) {
            return ResponseType.NO;
        } else if (responseType.equals(ResponseType.REFUSED.getResponseType())) {
            return ResponseType.REFUSED;
        }
        return null;
    }

    @TypeConverter
    public static String toString(ResponseType responseType) {
        if (responseType == null) {
            return null;
        }
        return responseType.getResponseType();
    }
}
