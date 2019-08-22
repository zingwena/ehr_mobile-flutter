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
import zw.gov.mohcc.mrs.ehr_mobile.model.Purpose_Of_Tests;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
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
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.Purpose_Of_TestsDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ReligionDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.TestKitDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.UserDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.BloodPressureDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.HeightDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.PulseDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.RespiratoryRateDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.TemperatureDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.VisitDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.WeightDao;
import zw.gov.mohcc.mrs.ehr_mobile.util.DataConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.SelfIdentifiedGenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.BloodPressure;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Height;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Pulse;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.RespiratoryRate;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Temperature;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Weight;


/**
 * Created by Tinotenda Ruzane
 * <p>
 * This is the local database class that will create the instance
 * of the local cache on the mobile phone
 * <p>
 * Room persistence Library will help to create the cache
 */

@Database(entities = {User.class, Authorities.class, Country.class, MaritalStatus.class, Patient.class,

        Facility.class, Religion.class, Nationality.class, Occupation.class, TestKit.class, EducationLevel.class, HtsModel.class, EntryPoint.class,Purpose_Of_Tests.class, ReasonForNotIssuingResult.class}, version = 15, exportSchema = false)

@TypeConverters({DataConverter.class, GenderConverter.class, SelfIdentifiedGenderConverter.class})


@Database(entities = {User.class, Authorities.class, Country.class, MaritalStatus.class, Patient.class,Facility.class, Religion.class, Nationality.class, Occupation.class, EducationLevel.class, HtsModel.class, EntryPoint.class,Purpose_Of_Tests.class, ReasonForNotIssuingResult.class, BloodPressure.class, Temperature.class, RespiratoryRate.class, Weight.class, Height.class, Pulse.class, Visit.class}, version = 4, exportSchema = false)
@TypeConverters({DateConverter.class,DataConverter.class, GenderConverter.class, SelfIdentifiedGenderConverter.class})

public abstract class EhrMobileDatabase extends RoomDatabase {


    public abstract Purpose_Of_TestsDao purpose_of_testsDao();



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

    public abstract TestKitDao testKitDao();

    public abstract ReasonForNotIssuingResultDao reasonForNotIssuingResultDao();

    public abstract BloodPressureDao bloodPressureDao();

    public abstract TemperatureDao temperatureDao();

    public abstract WeightDao weightDao();

    public abstract HeightDao heightDao();

    public abstract RespiratoryRateDao respiratoryRateDao();

    public abstract PulseDao pulseDao();

    public abstract VisitDao visitDao();

}
