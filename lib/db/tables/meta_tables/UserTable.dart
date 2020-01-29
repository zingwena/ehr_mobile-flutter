

class UserTable {

  String ehrId;
  String login;
  String firstName;
  String lastName;
  String email;
  String imageUrl;
  String activated;
  String langKey;
  String createdBy;
  String createdDate;
  String lastModifiedBy;
  String lastModifiedDate;

  UserTable fromJson(Map map) {
    var table = UserTable();
    table.ehrId = map['ehrId'];
    table.login=map['login'];
    table.firstName=map['firstName'];
    table.lastName=map['lastName'];
    table.email=map['email'];
    table.imageUrl=map['imageUrl'];
    table.activated=map['activated'];
    table.langKey=map['langKey'];
    table.createdBy=map['createdBy'];
    table.createdDate=map['createdDate'];
    table.lastModifiedBy=map['lastModifiedBy'];
    table.lastModifiedDate=map['lastModifiedDate'];
    return table;
  }

  Map<String, dynamic> toJson() => {
    'ehrId':ehrId,
    'login':login,
    'firstName':firstName,
    'lastName':lastName,
    'firstName':firstName,
    'firstName':firstName,
    'email':email,
    'imageUrl':imageUrl,
    'activated':activated,
    'langKey':langKey,
    'createdBy':createdBy,
    'createdDate':createdDate,
    'lastModifiedBy':lastModifiedBy,
    'lastModifiedDate':lastModifiedDate,
  };
}