package zw.gov.mohcc.mrs.ehr_mobile.model.terminology;

import androidx.annotation.NonNull;
import androidx.room.Ignore;

import java.util.ArrayList;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.enumeration.AgeGroup;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.RegimenType;

public class ArvCombinationRegimenEhr extends NameCode {

    private String arvCombinationRegimenId;
    private String regimenType;
    private String arvAgeGroup;

    public ArvCombinationRegimenEhr(String code, String name, String arvCombinationRegimenId, String regimenType, String arvAgeGroup) {
        super(code, name);
        this.arvCombinationRegimenId = arvCombinationRegimenId;
        this.regimenType = regimenType;
        this.arvAgeGroup = arvAgeGroup;
    }

    public static List<ArvCombinationRegimen> getInstance(List<ArvCombinationRegimenEhr> items) {
        List<ArvCombinationRegimen> regiments = new ArrayList<>();
        for (ArvCombinationRegimenEhr item : items) {
            regiments.add(new ArvCombinationRegimen(
                    item.getArvCombinationRegimenId(), item.getName()+ " "+item.getCode(), RegimenType.get(item.getRegimenType()), AgeGroup.get(item.getArvAgeGroup())
                    //item.getCode(), item.getName(), null, null
            ));
        }
        return regiments;
    }

    public String getArvCombinationRegimenId() {
        return arvCombinationRegimenId;
    }

    public void setArvCombinationRegimenId(String arvCombinationRegimenId) {
        this.arvCombinationRegimenId = arvCombinationRegimenId;
    }

    public String getRegimenType() {
        return regimenType;
    }

    public void setRegimenType(String regimenType) {
        this.regimenType = regimenType;
    }

    public String getArvAgeGroup() {
        return arvAgeGroup;
    }

    public void setArvAgeGroup(String ageGroup) {
        this.arvAgeGroup = arvAgeGroup;
    }

    @Override
    public String toString() {
        return super.toString().concat("ArvCombinationRegimen{" +
                "regimenType=" + regimenType +
                ", arvAgeGroup=" + arvAgeGroup +
                '}');
    }
}
