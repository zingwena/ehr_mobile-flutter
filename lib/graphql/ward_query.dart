


class WardQuery {

  String getAll(){
    return """ 
        query WardQuery{

    wards(text: "", page: 0, sort: "", size: 100) {
        content {
            wardId
            ward {
                id
                name
            }
            type
            #beds
            department {
                id
                name
            }
            patients(text: "", page: 0, size: 1, sort: "") {
                totalElements
            }
            currentTestKits(text: "", page: 0, sort: "", size: 100) {
                content {
                    batchIssueId
                    binType
                    quantity
                    date
                    remaining
                    statusAccepted
                    expiredStatus
                    daysToExpiry
                    totalQuantityReceived
                    nearExpiry
                    batch {
                        batchNumber
                        expiryDate
                        testKit{
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