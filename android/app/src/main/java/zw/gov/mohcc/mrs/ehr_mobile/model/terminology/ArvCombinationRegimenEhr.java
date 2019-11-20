package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Ignore;

import java.util.ArrayList;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;

public class ArvCombinationRegimenEhr extends NameCode {

    private String regimenType;
    private String ageGroup;

    @Ignore
    public ArvCombinationRegimenEhr(@NonNull String code, @NonNull String name, String regimenType, String ageGroup) {
        super(code, name);
        this.regimenType = regimenType;
        this.ageGroup = ageGroup;
    }

    public static List<ArvCombinationRegimen> getInstance(List<ArvCombinationRegimenEhr> items) {
        List<ArvCombinationRegimen> regiments = new ArrayList<>();
        for (ArvCombinationRegimenEhr item : items) {
            regiments.add(new ArvCombinationRegimen(
                    //item.getCode(), item.getName(), RegimenType.get(item.getRegimenType()), AgeGroup.get(item.getAgeGroup())
                    item.getCode(), item.getName(), null, null
            ));
        }
        return regiments;
    }

    public String getRegimenType() {
        return regimenType;
    }

    public void setRegimenType(String regimenType) {
        this.regimenType = regimenType;
    }

    public String getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(String ageGroup) {
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
