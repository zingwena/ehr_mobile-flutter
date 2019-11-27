
class SexConverter{

  const SexConverter();
  String fromInt(int sex){
    String gender;
    switch(sex){
      case 0:gender= 'MALE'; break;
      case 1:gender= 'FEMALE'; break;
      case 2:gender= 'UNKNOWN'; break;
      case 3:gender= 'NON_BINARY'; break;
      case -1:gender= 'NULL_VALS'; break;
      default:
        gender= 'UNKNOWN';
    }
    return gender;
  }

  int fromString(String sex){
    int gender;
    switch(sex){
      case 'MALE':gender= 0; break;
      case 'FEMALE':gender= 1; break;
      case 'UNKNOWN':gender= 2; break;
      case 'NON_BINARY':gender=3; break;
      case 'NULL_VALS':gender= -1; break;
      default:
        gender= 3;
    }
    return gender;
  }

}