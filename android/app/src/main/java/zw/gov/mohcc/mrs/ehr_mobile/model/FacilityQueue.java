package zw.gov.mohcc.mrs.ehr_mobile.model;

import androidx.annotation.NonNull;
import androidx.room.Embedded;
import androidx.room.Entity;
import androidx.room.Ignore;

import zw.gov.mohcc.mrs.ehr_mobile.model.BaseEntity;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameCode;

@Entity
public class FacilityQueue extends BaseEntity {

    @Embedded(prefix = "queue_")
    private NameCode queue;

    @Embedded(prefix = "facility_")
    private NameCode facility;

    private int beds;

    @Embedded(prefix = "department_")
    private NameCode department;

    public FacilityQueue() {
    }

    @Ignore
    public FacilityQueue(@NonNull String id, NameCode queue, NameCode facility, int beds, NameCode department) {
        super(id);
        this.queue = queue;
        this.facility = facility;
        this.beds = beds;
        this.department = department;
    }

    public NameCode getQueue() {
        return queue;
    }

    public void setQueue(NameCode queue) {
        this.queue = queue;
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

    @Override
    public String toString() {
        return super.toString().concat("FacilityQueue{" +
                "queue=" + queue +
                ", facility=" + facility +
                ", beds=" + beds +
                ", department=" + department +
                '}');
    }
}
