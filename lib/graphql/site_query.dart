

class SiteQuery {

  String getAll(){
    return """ 
        query SiteQuery{

    site(siteId: "7559685968") {
        siteId
        name
    }
}
      """;
  }

}