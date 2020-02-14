
class PatientQueQuery {

  String getAll(){
    return """ 
        query PatientQueQuery{

          queues(text: "", page: 0, sort: "", size: 100) {
            content {
              queue {
                id
                name
              }
              patients(text: "", page: 0, sort: "", size: 100) {
                content {
                  patientId
                }
              }
            }
          }
        
        }
      """;
  }

}