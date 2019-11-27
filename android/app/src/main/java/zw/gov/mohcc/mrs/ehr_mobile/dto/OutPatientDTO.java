package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.io.Serializable;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class OutPatientDTO implements Serializable {

    @NonNull
    private final String personId;
    @NonNull
    private final NameCode queue;

    public OutPatientDTO(String personId, NameCode queue) {
        this.personId = personId;
        this.queue = queue;
    }

    @NonNull
    public NameCode getQueue() {
        return queue;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }
}
