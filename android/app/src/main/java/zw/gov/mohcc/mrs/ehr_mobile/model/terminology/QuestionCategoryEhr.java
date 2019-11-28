package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import java.io.Serializable;

import zw.gov.mohcc.mrs.ehr_mobile.converter.WorkAreaConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

public class QuestionCategoryEhr implements Serializable {

    private String questionCategoryId;
    private String name;
    private Integer sortOrder;
    private String workArea;

    public QuestionCategoryEhr(String questionCategoryId, String name, Integer sortOrder, String workArea) {
        this.questionCategoryId = questionCategoryId;
        this.name = name;
        this.sortOrder = sortOrder;
        this.workArea = workArea;
    }

    public String getQuestionCategoryId() {
        return questionCategoryId;
    }

    public void setQuestionCategoryId(String questionCategoryId) {
        this.questionCategoryId = questionCategoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public String getWorkArea() {
        return workArea;
    }

    public void setWorkArea(String workArea) {
        this.workArea = workArea;
    }

    @Override
    public String toString() {
        return "QuestionCategoryEhr{" +
                "questionCategoryId='" + questionCategoryId + '\'' +
                ", name='" + name + '\'' +
                ", sortOrder=" + sortOrder +
                ", workArea='" + workArea + '\'' +
                '}';
    }
}
