package com.example.ehr_mobile.persistance.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

import com.example.ehr_mobile.model.Authorities;
import com.example.ehr_mobile.model.Country;
import com.example.ehr_mobile.model.MaritalState;
import com.example.ehr_mobile.model.User;
import com.example.ehr_mobile.persistance.dao.AuthoritiesDao;
import com.example.ehr_mobile.persistance.dao.CountryDao;
import com.example.ehr_mobile.persistance.dao.MaritalStateDao;
import com.example.ehr_mobile.model.Patient;
import com.example.ehr_mobile.persistance.dao.PatientDao;
import com.example.ehr_mobile.persistance.dao.UserDao;


/**
 * Created by Tinotenda Ruzane
 *
 * This is the local database class that will create the instance
 *of the local cache on the mobile phone
 *
 * Room persistence Library will help to create the cache
 */
@Database(entities = {User.class, Authorities.class, Country.class, MaritalState.class}, version = 1,exportSchema = false)
public abstract class EhrMobileDatabase extends RoomDatabase {

    public abstract UserDao userDao();
    public abstract AuthoritiesDao authoritiesDao();
    public abstract CountryDao countryDao();
    public abstract MaritalStateDao maritalStateDao();

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
