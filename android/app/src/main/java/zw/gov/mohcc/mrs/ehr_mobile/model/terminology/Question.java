package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.WorkAreaConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.QuestionType;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity(indices = {@Index(value = "code", unique = true), @Index(value = "categoryId")},
        foreignKeys = {
                @ForeignKey(entity = Country.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "code",
                        childColumns = "categoryId")})
public class Question extends BaseNameModel {

    @NonNull
    private String categoryId;
    private QuestionType type;
    @TypeConverters(WorkAreaConverter.class)
    @NonNull
    private WorkArea workArea;

    public Question() {
    }

    @Ignore
    public Question(@NonNull String code, @NonNull String name, @NonNull String categoryId, QuestionType type, WorkArea workArea) {
        super(code, name);
        this.categoryId = categoryId;
        this.type = type;
        this.workArea = workArea;
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

    @NonNull
    public WorkArea getWorkArea() {
        return workArea;
    }

    public void setWorkArea(@NonNull WorkArea workArea) {
        this.workArea = workArea;
    }

    @Override
    public String toString() {
        return super.toString().concat("Question{" +
                "categoryId='" + categoryId + '\'' +
                ", type=" + type +
                ", workArea=" + workArea +
                '}');
    }
}
