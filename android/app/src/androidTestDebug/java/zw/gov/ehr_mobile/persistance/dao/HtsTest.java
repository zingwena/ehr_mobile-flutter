package zw.gov.ehr_mobile.persistance.dao;

import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import android.support.test.InstrumentationRegistry;
import android.support.test.runner.AndroidJUnit4;

import androidx.room.Room;

import java.util.List;

import retrofit2.Call;
import retrofit2.Retrofit;
import zw.gov.mohcc.mrs.ehr_mobile.configuration.RetrofitClient;
import zw.gov.mohcc.mrs.ehr_mobile.model.InvestigationEhr;
import zw.gov.mohcc.mrs.ehr_mobile.model.LaboratoryTest;

import zw.gov.mohcc.mrs.ehr_mobile.model.Login;
import zw.gov.mohcc.mrs.ehr_mobile.model.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.TestKit;
import zw.gov.mohcc.mrs.ehr_mobile.model.Token;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.LaboratoryTestDao;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.DataSyncService;

/**
 * @author kombo on 8/27/19
 */
@RunWith(AndroidJUnit4.class)
public class HtsTest {

    private EhrMobileDatabase db;

    @Before
    public void initDb() throws Exception {
        this.db = Room.inMemoryDatabaseBuilder(InstrumentationRegistry.getContext(),
                EhrMobileDatabase.class)
                .allowMainThreadQueries()
                .build();

        Login login = new Login("admin", "admin");

//        LoginValidator.isValid(login);


        Retrofit retrofitInstance = RetrofitClient.getRetrofitInstance("http://10.20.101.91:8080" + "/api/");
        DataSyncService dataSyncService = retrofitInstance.create(DataSyncService.class);
        Call<Token> call = dataSyncService.dataSync(login);
        call.execute();
    }

    @Test
    public void getInitialTestCount(){
        String sample="Blood";
        String investigationId=" ee7d91fc-b27f-11e8-b121-c48e8faf029b";
        String test="HIV";
        InvestigationEhr investigation=new InvestigationEhr(investigationId,sample,test);

        HtsTestProcedure htsTestProcedure=new HtsTestProcedure(investigation);
//        htsTestProcedure.getTestKits(count);
//
//        Assert.assertEquals(0,count);
    }


    @Test
    public void getTestKits(){
        List<Person> people = db.patientDao().listPatients();
        Assert.assertEquals(0, people.size());

    }

    @Test
    public void assertThatTestKitsAreNotFound(){
        List<TestKit> testKits= db.testKitDao().findTestKitsByLevel("THIRD");
        Assert.assertEquals(8,testKits.size());

    }
    public void getLabTestId() throws NullPointerException {
        LaboratoryTestDao laboratoryTestDao = db.laboratoryTestDao();
        List<LaboratoryTest> laboratoryTests=laboratoryTestDao.getLaboratoryTests();


        for (LaboratoryTest a:laboratoryTests
             ) {
            System.out.println("a.getName() = " + a.getName());
        }
        Assert.assertNotNull(laboratoryTests);
    }
    @After
    public void closeDb() throws NullPointerException {
      db.close();

    }


}
