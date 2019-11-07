package zw.gov.mohcc.mrs.ehr_mobile.service;


import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.POST;
import retrofit2.http.Path;
import zw.gov.mohcc.mrs.ehr_mobile.dto.IdentityDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.PatientSyncDto;
import zw.gov.mohcc.mrs.ehr_mobile.dto.RegisterPersonDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.ArtReasonModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationResultModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.NameIdSynchModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.Nationality;
import zw.gov.mohcc.mrs.ehr_mobile.model.Occupation;
import zw.gov.mohcc.mrs.ehr_mobile.model.TerminologyModel;
import zw.gov.mohcc.mrs.ehr_mobile.model.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.model.User;

public interface DataSyncService {

    @GET("nationalities")
    Call<Nationality> getNationality(@Header("Authorization") String token);

    @GET("occupations")
    Call<Occupation> getAllOccupations(@Header("Authorization") String token);


    @POST("authenticate")
    Call<Token> dataSync(@Body Login login);


    @GET("users")
    Call<List<User>> getAllUsers(@Header("Authorization") String token);

    @GET("towns")
    Call<TerminologyModel> getTowns(@Header("Authorization") String token);

    @GET("marital-states")
    Call<TerminologyModel> getMaritalStates(@Header("Authorization") String token);

    @GET("countries")
    Call<TerminologyModel> getCountries(@Header("Authorization") String authToken);

    @GET("nationalities")
    Call<TerminologyModel> getNationalities(@Header("Authorization") String authToken);

    @GET("occupations")
    Call<TerminologyModel> getOccupation(@Header("Authorization") String token);

    @GET("facilities")
    Call<TerminologyModel> getFacilities(@Header("Authorization") String authToken);

    @GET("religions")
    Call<TerminologyModel> getReligion(@Header("Authorization") String token);

    @GET("education-levels")
    Call<TerminologyModel> getEducationLevels(@Header("Authorization") String token);

    @GET("entryPoints")
    Call<TerminologyModel> getEntryPoints(@Header("Authorization") String token);

    @GET("hts-models")
    Call<TerminologyModel> getHtsModels(@Header("Authorization") String token);

    @GET("reason-for-not-issuing-results")
    Call<TerminologyModel> getReasonForNotIssuingResults(@Header("Authorization") String token);

    @GET("purpose-of-tests")
    Call<TerminologyModel> getPurpose_Of_Tests(@Header("Authorization") String token);

    @GET("test-kits/test-level/{LEVEL}")
    Call<List<TestKit>> getTestKits(@Header("Authorization") String token, @Path("LEVEL") String level);

    @GET("laboratory-tests")
    Call<TerminologyModel> getLaboratoryTests(@Header("Authorization") String token);

    @GET("samples")
    Call<TerminologyModel> getSamples(@Header("Authorization") String token);

    @GET("investigations")
    Call<InvestigationModel> getInvestigations(@Header("Authorization") String token);

    @GET("investigations/result")
    Call<InvestigationResultModel> getInvestigationResults(@Header("Authorization") String token);

    @GET("lab-results")
    Call<TerminologyModel> getLaboratoryResults(@Header("Authorization") String token);

    @GET("art-statuses")
    Call<TerminologyModel> getArtStatuses(@Header("Authorization") String token);

    @GET("art-reasons")
    Call<ArtReasonModel> getArtReasons(@Header("Authorization") String token);

    @GET("arv-combination-regimens")
    Call<TerminologyModel> getArvCombinationRegimen(@Header("Authorization") String token);

    @GET("disclosure-methods")
    Call<NameIdSynchModel> getDisclosureMethods(@Header("Authorization") String token);

    @GET("testing-plans")
    Call<NameIdSynchModel> getTestPlans(@Header("Authorization") String token);

    @POST("people")
    Call<IdentityDTO> registerPerson(@Header("Authorization") String token, @Body RegisterPersonDTO registerPersonDTO);

    @POST("people/update-patient")
    Call<IdentityDTO> updatePatient(@Header("Authorization") String token, @Body PatientSyncDto patientSyncDto);
}
