

class PersonQuery {

  String getAll(){
    return """ 
        query GetPatientsQuery {
             
             people(text: "", page: 0, size: 100, sort: "") {
                content {
                  personId
                  firstname
                  lastname
                  phones {
                    number
                    phoneId
                  }
                  sex
                  identifications {
                    number
                    type {
                      name
                    }
                  }
                  occupation {
                    id
                    name
                  }
                  identifications {
                    identificationId
                  }
                  selfIdentifiedGender
                  religion {
                    name
                    id
                  }
                  education {
                    id
                    name
                  }
                  marital {
                    name
                    id
                  }
                  birthdate
                  nationality {
                    id
                    name
                  }
                  countryOfBirth {
                    id
                    name
                  }
                  address {
                    city
                    town {
                      name
                    }
                    street
                  }
                  age {
                    years
                  }
                  hivStatus {
                    date
                    status
                  }
                  history {
                    sexualHistory {
                      sexualHistoryId
                      personId
                      sexuallyActive
                      sexWithMaleDate
                      sexWithFemaleDate
                      numberOfSexualPartners
                      numberOfSexualPartnersLastTwelveMonths
                      questions {
                        sexualHistoryQuestionId
                        question {
                          id
                          name
                          responseType
                        }
                      }
                    }
                    investigations {
                      personInvestigationId
                      investigationId
                      date
                      result {
                        id
                        name
                      }
                    }
                  }
                  visitHistory {
                    patientId
                    time
                    type
                    hospitalNumber
                    discharged
                    registeredOnArt
                    cbsNotificationDone
                    screenTbPatient
                    temperatures {
                      readingId
                      unit
                      value
                    }
                    bloodPressures {
                      systolic
                      diastolic
                    }
                    weight {
                      value
                    }
                    height{
                      value
                    }
                    pulses{
                      value
                    }
                    respiratoryRates{
                      value
                    }
                    facility {
                      id
                      name
                    }
                    hts {
                      htsId
                      date
                      coupleCounselling
                      approach
                      retest
                      preTestInformationGiven
                      resultsIssued
                      testForPregnancy
                      postTestCounselling
                      htsNumber
                      optOut
                      postDateCounselled
                      dateOfHivTest
                      pregnant
                      lactating
                      consentToIndexTesting
                      htsType
                      selfTestPositive
                      startedLactating
                      reasonForNotInitiatingArt
                      reasonForNotPerformingTest
                      firstHivTest
                      performDnaPcr
                      dnaPcrInvestigationOrderId
                      dnaPcrDone
                      recencyInvestigationOrderId
                      clientAlreadyPositive
                      clientAlreadyOnArt
                      purpose {
                        id
                      }
                      laboratoryInvestigation {
                        laboratoryInvestigationId
                        date
                        date
                        investigationId
                        resultDate
                        status
                        investigationType
                        openHivTest
                        tests {
                          laboratoryInvestigationTestId
                          time
                          readingTime
                          methodOfResult
                          clientTestedOnsite
                          clientAssistedSelfTest
                          username
                          batchIssue{
                            batchIssueId
                          }
                          result{
                            id
                            name
                          }
                        }
                      }
                      entryPoint {
                        id
                      }
                      model {
                        id
                      }
                      reasonForNotIssuingResult {
                        id
                      }
                    }
                  }
                  art {
                    artId
                    artNumber
                    dateEnrolled
                    dateOfHivTest
                    date
                    enlargedLymphNode
                    pallor
                    jaundice
                    cyanosis
                    mentalStatus
                    centralNervousSystem
                    tracing
                    followUp
                    hivStatus
                    relation
                    dateOfDisclosure
                    reason
                    ipt{
                      artIptStatusId
                      date
                      status{
                        id
                        name
                      }
                      reason{
                        id
                        name
                      }
                    }
                    symptoms {
                      artSymptomId
                      date
                      present
                      Symptom {
                        id
                        name
                      }
                    }
                    ois {
                      artOiId
                      date
                      oi {
                        id
                        name
                      }
                    }
                    artLinkagesFrom {
                      artLinkageFromId
                      linkageFrom
                      linkageNumber
                      dateHivConfirmed
                      otherInstitution
                      hivTestUsed
                      reTested
                      dateRetested
                      testReason{
                        id
                        name
                      }
                      facility{
                        id
                        name
                      }
                    }
                    appointments {
                      artAppointmentId
                      artId
                      date
                      followupDate
                      daysToAppointment
                      appointmentOutcomeDate
                      expectedToday
                      missed
                      defaulter
                      due
                      followupReason {
                        id
                        name
                      }
                      appointmentOutcome {
                        id
                        name
                      }
                    }
                    artCurrentStatus {
                      artStatusId
                      date
                      state
                      regimenType
                      medicine
                      reason{
                        id
                        name
                      }
                      regimen{
                        id
                        name
                      }
                      adverseEventStatus {
                        id
                        name
                      }
                    }
                    visits {
                      visitId
                      date
                      ancFirstBookingDate
                      viralLoad
                      cd4Count
                      cotrimoxazole
                      fluconazole
                      visitStatus {
                        id
                        name
                      }
                      lactatingStatus{
                        id
                        name
                      }
                      familyPlanningStatus {
                        id
                        name
                      }
                      visitType{
                        id
                        name
                      }
                      stage {
                        artStageId
                        stage
                        followUpStatus {
                          id
                          name
                        }
                      }
                    }
                  }
                }
              }
                
          }
      """;
  }

}