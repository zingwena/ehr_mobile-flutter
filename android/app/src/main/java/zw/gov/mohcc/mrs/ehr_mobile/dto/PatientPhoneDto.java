package zw.gov.mohcc.mrs.ehr_mobile.dto;

public class PatientPhoneDto {

    private int id;
    private int patientId;
    private String personId;
    private String phonenumber_1;
    private String phonenumber_2;

    public PatientPhoneDto() {

    }

    public PatientPhoneDto(int id, int patientId, String personId, String phonenumber_1, String phonenumber_2) {
        this.id = id;
        this.patientId = patientId;
        this.personId = personId;
        this.phonenumber_1 = phonenumber_1;
        this.phonenumber_2 = phonenumber_2;
    }

    public int getId() {
        return id;
    }

    public int getPatientId() {
        return patientId;
    }

    public String getPersonId() {
        return personId;
    }

    public String getPhonenumber_1() {
        return phonenumber_1;
    }

    public String getPhonenumber_2() {
        return phonenumber_2;
    }

    @Override
    public String toString() {
        return "PatientPhoneDto{" +
                "id=" + id +
                ", patientId='" + patientId + '\'' +
                ", personId='" + personId + '\'' +
                ", phonenumber_1='" + phonenumber_1 + '\'' +
                ", phonenumber_2='" + phonenumber_2 + '\'' +
                '}';
    }
}
