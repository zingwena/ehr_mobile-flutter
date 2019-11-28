package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.WorkAreaConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity(indices = {@Index(value = "code", unique = true)})
public class QuestionCategory extends BaseNameModel {

    private Integer sortOrder;

    @TypeConverters(WorkAreaConverter.class)
    private WorkArea workArea;

    public QuestionCategory() {
    }

    @Ignore
    public QuestionCategory(@NonNull String code, @NonNull String name, Integer sortOrder, WorkArea workArea) {
        super(code, name);
        this.sortOrder = sortOrder;
        this.workArea = workArea;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public WorkArea getWorkArea() {
        return workArea;
    }

    public void setWorkArea(WorkArea workArea) {
        this.workArea = workArea;
    }
}
