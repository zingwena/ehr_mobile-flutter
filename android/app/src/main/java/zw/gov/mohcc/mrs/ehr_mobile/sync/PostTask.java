package zw.gov.mohcc.mrs.ehr_mobile.sync;

import android.os.AsyncTask;
import android.os.Build;

import androidx.annotation.RequiresApi;

import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class PostTask extends AsyncTask<String, Integer, String> {
    private EhrMobileDatabase ehrMobileDatabase;
    private String baseUrl;
    private String token;
    public PostTask(EhrMobileDatabase ehrMobileDatabase, String baseUrl, String token) {
        this.ehrMobileDatabase=ehrMobileDatabase;
        this.baseUrl=baseUrl;
        this.token=token;
    }

    @Override
   protected void onPreExecute() {
      super.onPreExecute();
   }
 
   @Override
   @RequiresApi(api = Build.VERSION_CODES.O)
   protected String doInBackground(String... params) {
       String value=new PatientDataSyncService(ehrMobileDatabase,baseUrl,token)
                    .syncPatient();
       try {
           Thread.sleep(5000);
       } catch (InterruptedException e) {
           e.printStackTrace();
       }
       return value;
   }
 
   @Override
   protected void onProgressUpdate(Integer... values) {
      super.onProgressUpdate(values);
   }
 
   @Override
   protected void onPostExecute(String result) {
      super.onPostExecute(result);
   }
}