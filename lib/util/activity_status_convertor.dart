
class ActivityStatusConvertor{

  const ActivityStatusConvertor();
  String fromInt(int status){
    String activityStatus;
    switch(status){
      case 0:activityStatus= 'DONE'; break;
      case 1:activityStatus= 'NOT_DONE'; break;
      case 2:activityStatus= 'UNKNOWN'; break;
      default : activityStatus='UNKNOWN';
    }
    return activityStatus;
  }

  int fromString(String activityStatus){
    int status;
    switch(activityStatus){
      case 'DONE':status= 0; break;
      case 'NOT_DONE':status= 1; break;
      case 'UNKNOWN':status= 2; break;
      default : status=2;
    }
    return status;
  }

}