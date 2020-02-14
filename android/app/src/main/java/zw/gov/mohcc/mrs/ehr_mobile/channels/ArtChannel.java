package zw.gov.mohcc.mrs.ehr_mobile.channels;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.Date;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.view.FlutterView;
import zw.gov.mohcc.mrs.ehr_mobile.constant.APPLICATION_CONSTANTS;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtAppointmentDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtCurrentStatusDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtFollowUpDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtIptDTO;
import zw.gov.mohcc.mrs.ehr_mobile.dto.ArtVisitDTO;
import zw.gov.mohcc.mrs.ehr_mobile.enumeration.WorkArea;
import zw.gov.mohcc.mrs.ehr_mobile.model.art.ArtOi;
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
                        if (methodCall.method.equals("getArt")) {
                            Log.i(TAG, "person id sent from flutter " + arguments);
                            try {
                                ArtDTO artdto = artService.getArt(arguments);
                                String art = gson.toJson(artdto);
                                result.success(art);

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();

                            }

                        }

                        if (methodCall.method.equals("saveArtInitiation")) {
                            try {

                                ArtCurrentStatusDTO artCurrentStatusDTO = gson.fromJson(arguments, ArtCurrentStatusDTO.class);
                                result.success(gson.toJson(artService.initiatePatientOnArt(artCurrentStatusDTO)));
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
                                result.success(gson.toJson(artService.findByWorkAreaAndCategoryId(WorkArea.ART, APPLICATION_CONSTANTS.REASON_FOR_HIV_TEST_CATEGORY_ID)));

                            } catch (Exception e) {
                                System.out.println("something went wrong " + e.getMessage());
                            }
                        }
                        if (methodCall.method.equals("getTbScreening")) {
                            Log.i(TAG, "PersonId String object from flutter " + arguments);
                            try {
                                result.success(gson.toJson(artService.getVisitTbScreening(arguments)));

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
                                List<ArtSymptom> artSymptoms = artService.getArtSymptoms(arguments);
                                Log.d(TAG, "ART SYMPTOMS ART SYMPTOMS ART SYMPTOMS : " + artSymptoms);
                                result.success(gson.toJson(artSymptoms));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveArtSymptom")) {
                            Log.i(TAG, "ArtSymptom object from flutter " + arguments);
                            try {
                                ArtSymptom artSymptom = gson.fromJson(arguments, ArtSymptom.class);
                                result.success(gson.toJson(artService.saveArtSymptom(artSymptom)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("removeArtSymptom")) {
                            Log.i(TAG, "ArtSymptom ID object from flutter " + arguments);
                            try {
                                artService.removeArtSymptom(arguments);

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtNewOi")) {
                            Log.i(TAG, "PersonId String object from flutter " + arguments);
                            try {
                                result.success(gson.toJson(artService.getArtNewOi(arguments)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveArtNewOi")) {
                            Log.i(TAG, "Art New OI object from flutter " + arguments);
                            try {
                                ArtOi artOi = gson.fromJson(arguments, ArtOi.class);
                                result.success(gson.toJson(artService.saveArtNewOi(artOi)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("removeArtNewOi")) {
                            Log.i(TAG, "Art New OI ID from flutter " + arguments);
                            try {
                                artService.removeArtNewOi(arguments);

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getFamilyPlanningStatus")) {
                            try {
                                result.success(gson.toJson(ehrMobileDatabase.familyPlanningStatusDao().findAll()));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getFunctionalStatus")) {
                            try {
                                result.success(gson.toJson(ehrMobileDatabase.functionalStatusDao().findAll()));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getLactatingStatus")) {
                            try {
                                result.success(gson.toJson(ehrMobileDatabase.lactatingStatusDao().findAll()));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtVisitType")) {
                            try {
                                result.success(gson.toJson(ehrMobileDatabase.artVisitTypeDao().findAll()));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtVisitStatus")) {
                            try {
                                result.success(gson.toJson(ehrMobileDatabase.artVisitStatusDao().findAll()));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getFollowUpStatus")) {
                            try {
                                result.success(gson.toJson(ehrMobileDatabase.followUpStatusDao().findAll()));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getFollowUpReason")) {
                            try {
                                result.success(gson.toJson(ehrMobileDatabase.followUpReasonDao().findAll()));
                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getIptReason")) {
                            try {

                                result.success(gson.toJson(ehrMobileDatabase.iptReasonDao().findAll()));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getIptStatus")) {
                            try {
                                result.success(gson.toJson(ehrMobileDatabase.iptStatusDao().findAll()));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtVisit")) {
                            try {
                                result.success(gson.toJson(artService.getArtVisit(arguments)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveArtVisit")) {
                            Log.i(TAG, "ArtVisit object from flutter " + arguments);
                            try {
                                ArtVisitDTO artVisitDTO = gson.fromJson(arguments, ArtVisitDTO.class);
                                result.success(gson.toJson(artService.saveArtVisit(artVisitDTO)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtIpt")) {
                            Log.i(TAG, "PersonId String object from flutter " + arguments);
                            try {
                                Log.d(TAG, "ART IPT FROM ANDROID IN CHANNEL" + gson.toJson(artService.getArtIpt(arguments)));
                                result.success(gson.toJson(artService.getArtIpt(arguments)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveArtIpt")) {
                            Log.i(TAG, "ArtIPT object from flutter " + arguments);
                            try {
                                ArtIptDTO artIptDTO = gson.fromJson(arguments, ArtIptDTO.class);
                                result.success(gson.toJson(artService.saveArtIpt(artIptDTO)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtAppointment")) {
                            Log.i(TAG, "PersonId String object from flutter " + arguments);
                            try {
                                result.success(gson.toJson(artService.getArtAppointment(arguments)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveArtAppointment")) {
                            Log.i(TAG, "ArtAppointment object from flutter " + arguments);
                            try {
                                ArtAppointmentDTO artAppointmentDTO = gson.fromJson(arguments, ArtAppointmentDTO.class);
                                result.success(gson.toJson(artService.saveArtAppointment(artAppointmentDTO)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtAppointments")) {
                            Log.i(TAG, "PersonId String object from flutter " + arguments);
                            try {
                                Log.i(TAG, "ART Appointments in android" + gson.toJson(artService.getPersonArtAppointments(arguments).toString()));
                                result.success(gson.toJson(artService.getPersonArtAppointments(arguments)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("getArtFollowUp")) {
                            Log.i(TAG, "Current art followup id " + arguments);
                            try {
                                result.success(gson.toJson(artService.getArtFollowUp(arguments)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveArtFollowUpVisit")) {
                            Log.i(TAG, "ArtFollowUpVisit object from flutter " + arguments);
                            try {
                                ArtFollowUpDTO artFollowUpVisitDTO = gson.fromJson(arguments, ArtFollowUpDTO.class);
                                result.success(gson.toJson(artService.saveArtFollowUpVisit(artFollowUpVisitDTO)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                        if (methodCall.method.equals("saveArtFollowUpCall")) {
                            Log.i(TAG, "ArtFollowUpCall object from flutter " + arguments);
                            try {
                                ArtFollowUpDTO artFollowUpCallDTO = gson.fromJson(arguments, ArtFollowUpDTO.class);
                                result.success(gson.toJson(artService.saveArtFollowUpCall(artFollowUpCallDTO)));

                            } catch (Exception e) {
                                Log.d(TAG, "something went wrong " + e.getMessage());
                                e.printStackTrace();
                            }
                        }
                    }
                });
    }
}
