
class TotalPatientsQuery {

  String getAll(){
    return """ 
        query TotalPatientsQuery {
     
              people(text: "", page: 0, size: 100, sort: "") {
                size
                totalPages
                totalElements
              }
                
          }
      """;
  }

}