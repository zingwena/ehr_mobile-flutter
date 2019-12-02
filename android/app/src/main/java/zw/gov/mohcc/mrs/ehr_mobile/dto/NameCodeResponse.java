package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.room.Ignore;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.ResponseTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.ResponseType;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class NameCodeResponse extends NameCode {
    @TypeConverters(ResponseTypeConverter.class)
    private ResponseType responseType;

    public NameCodeResponse(String code, String name) {
        super(code, name);
    }

    @Ignore
    public NameCodeResponse(String code, String name, ResponseType responseType) {
        super(code, name);
        this.responseType = responseType;
    }

    public ResponseType getResponseType() {
        return responseType;
    }

    public void setResponseType(ResponseType responseType) {
        this.responseType = responseType;
    }

    @Override
    public String toString() {
        return super.toString().concat("NameCodeResponse{" +
                "responseType=" + responseType +
                '}');
    }
}
