package zw.gov.mohcc.mrs.ehr_mobile.model.hts;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.dto.NameCodeResponse;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;

import static androidx.room.ForeignKey.CASCADE;

@Entity(indices = {@Index(value = "sexualHistoryId")},
        foreignKeys = {@ForeignKey(entity = SexualHistory.class, onDelete = CASCADE,
                parentColumns = "id",
                childColumns = "sexualHistoryId")})
public class SexualHistoryQuestion extends BaseEntity {

    @NonNull
    private String sexualHistoryId;
    @Embedded
    private NameCodeResponse question;
    public SexualHistoryQuestion() {
    }

    @Ignore
    public SexualHistoryQuestion(@NonNull String id, @NonNull String sexualHistoryId, NameCodeResponse question) {
        super(id);
        this.sexualHistoryId = sexualHistoryId;
        this.question = question;
    }

    @NonNull
    public String getSexualHistoryId() {
        return sexualHistoryId;
    }

    public void setSexualHistoryId(@NonNull String sexualHistoryId) {
        this.sexualHistoryId = sexualHistoryId;
    }

    public NameCodeResponse getQuestion() {
        return question;
    }

    public void setQuestion(NameCodeResponse question) {
        this.question = question;
    }
}
