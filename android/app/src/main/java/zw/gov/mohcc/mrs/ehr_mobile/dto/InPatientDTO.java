package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.io.Serializable;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

public class InPatientDTO implements Serializable {

    private final String personId;
    private final NameCode ward;
    private final NameCode diagnosis;

    public InPatientDTO(String personId, NameCode ward, NameCode diagnosis) {
        this.personId = personId;
        this.ward = ward;
        this.diagnosis = diagnosis;
    }

    public NameCode getWard() {
        return ward;
    }

    public NameCode getDiagnosis() {
        return diagnosis;
    }

    public String getPersonId() {
        return personId;
    }
}
