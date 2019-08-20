class Token {

  String id_token;

  Token(this.id_token);

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      json['id_token'],
    );
  }


}