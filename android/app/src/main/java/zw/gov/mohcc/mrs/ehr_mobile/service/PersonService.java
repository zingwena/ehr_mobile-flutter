package zw.gov.mohcc.mrs.ehr_mobile.service;


import zw.gov.mohcc.mrs.ehr_mobile.dto.Age;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class PersonService {

    private static PersonService INSTANCE;
    private final String TAG = "Person Service";
    private EhrMobileDatabase ehrMobileDatabase;

    private PersonService(EhrMobileDatabase ehrMobileDatabase) {
        this.ehrMobileDatabase = ehrMobileDatabase;
    }

    public static synchronized PersonService getInstance(EhrMobileDatabase ehrMobileDatabase) {

        if (INSTANCE == null) {
            return new PersonService(ehrMobileDatabase);
        }
        return INSTANCE;
    }

    public Age getAge(String personId) {

        Person person = ehrMobileDatabase.personDao().findPatientById(personId);
        return Age.getInstance(person);
    }
}
