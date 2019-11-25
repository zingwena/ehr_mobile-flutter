package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;

import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class FacilityWard extends BaseEntity {

    @Embedded(prefix = "ward_")
    private NameCode ward;

    @Embedded(prefix = "facility_")
    private NameCode facility;

    private int beds;

    @Embedded(prefix = "department_")
    private NameCode department;

    public FacilityWard() {
    }

    @Ignore
    public FacilityWard(@NonNull String id, NameCode ward, NameCode facility, int beds, NameCode department) {
        super(id);
        this.ward = ward;
        this.facility = facility;
        this.beds = beds;
        this.department = department;
    }

    public NameCode getWard() {
        return ward;
    }

    public void setWard(NameCode ward) {
        this.ward = ward;
    }

    public NameCode getFacility() {
        return facility;
    }

    public void setFacility(NameCode facility) {
        this.facility = facility;
    }

    public int getBeds() {
        return beds;
    }

    public void setBeds(int beds) {
        this.beds = beds;
    }

    public NameCode getDepartment() {
        return department;
    }

    public void setDepartment(NameCode department) {
        this.department = department;
    }
}
