package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw;

import androidx.sqlite.db.SimpleSQLiteQuery;

import org.junit.Test;

import static org.junit.Assert.*;

public class PatientQueryTest {

    @Test
    public void searchPatient() {


    }

    @Test
    public void getStringWithoutSpecialCharacters() {

        String[] testDataNationalIds = {"12-123456-k-23","12-123456-k-23-","12@123456*k23&","-12-123456k23,"," 12 123 456 k 23 ","%12-%123456= k23","12#123456k23","1 2 123 4 5 6 k 23"};
        PatientQuery patientQuery = new PatientQuery();

        int index = 0;
        for(String testData:testDataNationalIds){

            System.out.println("==========="+index);
            assertEquals("12123456k23",patientQuery.getStringWithoutSpecialCharacters(testData));
            index++;


        }
            }

    @Test
    public void getFirstNameAndLastName() {


    }

    @Test
    public void isNationalId(){



        String[] testDataNationalIds = {"23122334l92","121234567k23","45213640K71","632587068n22","632587068N22","10000256K23","341273781A01","999999999z99"};
        PatientQuery patientQuery = new PatientQuery();

        int index = 0;
        for(String testData:testDataNationalIds){

            System.out.println("==========="+index);
            assertTrue(patientQuery.isNationalId(testData));
            index++;


        }
    }

}