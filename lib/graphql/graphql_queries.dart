

class PersonQuery {

  String getAll(){
    return """ 
        query GetPatientsQuery{
                    
            people(text: "", page: 0, size: 3, sort: "") {
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
                  temperatures{
                    readingId
                    value
                  }
                  bloodPressures{
                    systolic
                    diastolic
                  }
                  weight {
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
                  stages{
                    artStageId
                    stage
                  }
                }
              }
            }

          }
      """;
  }

}