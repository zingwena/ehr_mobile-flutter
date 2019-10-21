package zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw;

import androidx.sqlite.db.SimpleSQLiteQuery;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;

public class PersonQuery {

    String nationalIdRegex = "((\\d{8,10})([a-zA-Z])(\\d{2})\\b)";

    public SimpleSQLiteQuery searchPerson(String searchItem) {
        String firstName = "", lastName = "";


        StringBuilder stringQuery = new StringBuilder("SELECT * FROM Person");
        List<Object> parameters = new ArrayList<Object>();

        String searchItemNoSpace = getStringWithoutSpecialCharacters(searchItem);

        if (isNationalId(searchItemNoSpace)) {

            stringQuery.append(" WHERE nationalId is ?");
            parameters.add(searchItemNoSpace);


        } else {

            String[] namesArray = getFirstNameAndLastName(searchItem);
            firstName = namesArray[0];

            if(namesArray.length == 1 ){
                System.out.println("SEARCH ONE ITEM HERE HERE ");
                String searchItemWithoutSpace = getStringWithoutSpecialCharacters(searchItem);
                System.out.println("HERE IS SEARCH ITEM WITHOUT SPACE"+ searchItemWithoutSpace);
                stringQuery.append(" WHERE nationalId is ?");
                parameters.add(searchItemWithoutSpace);

            }

            if (namesArray.length > 1) {
                lastName = namesArray[1];
            }
            //filter for fullName
            String fullNameFilter = searchItemNoSpace.substring(searchItemNoSpace.length() - 3).concat("%");


            if (firstName.length() > 3 && lastName.length() > 3) {
                //filters for searching first name
                String firstNameFilter1 = firstName.substring(0, 3).concat("%");
                String firstNameFilter2 = "%".concat(firstName.substring((firstName.length() - 3)));
                //filters for searching last name
                String lastNameFilter1 = lastName.substring(0, 3).concat("%");
                String lastNameFilter2 = "%".concat(lastName.substring((lastName.length() - 3)));
                stringQuery.append(" WHERE ((firstName Like ? OR firstName Like ?) AND (lastName Like ? OR lastName Like ?)) OR ((lastName Like ? OR lastName Like ?) AND (firstName Like ? OR firstName Like ?))");
                parameters.add(firstNameFilter1);
                parameters.add(firstNameFilter2);
                parameters.add(lastNameFilter1);
                parameters.add(lastNameFilter2);
                parameters.add(fullNameFilter);

            }

            if (firstName.length() <= 3 || lastName.length() <= 3) {
                //filters for searching first name
                String firstNameFilter1 = firstName.substring(0, 3).concat("%");
                String firstNameFilter2 = "%".concat(firstName.substring((firstName.length() - 3)));
                String lastNameFilter1 = firstName.substring(0, 3).concat("%");
                String lastNameFilter2 = "%".concat(firstName.substring((firstName.length() - 3)));


                stringQuery.append(" WHERE (firstName Like ? OR firstName Like ?) OR (lastName Like ? OR lastName Like ?)");
                parameters.add(firstNameFilter1);
                parameters.add(firstNameFilter2);
                parameters.add(lastNameFilter1);
                parameters.add(lastNameFilter2);
            }
            /*if(firstName.length() >= 5  && lastName.length() >= 5){
                String firstNameFilter1 = firstName.substring(0, 3).concat("%");
                String firstNameFilter2 = "%".concat(firstName.substring(firstName.length()-2));
                String lastNameFilter1 = lastName.substring(0, 3).concat("%");
                String lastNameFilter2 = lastName.substring(lastName.length()-2);
                stringQuery.append(" WHERE ((firstName Like ? OR firstName Like ?) AND (lastName Like ? OR lastName Like ?)) OR ((lastName Like ? OR lastName Like ?) AND (firstName Like ? OR firstName Like ?))");
                parameters.add(firstNameFilter1);
                parameters.add(firstNameFilter2);
                parameters.add(lastNameFilter1);
                parameters.add(lastNameFilter2);
            }
            if(firstName.length() >= 5 || lastName.length() >= 5) {
                String firstNameFilter1 = firstName.substring(0, 3).concat("%");
                String firstNameFilter2 = "%".concat(firstName.substring(firstName.length()-2));
                String lastNameFilter1 = lastName.substring(0, 3).concat("%");
                String lastNameFilter2 = lastName.substring(lastName.length()-2);
                stringQuery.append(" WHERE ((firstName Like ? OR firstName Like ?) AND (lastName Like ? OR lastName Like ?)) OR ((lastName Like ? OR lastName Like ?) AND (firstName Like ? OR firstName Like ?))");
                parameters.add(firstNameFilter1);
                parameters.add(firstNameFilter2);
                parameters.add(lastNameFilter1);
                parameters.add(lastNameFilter2);


            }*/


        }

        SimpleSQLiteQuery query = new SimpleSQLiteQuery(stringQuery.toString(), parameters.toArray());

        return query;

    }

    public SimpleSQLiteQuery searchPersonBySurnameAndName(String searchItem) {
        String firstName = "", lastName = "";


        StringBuilder stringQuery = new StringBuilder("SELECT * FROM Person");
        List<Object> parameters = new ArrayList<Object>();

        String searchItemNoSpace = getStringWithoutSpecialCharacters(searchItem);

        if (isNationalId(searchItemNoSpace)) {

            stringQuery.append(" WHERE nationalId is ?");
            parameters.add(searchItemNoSpace);


        } else {

            String[] namesArray = getFirstNameAndLastName(searchItem);
            lastName = namesArray[0];

            if (namesArray.length > 1) {
                firstName = namesArray[1];
            }
            //filter for fullName
            String fullNameFilter = searchItemNoSpace.substring(searchItemNoSpace.length() - 3).concat("%");


            if (firstName.length() > 3 && lastName.length() > 3) {
                //filters for searching first name
                String firstNameFilter1 = firstName.substring(0, 3).concat("%");
                String firstNameFilter2 = "%".concat(firstName.substring((firstName.length() - 3)));

                //filters for searching last name
                String lastNameFilter1 = lastName.substring(0, 3).concat("%");


                stringQuery.append(" WHERE ((firstName Like ? OR firstName Like ?) AND (lastName Like ? OR lastName Like ?)) OR ((lastName Like ? OR lastName Like ?) AND (firstName Like ? OR firstName Like ?))");
                parameters.add(firstNameFilter1);
                parameters.add(firstNameFilter2);
                parameters.add(lastNameFilter1);
                parameters.add(fullNameFilter);

            }
            if (firstName.length() <= 3 || lastName.length() <= 3) {
                //filters for searching first name
                String firstNameFilter1 = firstName.substring(0, 3).concat("%");
                String firstNameFilter2 = "%".concat(firstName.substring((firstName.length() - 3)));


                stringQuery.append(" WHERE (firstName Like ? OR firstName Like ?) OR (lastName Like ? OR lastName Like ?)");
                parameters.add(firstNameFilter1);
                parameters.add(firstNameFilter2);
                parameters.add(firstNameFilter1);
                parameters.add(firstNameFilter2);
            }


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
