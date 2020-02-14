


class WardQuery {

  String getAll(){
    return """ 
        query WardQuery{
            
            wards(text: "", page: 0, sort: "", size: 100) {
                content {
                  wardId
                  department {
                    id
                    name
                  }
                  ward {
                    id
                    name
                  }
                }
              }
            
        }
      """;
  }

}