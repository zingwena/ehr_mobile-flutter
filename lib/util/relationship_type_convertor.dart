
class RelationTypeConvertor{

  const RelationTypeConvertor();
  String fromInt(int type){
    String relation;
    switch(type){
      case 0:relation= 'CHILD'; break;
      case 1:relation= 'PARENT'; break;
      case 2:relation= 'SPOUSE'; break;

      case 3:relation= 'SIBLING'; break;
      case 4:relation= 'SEXUAL_PARTNER'; break;
      case 5:relation= 'OTHER'; break;

      default : relation='OTHER';
    }
    return relation;
  }

  int fromString(String relation){
    int type;
    switch(relation){
      case 'CHILD':type= 0; break;
      case 'PARENT':type= 1; break;
      case 'SPOUSE':type= 2; break;

      case 'SIBLING':type= 3; break;
      case 'SEXUAL_PARTNER':type= 4; break;
      case 'OTHER':type= 5; break;

      default : type=5;
    }
    return type;
  }

}