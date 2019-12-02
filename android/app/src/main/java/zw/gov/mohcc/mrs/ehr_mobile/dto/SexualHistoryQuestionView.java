package zw.gov.mohcc.mrs.ehr_mobile.dto;

import androidx.annotation.NonNull;

import java.io.Serializable;

public class SexualHistoryQuestionView implements Serializable {

    NameCodeResponse question;
    @NonNull
    private String id;

    public SexualHistoryQuestionView() {
    }

    public SexualHistoryQuestionView(@NonNull String id, NameCodeResponse question) {
        this.id = id;
        this.question = question;
    }

    @NonNull
    public String getId() {
        return id;
    }

    public void setId(@NonNull String id) {
        this.id = id;
    }

    public NameCodeResponse getQuestion() {
        return question;
    }

    public void setQuestion(NameCodeResponse question) {
        this.question = question;
    }

    @Override
    public String toString() {
        return "SexualHistoryQuestionView{" +
                "question=" + question +
                ", id='" + id + '\'' +
                '}';
    }
}
