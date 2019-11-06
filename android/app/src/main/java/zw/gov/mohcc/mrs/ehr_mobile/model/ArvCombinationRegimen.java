package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.room.Entity;
import androidx.room.Ignore;

@Entity
public class ArvCombinationRegimen extends BaseNameModel {
   enum regimen_type{
       FIRST_LINE,
       SECOND_LINE,
       THIRD_LINE
   }
   enum age_group{
       ADULT,
       PEADS
   }
    public ArvCombinationRegimen() {
    }

    @Ignore
    public ArvCombinationRegimen(String code, String name) {
        super(code, name);
    }

    public static age_group getAgeGroup(int age){
       /* to work on actual implementation */
        if(age== 0 && age<= 15){
            return age_group.PEADS;

        }else {
            return age_group.ADULT;
        }
    }
}
