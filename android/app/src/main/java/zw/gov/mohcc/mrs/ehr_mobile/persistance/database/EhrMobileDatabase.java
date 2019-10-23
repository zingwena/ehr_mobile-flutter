package zw.gov.mohcc.mrs.ehr_mobile.persistance.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.model.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArtStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArtInitiation;
import zw.gov.mohcc.mrs.ehr_mobile.model.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryInvestigationTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientPhoneNumber;
import zw.gov.mohcc.mrs.ehr_mobile.model.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.model.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.Town;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.BloodPressure;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Height;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Pulse;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.RespiratoryRate;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Temperature;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Weight;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtReasonDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtInitiationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtRegistrationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArvCombinationRegimenDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.AuthoritiesDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.CountryDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.EducationLevelDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.EntryPointDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.FacilityDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.HtsDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.HtsModelDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.InvestigationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.InvestigationResultDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.LaboratoryInvestigationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.LaboratoryInvestigationTestDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.LaboratoryTestDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.MaritalStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.NationalityDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.OccupationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PatientPhoneDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PersonDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PersonInvestigationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PurposeOfTestDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ReasonForNotIssuingResultDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ReligionDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ResultDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.SampleDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.TestKitDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.TownsDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.UserDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.BloodPressureDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.HeightDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.PulseDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.RespiratoryRateDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.TemperatureDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.VisitDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.WeightDao;
import zw.gov.mohcc.mrs.ehr_mobile.util.CoupleCounsellingConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.GenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.HtsApproachConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.HtsTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.NewTestConverter;
import zw.gov.mohcc.mrs.ehr_mobile.util.TestForPregnantLactatingMotherConverter;


/**
 * Created by Tinotenda Ruzane
 * <p>
 * This is the local database class that will create the instance
 * of the local cache on the mobile phone
 * <p>
 * Room persistence Library will help to create the cache
 */

@Database(entities = {User.class, Authorities.class, Country.class, MaritalStatus.class, Person.class,
        Facility.class, Religion.class, Nationality.class, TestKit.class, Occupation.class, EducationLevel.class,
        HtsModel.class, EntryPoint.class, PurposeOfTest.class, ReasonForNotIssuingResult.class, BloodPressure.class,
        Temperature.class, RespiratoryRate.class, Weight.class, Height.class, Pulse.class, Visit.class,
        LaboratoryInvestigationTest.class, Investigation.class, Sample.class, LaboratoryTest.class,
        LaboratoryInvestigation.class, PersonInvestigation.class, Result.class, Town.class, Hts.class, PatientPhoneNumber.class,
        InvestigationResult.class, ArtStatus.class, ArtReason.class, Art.class, ArtInitiation.class, ArvCombinationRegimen.class}, version = 41, exportSchema = false)

@TypeConverters({GenderConverter.class, CoupleCounsellingConverter.class,
        HtsApproachConverter.class, TestForPregnantLactatingMotherConverter.class, NewTestConverter.class,
        HtsTypeConverter.class})
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

    public abstract TownsDao townsDao();

    public abstract AuthoritiesDao authoritiesDao();

    public abstract CountryDao countryDao();

    public abstract MaritalStatusDao maritalStateDao();

    public abstract ReligionDao religionDao();

    public abstract OccupationDao occupationDao();

    public abstract NationalityDao nationalityDao();

    public abstract EducationLevelDao educationLevelDao();

    public abstract PersonDao personDao();

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

    public abstract PurposeOfTestDao purposeOfTestDao();

    public abstract SampleDao sampleDao();

    public abstract LaboratoryTestDao laboratoryTestDao();

    public abstract InvestigationDao investigationDao();

    public abstract PersonInvestigationDao personInvestigationDao();

    public abstract HtsDao htsDao();

    public abstract ResultDao resultDao();

    public abstract LaboratoryInvestigationTestDao labInvestTestdao();

    public abstract LaboratoryInvestigationDao laboratoryInvestigationDao();

    public abstract PatientPhoneDao patientPhoneDao();

    public abstract InvestigationResultDao investigationResultDao();

    public abstract ArtStatusDao artStatusDao();

    public abstract ArtReasonDao artReasonDao();

    public abstract ArtRegistrationDao artRegistrationDao();

    public abstract ArtInitiationDao artInitiationDao();

    public abstract ArvCombinationRegimenDao arvCombinationRegimenDao();
}
