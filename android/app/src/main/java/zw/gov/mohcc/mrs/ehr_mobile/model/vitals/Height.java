package zw.gov.mohcc.mrs.ehr_mobile.model.vitals;

import androidx.room.Entity;
import androidx.room.ForeignKey;
import androidx.room.Index;

import zw.gov.mohcc.mrs.ehr_mobile.model.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;

@Entity(indices = {@Index("visitId"), @Index("personId")},
        foreignKeys = {
                @ForeignKey(entity = Visit.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "id",
                        childColumns = "visitId"),
                @ForeignKey(entity = Person.class, onDelete = ForeignKey.CASCADE,
                        parentColumns = "id",
                        childColumns = "personId")})
public class Height extends VitalsBaseValue {
}
