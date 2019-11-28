package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import java.io.Serializable;

public class QuestionEhr implements Serializable {

    private String questionId;
    private String name;
    private String categoryId;
    private String type;
    private String workArea;

    public QuestionEhr(String questionId, String name, String categoryId, String type, String workArea) {
        this.questionId = questionId;
        this.name = name;
        this.categoryId = categoryId;
        this.type = type;
        this.workArea = workArea;
    }

    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(String categoryId) {
        this.categoryId = categoryId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getWorkArea() {
        return workArea;
    }

    public void setWorkArea(String workArea) {
        this.workArea = workArea;
    }

    @Override
    public String toString() {
        return "QuestionEhr{" +
                "questionId='" + questionId + '\'' +
                ", name='" + name + '\'' +
                ", categoryId='" + categoryId + '\'' +
                ", type='" + type + '\'' +
                ", workArea='" + workArea + '\'' +
                '}';
    }
}
