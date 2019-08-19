package zw.gov.mohcc.mrs.ehr_mobile.persistance.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.Patient;
import zw.gov.mohcc.mrs.ehr_mobile.model.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.AuthoritiesDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.CountryDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.EducationLevelDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.EntryPointDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.FacilityDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.HtsModelDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.MaritalStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.NationalityDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.OccupationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PatientDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ReasonForNotIssuingResultDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ReligionDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.UserDao;
import zw.gov.mohcc.mrs.ehr_mobile.util.DataConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.SelfIdentifiedGenderConverter;


/**
 * Created by Tinotenda Ruzane
 * <p>
 * This is the local database class that will create the instance
 * of the local cache on the mobile phone
 * <p>
 * Room persistence Library will help to create the cache
 */

@Database(entities = {User.class, Authorities.class, Country.class, MaritalStatus.class, Patient.class,
        Facility.class, Religion.class, Nationality.class, Occupation.class, EducationLevel.class, HtsModel.class, EntryPoint.class, ReasonForNotIssuingResult.class}, version = 4, exportSchema = false)
@TypeConverters({DataConverter.class, GenderConverter.class, SelfIdentifiedGenderConverter.class})

public abstract class EhrMobileDatabase extends RoomDatabase {

    public static volatile EhrMobileDatabase INSTANCE;

    public static EhrMobileDatabase getDatabaseInstance(final Context context) {
        if (INSTANCE == null) {
            synchronized (EhrMobileDatabase.class) {
                if (INSTANCE == null) {

                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(),
                            EhrMobileDatabase.class, "ehrMobile")
                            .allowMainThreadQueries()
                            .fallbackToDestructiveMigration()
                            .build();
                }
            }
        }
        return INSTANCE;
    }

    public abstract UserDao userDao();

    public abstract AuthoritiesDao authoritiesDao();

    public abstract CountryDao countryDao();

    public abstract MaritalStatusDao maritalStateDao();

    public abstract ReligionDao religionDao();

    public abstract OccupationDao occupationDao();

    public abstract NationalityDao nationalityDao();

    public abstract EducationLevelDao educationLevelDao();

    public abstract PatientDao patientDao();

    public abstract FacilityDao facilityDao();

    public abstract EntryPointDao entryPointDao();

    public abstract HtsModelDao htsModelDao();

    public abstract ReasonForNotIssuingResultDao reasonForNotIssuingResultDao();

}
