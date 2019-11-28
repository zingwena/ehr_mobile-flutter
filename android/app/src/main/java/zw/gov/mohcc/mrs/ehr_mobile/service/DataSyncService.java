package zw.gov.mohcc.mrs.ehr_mobile.service;


import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.POST;
import retrofit2.http.Path;
import retrofit2.http.Query;
import zw.gov.mohcc.mrs.ehr_mobile.dto.IdentityDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.RegisterPersonDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.TestLevel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReasonModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimenModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationResultModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.InvestigationTestkitModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.NameIdSynchModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionCategoryModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.QuestionModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.TestKitModel;
import zw.gov.mohcc.mrs.sync.adapter.dto.PatientSyncDto;
import zw.gov.mohcc.mrs.sync.adapter.dto.PersonResponseDto;

public interface DataSyncService {

    @POST("authenticate")
    Call<Token> dataSync(@Body Login login);

    @GET("users")
    Call<List<User>> getAllUsers(@Header("Authorization") String token, @Query("size") int size);

    @GET("towns")
    Call<TerminologyModel> getTowns(@Header("Authorization") String token, @Query("size") int size);

    @GET("marital-states")
    Call<TerminologyModel> getMaritalStates(@Header("Authorization") String token, @Query("size") int size);

    @GET("countries")
    Call<TerminologyModel> getCountries(@Header("Authorization") String authToken, @Query("size") int size);

    @GET("nationalities")
    Call<TerminologyModel> getNationalities(@Header("Authorization") String authToken, @Query("size") int size);

    @GET("occupations")
    Call<TerminologyModel> getOccupation(@Header("Authorization") String token, @Query("size") int size);

    @GET("facilities")
    Call<TerminologyModel> getFacilities(@Header("Authorization") String authToken, @Query("size") int size);

    @GET("religions")
    Call<TerminologyModel> getReligion(@Header("Authorization") String token, @Query("size") int size);

    @GET("education-levels")
    Call<TerminologyModel> getEducationLevels(@Header("Authorization") String token, @Query("size") int size);

    @GET("entryPoints")
    Call<TerminologyModel> getEntryPoints(@Header("Authorization") String token, @Query("size") int size);

    @GET("hts-models")
    Call<TerminologyModel> getHtsModels(@Header("Authorization") String token, @Query("size") int size);

    @GET("reason-for-not-issuing-results")
    Call<TerminologyModel> getReasonForNotIssuingResults(@Header("Authorization") String token, @Query("size") int size);

    @GET("purpose-of-tests")
    Call<TerminologyModel> getPurpose_Of_Tests(@Header("Authorization") String token, @Query("size") int size);

    @GET("test-kits")
    Call<TestKitModel> getAllTestKits(@Header("Authorization") String token, @Query("size") int size);

    @GET("test-kits/test-level/{LEVEL}")
    Call<List<TestKit>> getTestKitLevels(@Header("Authorization") String token, @Path("LEVEL") TestLevel level);

    @GET("laboratory-tests")
    Call<TerminologyModel> getLaboratoryTests(@Header("Authorization") String token, @Query("size") int size);

    @GET("samples")
    Call<TerminologyModel> getSamples(@Header("Authorization") String token, @Query("size") int size);

    @GET("diagnoses")
    Call<TerminologyModel> getDiagnosis(@Header("Authorization") String token, @Query("size") int size);

    @GET("investigations")
    Call<InvestigationModel> getInvestigations(@Header("Authorization") String token, @Query("size") int size);

    @GET("question-categories-other-clients")
    Call<QuestionCategoryModel> getQuestionCategories(@Header("Authorization") String token, @Query("size") int size);

    @GET("questions")
    Call<QuestionModel> getQuestions(@Header("Authorization") String token, @Query("size") int size);

    @GET("investigations/get-all-test-kits")
    Call<InvestigationTestkitModel> getInvestigationTestKits(@Header("Authorization") String token, @Query("size") int size);

    @GET("investigations/result")
    Call<InvestigationResultModel> getInvestigationResults(@Header("Authorization") String token, @Query("size") int size);

    @GET("lab-results")
    Call<TerminologyModel> getLaboratoryResults(@Header("Authorization") String token, @Query("size") int size);

    @GET("art-statuses")
    Call<TerminologyModel> getArtStatuses(@Header("Authorization") String token, @Query("size") int size);

    @GET("art-reasons")
    Call<ArtReasonModel> getArtReasons(@Header("Authorization") String token, @Query("size") int size);

    @GET("arv-combination-regimens-for-export")
    Call<ArvCombinationRegimenModel> getArvCombinationRegimen(@Header("Authorization") String token, @Query("size") int size);

    @GET("disclosure-methods")
    Call<NameIdSynchModel> getDisclosureMethods(@Header("Authorization") String token, @Query("size") int size);

    @GET("testing-plans")
    Call<NameIdSynchModel> getTestPlans(@Header("Authorization") String token, @Query("size") int size);

    @POST("people")
    Call<IdentityDTO> registerPerson(@Header("Authorization") String token, @Body RegisterPersonDTO registerPersonDTO);

    @POST("data-sync/patient")
    Call<PersonResponseDto> syncPatient(@Header("Authorization") String token, @Body PatientSyncDto patientSyncDto);
}
