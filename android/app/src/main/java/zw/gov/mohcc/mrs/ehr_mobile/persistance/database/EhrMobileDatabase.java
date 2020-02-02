package zw.gov.mohcc.mrs.ehr_mobile.persistance.database;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;
import androidx.room.TypeConverters;

import zw.gov.mohcc.mrs.ehr_mobile.converter.ActivityStatusConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.AgeGroupConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.ArvStatusConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.BinTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.CoupleCounsellingConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.GenderConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.HivTestUsedConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.HtsApproachConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.HtsTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.LinkageFromConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.MedicineCategoryConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.MedicineLevelConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.NewTestConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.NormalityConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.PatientTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.PrepOptionConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.QuestionTyeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.ReasonOfNotDisclosingConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.RegimenTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.RelationshipTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.ResponseTypeConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.TestForPregnantLactatingMotherConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.TestLevelConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.TypeOfContactConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.WhoStageConverter;
import zw.gov.mohcc.mrs.ehr_mobile.converter.WorkAreaConverter;
import zw.gov.mohcc.mrs.ehr_mobile.model.Authorities;
import zw.gov.mohcc.mrs.ehr_mobile.model.FacilityWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.PatientWard;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.Art;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtLinkageFrom;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.Hts;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.HtsScreening;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexContact;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.IndexTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.SexualHistory;
import zw.gov.mohcc.mrs.ehr_mobile.model.hts.SexualHistoryQuestion;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.LaboratoryInvestigationTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.laboratory.PersonInvestigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.PersonPhone;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Relationship;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtVisitType;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Country;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Diagnosis;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.DisclosureMethod;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EducationLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.EntryPoint;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Facility;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FamilyPlanningStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FollowUpStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.FunctionalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.HtsModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Investigation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationTestkit;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.IptReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LaboratoryTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.LactatingStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.MaritalStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.MedicineName;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.PurposeOfTest;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Question;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionCategory;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ReasonForNotIssuingResult;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Religion;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Result;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Sample;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.SiteSetting;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKitTestLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestingPlan;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.Town;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.BloodPressure;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.FacilityQueue;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Height;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Pulse;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.RespiratoryRate;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Temperature;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Visit;
import zw.gov.mohcc.mrs.ehr_mobile.model.vitals.Weight;
import zw.gov.mohcc.mrs.ehr_mobile.model.warehouse.TestKitBatchIssue;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtCurrentStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtLinkageFromDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtReasonDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtVisitStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArtVisitTypeDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ArvCombinationRegimenDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.AuthoritiesDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.CountryDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.DiagnosisDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.DisclosureMethodDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.EducationLevelDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.EntryPointDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.FacilityDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.FacilityQueueDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.FacilityWardDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.FamilyPlanningStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.FollowUpStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.FunctionalStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.HtsDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.HtsModelDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.HtsScreeningDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.IndexContactDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.IndexTestDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.InvestigationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.InvestigationResultDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.InvestigationTestkitDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.IptReasonDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.LaboratoryInvestigationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.LaboratoryInvestigationTestDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.LaboratoryTestDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.LactatingStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.MaritalStatusDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.MedicineNameDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.NationalityDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.OccupationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PatientQueueDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PatientWardDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PersonDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PersonInvestigationDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PersonPhoneDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.PurposeOfTestDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.QuestionCategoryDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.QuestionDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ReasonForNotIssuingResultDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.RelationshipDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ReligionDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.ResultDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.SampleDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.SexualHistoryDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.SexualHistoryQuestionDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.SiteSettingDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.TestKitBatchIssueDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.TestKitDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.TestKitTestLevelDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.TestingPlanDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.TownsDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.UserDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.BloodPressureDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.HeightDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.PulseDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.RespiratoryRateDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.TemperatureDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.VisitDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.vitalsDao.WeightDao;


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
        LaboratoryInvestigation.class, PersonInvestigation.class, Result.class, Town.class, Hts.class, PersonPhone.class,
        InvestigationResult.class, ArtStatus.class, ArtReason.class, Art.class, ArtCurrentStatus.class,
        ArvCombinationRegimen.class, SexualHistory.class, HtsScreening.class, TestingPlan.class, DisclosureMethod.class,
        IndexTest.class, IndexContact.class, Relationship.class, TestKitTestLevel.class, InvestigationTestkit.class,
        FacilityQueue.class, FacilityWard.class, PatientQueue.class, PatientWard.class, SiteSetting.class,
        Diagnosis.class, QuestionCategory.class, Question.class, SexualHistoryQuestion.class, TestKitBatchIssue.class,
        FollowUpStatus.class, FunctionalStatus.class, FamilyPlanningStatus.class, LactatingStatus.class, MedicineName.class,
        ArtVisitType.class, ArtVisitStatus.class, IptReason.class, ArtLinkageFrom.class}, version = 7, exportSchema = false)

