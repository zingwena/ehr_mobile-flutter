package zw.gov.mohcc.mrs.ehr_mobile.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PatientSummaryDTO implements Serializable {

    private String personId;
    private ValueDate temperature;
    private ValueDate bloodPressure;
    private ValueDate pulse;
    private ValueDate respiratoryRate;
    private ValueDate height;
    private ValueDate weight;
    private ArtDetailsDTO artDetails;
    private List<InvestigationSummaryDTO> investigations = new ArrayList<>();

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public ValueDate getTemperature() {
        return temperature;
    }

    public void setTemperature(ValueDate temperature) {
        this.temperature = temperature;
    }

    public ValueDate getBloodPressure() {
        return bloodPressure;
    }

    public void setBloodPressure(ValueDate bloodPressure) {
        this.bloodPressure = bloodPressure;
    }

    public ValueDate getPulse() {
        return pulse;
    }

    public void setPulse(ValueDate pulse) {
        this.pulse = pulse;
    }

    public ValueDate getRespiratoryRate() {
        return respiratoryRate;
    }

    public void setRespiratoryRate(ValueDate respiratoryRate) {
        this.respiratoryRate = respiratoryRate;
    }

    public ValueDate getHeight() {
        return height;
    }

    public void setHeight(ValueDate height) {
        this.height = height;
    }

    public ValueDate getWeight() {
        return weight;
    }

    public void setWeight(ValueDate weight) {
        this.weight = weight;
    }

    public ArtDetailsDTO getArtDetails() {
        return artDetails;
    }

    public void setArtDetails(ArtDetailsDTO artDetails) {
        this.artDetails = artDetails;
    }

    public List<InvestigationSummaryDTO> getInvestigations() {
        return investigations;
    }

    public void setInvestigations(List<InvestigationSummaryDTO> investigations) {
        this.investigations = investigations;
    }

    public static class ValueDate {

        private final Double value;
        private Double otherBloodPressureValue;
        private final Date date;

        public ValueDate(Double value, Date date) {
            this.value = value;
            this.date = date;
        }

        public ValueDate(Double value, Double otherBloodPressureValue, PastDate date) {
            this.value = value;
            this.otherBloodPressureValue = otherBloodPressureValue;
            this.date = date;
        }

        public Double getValue() {
            return value;
        }

        public Date getDate() {
            return date;
        }

        public Double getOtherBloodPressureValue() {
            return otherBloodPressureValue;
        }

        public void setOtherBloodPressureValue(Double otherBloodPressureValue) {
            this.otherBloodPressureValue = otherBloodPressureValue;
        }

        @Override
        public String toString() {
            return "ValueDate{" +
                    "value='" + value + '\'' +
                    ", date=" + date +
                    '}';
        }
    }

    public static class InvestigationSummaryDTO {

        private final String testName;
        private final Date testDate;
        private final String result;

        public InvestigationSummaryDTO(String testName, Date testDate, String result) {
            this.testName = testName;
            this.testDate = testDate;
            this.result = result;
        }

        public String getTestName() {
            return testName;
        }

        public Date getTestDate() {
            return testDate;
        }

        public String getResult() {
            return result;
        }

        @Override
        public String toString() {
            return "InvestigationSummaryDTO{" +
                    "testName='" + testName + '\'' +
                    ", testDate=" + testDate +
                    ", result='" + result + '\'' +
                    '}';
        }
    }

    public static class ArtDetailsDTO {

        private final Date dateRegistered;
        private final String artNumber;
        private final String whoStage;
        private final String arvRegimen;

        public ArtDetailsDTO(Date dateRegistered, String artNumber, String whoStage, String arvRegimen) {
            this.dateRegistered = dateRegistered;
            this.artNumber = artNumber;
            this.whoStage = whoStage;
            this.arvRegimen = arvRegimen;
        }

        public Date getDateRegistered() {
            return dateRegistered;
        }

        public String getArtNumber() {
            return artNumber;
        }

        public String getWhoStage() {
            return whoStage;
        }

        public String getArvRegimen() {
            return arvRegimen;
        }

        @Override
        public String toString() {
            return "ArtDetailsDTO{" +
                    "dateRegistered=" + dateRegistered +
                    ", artNumber='" + artNumber + '\'' +
                    ", whoStage='" + whoStage + '\'' +
                    ", arvRegimen='" + arvRegimen + '\'' +
                    '}';
        }
    }

    @Override
    public String toString() {
        return "PatientSummaryDTO{" +
                "personId='" + personId + '\'' +
                ", temperature=" + temperature +
                ", bloodPressure=" + bloodPressure +
                ", pulse=" + pulse +
                ", respiratoryRate=" + respiratoryRate +
                ", height=" + height +
                ", weight=" + weight +
                ", artDetails=" + artDetails +
                ", investigations=" + investigations +
                '}';
    }
}
