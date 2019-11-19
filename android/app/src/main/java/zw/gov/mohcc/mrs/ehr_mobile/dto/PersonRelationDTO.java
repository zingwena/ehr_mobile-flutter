package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.io.Serializable;

public class PersonRelationDTO implements Serializable {

    @NonNull
    private String personId;

    @NonNull
    private String memberId;

    private String phone;

    private String relationShipType;

    private boolean status;
}
