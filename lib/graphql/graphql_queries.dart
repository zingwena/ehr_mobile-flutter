

  class PersonQuery {

    String getAll(){
      return """ 
        query GetPatientsQuery{
<<<<<<< HEAD
  
            people(text: "", page: 0, size: 3, sort: "") {
                content {
=======
            
            people(text: "", page: 0, size: 10000, sort: "") {
              content {
>>>>>>> c12c72970ea8d3d1661baa14645cbee29a6a0ab8
                personId
                firstname
                lastname
                phones {
<<<<<<< HEAD
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
=======
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
                  investigations{
                    personInvestigationId
                    investigationId
                    date
                    result{
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
                  facility{
                    id
                    name
                  }
                  hts {
>>>>>>> c12c72970ea8d3d1661baa14645cbee29a6a0ab8
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
<<<<<<< HEAD
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

=======
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
                    purpose{
                      id
                    }
                  }
                }
              }
            }

          }
>>>>>>> c12c72970ea8d3d1661baa14645cbee29a6a0ab8
      """;
    }

  }