package zw.gov.mohcc.mrs.ehr_mobile.channels;

import androidx.sqlite.db.SimpleSQLiteQuery;

import com.google.gson.Gson;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw.PersonQuery;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;

public class PatientChannel {
    public PatientChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase){
        new MethodChannel(flutterView, channelName).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall call, MethodChannel.Result result1) {
                final String arguments = call.arguments();
                if (call.method.equals("searchPerson")) {
                    List<Person> _list;
                    String searchItem = arguments;
                    PersonQuery personQuery = new PersonQuery();
                    SimpleSQLiteQuery sqLiteQuery = personQuery.searchPerson(searchItem);
                    _list = ehrMobileDatabase.personDao().searchPatient(sqLiteQuery);
                    if (_list.isEmpty()){
                        SimpleSQLiteQuery sqLiteQuery1= personQuery.searchPersonBySurnameAndName(searchItem);
                        _list = ehrMobileDatabase.personDao().searchPatient(sqLiteQuery1);
                    }
                    Gson gson = new Gson();
                    result1.success(gson.toJson(_list));
                }
            }

        });
    }
}
