package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.TypeConverters;

import java.io.Serializable;

import zw.gov.mohcc.mrs.ehr_mobile.converter.TestLevelConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestLevel;

@Entity(primaryKeys = {"testKitId", "testLevel"})
public class TestKitTestLevel implements Serializable {

    @NonNull
    private String testKitId;
    @TypeConverters(TestLevelConverter.class)
    @NonNull
    private TestLevel testLevel;

    public TestKitTestLevel(@NonNull String testKitId, @NonNull TestLevel testLevel) {
        this.testKitId = testKitId;
        this.testLevel = testLevel;
    }

    @NonNull
    public String getTestKitId() {
        return testKitId;
    }

    public void setTestKitId(@NonNull String testKitId) {
        this.testKitId = testKitId;
    }

    @NonNull
    public TestLevel getTestLevel() {
        return testLevel;
    }

    public void setTestLevel(@NonNull TestLevel testLevel) {
        this.testLevel = testLevel;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (!(obj instanceof TestKitTestLevel)) {
            return false;
        }

        return this.getTestKitId().equals(((TestKitTestLevel) obj).getTestKitId()) &&
                this.getTestLevel().equals(((TestKitTestLevel) obj).getTestLevel());
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 19 * hash + ((this.testKitId != null && this.testLevel != null) ?
                (this.testKitId.hashCode() + this.testLevel.hashCode()) : 0);
        return hash;
    }

    @Override
    public String toString() {
        return "TestKitTestLevel{" +
                "testKitId='" + testKitId + '\'' +
                ", testLevel=" + testLevel +
                '}';
    }
}
