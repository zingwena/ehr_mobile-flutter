package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.WorkAreaConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.QuestionType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity(indices = {@Index(value = "code", unique = true)})
public class Question extends BaseNameModel {

    private String categoryId;

    private QuestionType type;

    @TypeConverters(WorkAreaConverter.class)
    private WorkArea workArea;

    public Question() {
    }

    @Ignore
    public Question(@NonNull String code, @NonNull String name, String categoryId, QuestionType type, WorkArea workArea) {
        super(code, name);
        this.categoryId = categoryId;
        this.type = type;
        this.workArea = workArea;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public QuestionType getType() {
        return type;
    }

    public void setType(QuestionType type) {
        this.type = type;
    }

    public WorkArea getWorkArea() {
        return workArea;
    }

    public void setWorkArea(WorkArea workArea) {
        this.workArea = workArea;
    }
}
