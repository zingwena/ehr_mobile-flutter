package zw.gov.mohcc.mrs.ehr_mobile.dto;

import org.apache.commons.lang3.StringUtils;

public class SearchPatientDTO {

    private String nationalId;
    private String firstName;
    private String lastName;

    private SearchPatientDTO(String nationalId) {
        this.nationalId = nationalId;
    }

    private SearchPatientDTO(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public static SearchPatientDTO getNationalIdInstance (String nationalId) {
        return new SearchPatientDTO(nationalId);
    }

    public static SearchPatientDTO getFirstNameLastNameInstance (String firstName, String lastName) {
        return  new SearchPatientDTO(formatString(firstName, true), formatString(lastName, true));
    }

    public static SearchPatientDTO getFirstNameLastNameInverseInstance (String firstName, String lastName) {
        return  new SearchPatientDTO(formatString(firstName, false), formatString(lastName, false));
    }

    public static SearchPatientDTO getLastNameFirstNameInstance (String firstName, String lastName) {
        return  new SearchPatientDTO(formatString(firstName, true), formatString(lastName, true));
    }

    public static SearchPatientDTO getLastNameFirstNameInverseInstance (String firstName, String lastName) {
        return  new SearchPatientDTO(formatString(firstName, false), formatString(lastName, false));
    }

    public String getNationalId() {
        return nationalId;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    private static String formatString(String word, boolean start) {
        if (StringUtils.isBlank(word)) {
            return null;
        }
        if (word.length() <= 4) {
            return word;
        }
        if (start) {
            return "%"+word.substring(2);
        }
        return word.substring(0, word.length()- 2)+ "%";
    }
}
