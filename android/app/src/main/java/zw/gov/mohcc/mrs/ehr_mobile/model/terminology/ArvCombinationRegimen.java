package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Entity;
import androidx.room.Ignore;
import androidx.room.Index;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.AgeGroupConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.RegimenTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;
import zw.gov.mohcc.mrs.ehr_mobile.model.BaseNameModel;

@Entity(indices = {@Index(value = "code", unique = true)})
public class ArvCombinationRegimen extends BaseNameModel {

    @TypeConverters(RegimenTypeConverter.class)
    private RegimenType regimenType;
    @TypeConverters(AgeGroupConverter.class)
    private AgeGroup ageGroup;

    public ArvCombinationRegimen() {
    }

    @Ignore
    public ArvCombinationRegimen(@NonNull String code, @NonNull String name, RegimenType regimenType, AgeGroup ageGroup) {
        super(code, name);
        this.regimenType = regimenType;
        this.ageGroup = ageGroup;
    }

    public RegimenType getRegimenType() {
        return regimenType;
    }

    public void setRegimenType(RegimenType regimenType) {
        this.regimenType = regimenType;
    }

    public AgeGroup getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(AgeGroup ageGroup) {
        this.ageGroup = ageGroup;
    }

    @Override
    public String toString() {
        return super.toString().concat("ArvCombinationRegimen{" +
                "regimenType=" + regimenType +
                ", ageGroup=" + ageGroup +
                '}');
    }
}
