

  class PersonQuery {

    String getAll(){
      return """ 
        query GetPatientsQuery{
            
            people(text: "", page: 0, size: 100000, sort: "") {
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
                visitHistory {
                  patientId
                  time
                  type
                  hospitalNumber
                  discharged
                  registeredOnArt
                  cbsNotificationDone
                  screenTbPatient
                  facility{
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
              }
            }

          }
      """;
    }

  }