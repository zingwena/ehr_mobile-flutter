package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw;

import android.util.Log;

import androidx.sqlite.db.SimpleSQLiteQuery;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

import zw.gov.mohcc.mrs.ehr_mobile.dto.SearchPatientDTO;

public class PersonQuery {

    String nationalIdRegex = "((\\d{8,10})([a-zA-Z])(\\d{2})\\b)";

    public SimpleSQLiteQuery searchPerson(String searchItem) {

        String firstName = "", lastName = "";


        StringBuilder stringQuery = new StringBuilder("SELECT * FROM Person");
        List<Object> parameters = new ArrayList<Object>();

        String searchItemNoSpace = getStringWithoutSpecialCharacters(searchItem);

        String[] searchArray = searchItem.split("\\s");
        if (searchArray.length == 1) {
            SearchPatientDTO searchDTO = SearchPatientDTO.getNationalIdInstance(searchArray[0]);
            stringQuery.append(" WHERE nationalId is ?");
            parameters.add(searchItemNoSpace);



        } else if (searchArray.length == 2) {
            SearchPatientDTO normalFirstNameLastName = SearchPatientDTO.getFirstNameLastNameInstance(searchArray[0], searchArray[1]);

            SearchPatientDTO inverseFirstNameLastName = SearchPatientDTO.getFirstNameLastNameInverseInstance(searchArray[0], searchArray[1]);

            SearchPatientDTO normalLastNameFirstName = SearchPatientDTO.getLastNameFirstNameInstance(searchArray[0], searchArray[1]);

            SearchPatientDTO inverseLastNameFirstName = SearchPatientDTO.getLastNameFirstNameInverseInstance(searchArray[0], searchArray[1]);

            stringQuery.append(" WHERE (((firstName Like ? AND lastName Like ?) OR (firstName Like ? AND lastName Like ?)) OR ((lastName Like ? AND firstName Like ?) OR (lastName Like ? AND firstName Like ?)))");


            parameters.add(normalFirstNameLastName.getFirstName());
            parameters.add(normalFirstNameLastName.getLastName());
            parameters.add(inverseFirstNameLastName.getFirstName());
            parameters.add(inverseFirstNameLastName.getLastName());
            parameters.add(normalLastNameFirstName.getFirstName());
            parameters.add(normalLastNameFirstName.getLastName());
            parameters.add(inverseLastNameFirstName.getFirstName());
            parameters.add(inverseLastNameFirstName.getLastName());
        }

        SimpleSQLiteQuery query = new SimpleSQLiteQuery(stringQuery.toString(), parameters.toArray());

        return query;
    }

    public SimpleSQLiteQuery searchPersonBySurnameAndName(String searchItem) {
        String firstName = "", lastName = "";


        StringBuilder stringQuery = new StringBuilder("SELECT * FROM Person");
        List<Object> parameters = new ArrayList<Object>();

        String searchItemNoSpace = getStringWithoutSpecialCharacters(searchItem);

        String[] searchArray = searchItem.split("\\s");
        if (searchArray.length == 1) {
            SearchPatientDTO searchDTO = SearchPatientDTO.getNationalIdInstance(searchArray[0]);
            stringQuery.append(" WHERE nationalId is ?");
            parameters.add(searchItemNoSpace);


        } else if (searchArray.length == 2) {
            SearchPatientDTO normalFirstNameLastName = SearchPatientDTO.getFirstNameLastNameInstance(searchArray[0], searchArray[1]);

            SearchPatientDTO inverseFirstNameLastName = SearchPatientDTO.getFirstNameLastNameInverseInstance(searchArray[0], searchArray[1]);

            SearchPatientDTO normalLastNameFirstName = SearchPatientDTO.getLastNameFirstNameInstance(searchArray[0], searchArray[1]);

            SearchPatientDTO inverseLastNameFirstName = SearchPatientDTO.getLastNameFirstNameInverseInstance(searchArray[0], searchArray[1]);

            stringQuery.append(" WHERE (((firstName Like ? AND lastName Like ?) OR (firstName Like ? AND lastName Like ?)) OR ((lastName Like ? AND firstName Like ?) OR (lastName Like ? AND firstName Like ?)))");

            parameters.add(normalFirstNameLastName.getFirstName());
            parameters.add(normalFirstNameLastName.getLastName());
            parameters.add(inverseFirstNameLastName.getFirstName());
            parameters.add(inverseFirstNameLastName.getLastName());

            parameters.add(normalLastNameFirstName.getFirstName());
            parameters.add(normalLastNameFirstName.getLastName());
            parameters.add(inverseLastNameFirstName.getFirstName());
            parameters.add(inverseLastNameFirstName.getLastName());
        }

        SimpleSQLiteQuery query = new SimpleSQLiteQuery(stringQuery.toString(), parameters.toArray());

        return query;

    }

    public String getStringWithoutSpecialCharacters(@NotNull String rawString) {
        String rawStringNoSpecialCharacters = rawString.replaceAll("[^a-zA-Z0-9]", "");
        return rawStringNoSpecialCharacters;
    }

    public String[] getFirstNameAndLastName(@NotNull String searchInput) {

        //split search string into firstName And lastName
        String[] searchItemArray = searchInput.trim().split("\\s+");

        return searchItemArray;
    }

    public boolean isNationalId(@NotNull String input) {
        return input.matches(nationalIdRegex);
    }


}
