
class ResponseTypeConvertor{

  const ResponseTypeConvertor();
  String fromInt(int responseType){
    String type;
    switch(responseType){
      case 0:type= 'NO'; break;
      case 1:type= 'YES'; break;
      case 2:type= 'REFUSED'; break;
    }
    return type;
  }

  int fromString(String type){
    int responseType;
    switch(type){
      case 'NO':responseType= 0; break;
      case 'YES':responseType= 1; break;
      case 'REFUSED':responseType= 2; break;
    }
    return responseType;
  }

}