package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw;

import androidx.sqlite.db.SimpleSQLiteQuery;

import org.junit.Test;

import static org.junit.Assert.*;

public class PatientQueryTest {

    @Test
    public void searchPatient() {
            //User enters naational Id
        PatientQuery patientQuery = new PatientQuery();
        SimpleSQLiteQuery expectedNationalIdQuery = new SimpleSQLiteQuery("SELECT * FROM Patient WHERE nationalId is ?",new Object[]{"12123456k23"});

        String[] testDataNationalIds = {"12-123456-k-23", "12-123456-k-23-", "12@123456*k23&", "-12-123456k23,", " 12 123 456 k 23 ", "%12-%123456= k23", "12#123456k23", "1 2 123 4 5 6 k 23"};
        int index = 0;
        for (String testData : testDataNationalIds) {

            System.out.println("===========" + index);
            assertEquals(expectedNationalIdQuery.getSql(),patientQuery.searchPatient(testData).getSql());
            index++;

        }
        System.out.println("=-===-=-=-=-=-=-=-=-=-=-=-=-=-=-=-----------------------------------------------------------------------------------------------------------------");

        //user enters full name
        String[] testNames = {"Tonderai Hove","Tond3ra1 Hov3","Tonde Hove.","Tonde, hove!"};
        SimpleSQLiteQuery expectedQuery = new SimpleSQLiteQuery("SELECT * FROM Patient WHERE (firstName Like ? OR firstName Like ?) AND (lastName Like ? OR lastName Like ?)");

        int index1 = 0;
        for (String testName : testNames) {

            System.out.println("===========test2 index" + index1);
            assertEquals(expectedQuery.getSql(),patientQuery.searchPatient(testName).getSql());
            index1++;
        }
        System.out.println("=-===-=-=-=-=-=-=-=-=-=-=-=-=-=-=-----------------------------------------------------------------------------------------------------------------");

        //user enters full name
        String[] testNames2 = {"T Hove","T Hov3","T Hove.","T, hove!"};
        SimpleSQLiteQuery expectedQuery2 = new SimpleSQLiteQuery("SELECT * FROM Patient WHERE lastName Like ? OR lastName Like ?");

        int index2 = 0;
        for (String testName : testNames2) {

            System.out.println("===========test3 index" + index2);
            assertEquals(expectedQuery2.getSql(),patientQuery.searchPatient(testName).getSql());
            index2++;
        }


    }

    @Test
    public void getStringWithoutSpecialCharacters() {

        String[] testDataNationalIds = {"12-123456-k-23", "12-123456-k-23-", "12@123456*k23&", "-12-123456k23,", " 12 123 456 k 23 ", "%12-%123456= k23", "12#123456k23", "1 2 123 4 5 6 k 23"};
        PatientQuery patientQuery = new PatientQuery();

        int index = 0;
        for (String testData : testDataNationalIds) {

            System.out.println("===========" + index);
            assertEquals("12123456k23", patientQuery.getStringWithoutSpecialCharacters(testData));
            index++;

        }
    }

    @Test
    public void getFirstNameAndLastName() {
        PatientQuery patientQuery = new PatientQuery();
        String[] inputs = {"kuda kuzvindiwana","t ruzane","b r ian machavuda","phenias c","muzinda"};


        int index = 0;
        for (String input : inputs) {

            System.out.println("===========" + index);
            String[] output = patientQuery.getFirstNameAndLastName(input);
            assertTrue(output.length > 0);
            index++;


        }


    }

    @Test
    public void isNationalId() {


        String[] testDataNationalIds = {"23122334l92", "121234567k23", "45213640K71", "632587068n22", "632587068N22", "10000256K23", "341273781A01", "999999999z99"};
        PatientQuery patientQuery = new PatientQuery();

        int index = 0;
        for (String testData : testDataNationalIds) {

            System.out.println("===========" + index);
            assertTrue(patientQuery.isNationalId(testData));
            index++;


        }
    }

}