@TypeConverters({GenderConverter.class, CoupleCounsellingConverter.class,
        HtsApproachConverter.class, TestForPregnantLactatingMotherConverter.class, NewTestConverter.class,
        HtsTypeConverter.class, ActivityStatusConverter.class, PrepOptionConverter.class, RelationshipTypeConverter.class,
        TypeOfContactConverter.class, TestLevelConverter.class, RegimenTypeConverter.class, AgeGroupConverter.class,
        PatientTypeConverter.class, QuestionTyeConverter.class, ResponseTypeConverter.class, WorkAreaConverter.class, BinTypeConverter.class,
        MedicineCategoryConverter.class, MedicineLevelConverter.class, WhoStageConverter.class, ArvStatusConverter.class,
        ReasonOfNotDisclosingConverter.class, NormalityConverter.class, LinkageFromConverter.class, HivTestUsedConverter.class})
public abstract class EhrMobileDatabase extends RoomDatabase {

    public static volatile EhrMobileDatabase INSTANCE;

    public static EhrMobileDatabase getDatabaseInstance(final Context context) {
        if (INSTANCE == null) {
            synchronized (EhrMobileDatabase.class) {
                if (INSTANCE == null) {

                    INSTANCE = Room.databaseBuilder(context.getApplicationContext(),
                            EhrMobileDatabase.class, "newImpilo")
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

    public abstract PersonPhoneDao patientPhoneDao();

    public abstract InvestigationResultDao investigationResultDao();

    public abstract ArtStatusDao artStatusDao();

    public abstract ArtReasonDao artReasonDao();

    public abstract ArtDao artDao();

    public abstract ArtCurrentStatusDao artInitiationDao();

    public abstract ArvCombinationRegimenDao arvCombinationRegimenDao();

    public abstract SexualHistoryDao sexualHistoryDao();

    public abstract HtsScreeningDao htsScreeningDao();

    public abstract TestingPlanDao testingPlanDao();

    public abstract DisclosureMethodDao disclosureMethodDao();

    public abstract IndexTestDao indexTestDao();

    public abstract IndexContactDao indexContactDao();

    public abstract RelationshipDao relationshipDao();

    public abstract TestKitTestLevelDao testKitTestLevelDao();

    public abstract InvestigationTestkitDao investigationTestkitDao();

    public abstract FacilityQueueDao facilityQueueDao();

    public abstract FacilityWardDao facilityWardDao();

    public abstract PatientQueueDao patientQueueDao();

    public abstract PatientWardDao patientWardDao();

    public abstract SiteSettingDao siteSettingDao();

    public abstract DiagnosisDao diagnosisDao();

    public abstract QuestionCategoryDao questionCategoryDao();

    public abstract QuestionDao questionDao();

    public abstract SexualHistoryQuestionDao sexualHistoryQuestionDao();

    public abstract TestKitBatchIssueDao testKitBatchIssueDao();

    public abstract FollowUpStatusDao followUpStatusDao();

    public abstract FunctionalStatusDao functionalStatusDao();

    public abstract FamilyPlanningStatusDao familyPlanningStatusDao();

    public abstract LactatingStatusDao lactatingStatusDao();

    public abstract MedicineNameDao medicineNameDao();

    public abstract IptReasonDao iptReasonDao();

    public abstract ArtVisitTypeDao artVisitTypeDao();

    public abstract ArtVisitStatusDao artVisitStatusDao();

    public abstract ArtLinkageFromDao artLinkageFromDao();
}
