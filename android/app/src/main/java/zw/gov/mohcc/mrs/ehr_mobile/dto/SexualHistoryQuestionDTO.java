package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.io.Serializable;

public class SexualHistoryQuestionDTO implements Serializable {

    @NonNull
    private String personId;
    @NonNull
    private String sexualHistoryId;
    @NonNull
    NameCodeResponse question;

    public SexualHistoryQuestionDTO() {
    }

    public SexualHistoryQuestionDTO(@NonNull String personId, @NonNull String sexualHistoryId, @NonNull NameCodeResponse question) {
        this.personId = personId;
        this.sexualHistoryId = sexualHistoryId;
        this.question = question;
    }

    @NonNull
    public String getPersonId() {
        return personId;
    }

    public void setPersonId(@NonNull String personId) {
        this.personId = personId;
    }

    @NonNull
    public String getSexualHistoryId() {
        return sexualHistoryId;
    }

    public void setSexualHistoryId(@NonNull String sexualHistoryId) {
        this.sexualHistoryId = sexualHistoryId;
    }

    @NonNull
    public NameCodeResponse getQuestion() {
        return question;
    }

    public void setQuestion(@NonNull NameCodeResponse question) {
        this.question = question;
    }
}
