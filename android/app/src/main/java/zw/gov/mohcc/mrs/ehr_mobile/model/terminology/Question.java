package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.QuestionType;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity(indices = {@Index(value = "code", unique = true)})
public class Question extends BaseNameModel {

    @NonNull
    private String categoryId;

    private QuestionType type;

    public Question() {
    }

    @Ignore
    public Question(@NonNull String code, @NonNull String name, @NonNull String categoryId, QuestionType type) {
        super(code, name);
        this.categoryId = categoryId;
        this.type = type;
    }

    @NonNull
    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(@NonNull String categoryId) {
        this.categoryId = categoryId;
    }

    public QuestionType getType() {
        return type;
    }

    public void setType(QuestionType type) {
        this.type = type;
    }
}
