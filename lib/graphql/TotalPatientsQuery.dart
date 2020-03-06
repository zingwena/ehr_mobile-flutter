
class TotalPatientsQuery {

  String getAll(){
    return """ 
        query TotalPatientsQuery {
     
              people(text: "", page: 0, size: 1, sort: "") {
                size
                totalPages
                totalElements
              }
                
          }
      """;
  }

}