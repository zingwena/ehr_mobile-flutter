package zw.gov.mohcc.mrs.ehr_mobile.channels;

import androidx.sqlite.db.SimpleSQLiteQuery;

import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

import io.flutter.Log;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.dto.RelationshipDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.RelationshipViewDTO;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Person;
import zw.gov.mohcc.mrs.ehr_mobile.model.person.Relationship;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.dao.raw.PersonQuery;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.RelationshipService;

public class PatientChannel {
    private final static String TAG = "Main Activity";

    public PatientChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, RelationshipService relationshipService){
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
                if(call.method.equals("saveRelationship")){
                    Gson gson = new Gson();
                    RelationshipDTO relationshipDTO = gson.fromJson(arguments, RelationshipDTO.class);
                    Relationship relationship = new Relationship();
                    relationship.setPersonId(relationshipDTO.getPersonId());
                    relationship.setMemberId(relationshipDTO.getMemberId());
                    relationship.setRelation(relationshipDTO.getRelation());
                    relationship.setTypeOfContact(relationshipDTO.getTypeOfContact());
                    String relation_id = relationshipService.createRelationShip(relationship);
                    Log.i(TAG, "HERE IS THE RELATIONSHIP ID " + relation_id);
                    result1.success(relation_id);
                }
                if(call.method.equals("getRelationshipList")){
                    Gson gson = new Gson();
                    List<RelationshipViewDTO> person_relationships = ehrMobileDatabase.relationshipDao().findByPersonId(arguments);

                    Log.i(TAG, "HERE IS THE LIST OF CONTACTS RETRIEVED "+ person_relationships.toString());
                    String contact_list = gson.toJson(person_relationships);
                    result1.success(contact_list);
                }
                if(call.method.equals("getPersonById")){
                    Gson gson = new Gson();
                    Person person = ehrMobileDatabase.personDao().findPatientById(arguments);
                    String person_string = gson.toJson(person);
                    result1.success(person_string);
                }
            }

        });
    }
}
