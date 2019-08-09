package zw.gov.mohcc.mrs.ehr_mobile.persistance.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

import zw.gov.mohcc.mrs.ehr_mobile.model.Education;
import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;

import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;

import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;

import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.AuthoritiesDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.CountryDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.EducationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.EducationLevelDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.MaritalStatusDao;

import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.OccupationDao;

import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.NationalityDao;

import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PatientDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.UserDao;


/**
 * Created by Tinotenda Ruzane
 *
 * This is the local database class that will create the instance
 *of the local cache on the mobile phone
 *
 * Room persistence Library will help to create the cache
 */

@Database(entities = {User.class, Authorities.class, Country.class, MaritalStatus.class, Patient.class,

        Religion.class, Nationality.class, Occupation.class, EducationLevel.class, Education.class}, version = 1,exportSchema = false)



public abstract class EhrMobileDatabase extends RoomDatabase {

    public abstract UserDao userDao();
    public abstract AuthoritiesDao authoritiesDao();
    public abstract CountryDao countryDao();
    public abstract MaritalStatusDao maritalStateDao();

    public abstract OccupationDao occupationDao();
    public abstract NationalityDao nationalityDao();
    public abstract EducationLevelDao educationLevelDao();
    public abstract EducationDao educationDao();


    public abstract PatientDao patientDao();

    public static volatile EhrMobileDatabase INSTANCE;


    public static EhrMobileDatabase getDatabaseInstance(final Context context){
        if(INSTANCE==null){
            synchronized (EhrMobileDatabase.class){
                if(INSTANCE==null){

                    INSTANCE= Room.databaseBuilder(context.getApplicationContext(),
                            EhrMobileDatabase.class,"ehrMobile")
                            .allowMainThreadQueries()
                             .fallbackToDestructiveMigration()
                            .build();
                }
            }
        }
        return INSTANCE;
    }
}
