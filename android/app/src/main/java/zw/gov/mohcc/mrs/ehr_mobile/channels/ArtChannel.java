package zw.gov.mohcc.mrs.ehr_mobile.channels;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.Date;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.constant.APPLICATION_CONSTANTS;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtCurrentStatus;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtSymptom;
import zw.gov.mohcc.mrs.ehr_mobile.model.tb.TbScreening;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArtReason;
import zw.gov.mohcc.mrs.ehr_mobile.model.terminology.ArvCombinationRegimen;
import zw.gov.mohcc.mrs.ehr_mobile.persistance.database.EhrMobileDatabase;
import zw.gov.mohcc.mrs.ehr_mobile.service.ArtService;
import zw.gov.mohcc.mrs.ehr_mobile.util.DateDeserializer;


public class ArtChannel {

    private final String TAG = "ART Channel";

    public ArtChannel(FlutterView flutterView, String channelName, EhrMobileDatabase ehrMobileDatabase, ArtService artService) {
        final String index_id;
        new MethodChannel(flutterView, channelName).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        String arguments = methodCall.arguments();
                        Gson gson = new GsonBuilder().registerTypeAdapter(Date.class, new DateDeserializer()).create();

                        if (methodCall.method.equals("saveArtRegistration")) {
                            Log.i(TAG, "Artdto sent from flutter " + arguments);
                            try {
                                ArtDTO art = gson.fromJson(arguments, ArtDTO.class);
                                String response = gson.toJson(artService.createArt(art));
                                result.success(response);

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();

                            }

                        }

                        if (methodCall.method.equals("saveArtInitiation")) {
                            try {

                                ArtCurrentStatus artCurrentStatus = gson.fromJson(arguments, ArtCurrentStatus.class);
                                result.success(gson.toJson(artService.initiatePatientOnArt(artCurrentStatus)));
                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());

                            }

                        }
                        if (methodCall.method.equals("getRegimenName")) {
                            try {
                                ArvCombinationRegimen arvCombinationRegimen = ehrMobileDatabase.arvCombinationRegimenDao().findByName(arguments);
                                String regimenname = arvCombinationRegimen.getName();
                                result.success(regimenname);

                            } catch (Exception e) {

                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getReason")) {
                            try {
                                ArtReason artReason = ehrMobileDatabase.artReasonDao().findByName(arguments);
                                String reason = artReason.getName();
                                result.success(reason);

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getReasonForhivTest")) {
                            try {
                                result.success(gson.toJson(artService.findByWorkAreaAndCategoryId(WorkArea.ART, APPLICATION_CONSTANTS.ART_CATEGORY_ID)));

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getTbScreening")) {
                            Log.i(TAG, "PersonId String object from flutter " + arguments);
                            try {
                                result.success(artService.getVisitTbScreening(arguments));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveTbScreening")) {
                            Log.i(TAG, "TbScreening object from flutter " + arguments);
                            try {
                                TbScreening tbScreening = gson.fromJson(arguments, TbScreening.class);
                                result.success(gson.toJson(artService.saveTbScreening(tbScreening)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtSymptom")) {
                            Log.i(TAG, "PersonId String object from flutter " + arguments);
                            try {
                                result.success(artService.getArtSymptoms(arguments));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveArtSymptom")) {
                            Log.i(TAG, "ArtSymptom object from flutter " + arguments);
                            try {
                                ArtSymptom artSymptom = gson.fromJson(arguments, ArtSymptom.class);
                                artService.saveArtSymptom(artSymptom);

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                    }
                });
    }
}
