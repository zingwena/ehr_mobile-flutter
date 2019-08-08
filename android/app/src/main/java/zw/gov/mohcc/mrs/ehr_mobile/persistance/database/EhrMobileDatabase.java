package zw.gov.mohcc.mrs.ehr_mobile.persistance.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.AuthoritiesDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.CountryDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.MaritalStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.OccupationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PatientDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ReligionDao;
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
        Religion.class, Occupation.class}, version = 2,exportSchema = false)


public abstract class EhrMobileDatabase extends RoomDatabase {

    public abstract UserDao userDao();
    public abstract AuthoritiesDao authoritiesDao();
    public abstract CountryDao countryDao();
    public abstract MaritalStatusDao maritalStateDao();
    public abstract ReligionDao religionDao();
    public abstract OccupationDao occupationDao();

    public abstract PatientDao patientDao();

    public static volatile EhrMobileDatabase INSTANCE;


    public static EhrMobileDatabase getInstance(final Context context){
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
