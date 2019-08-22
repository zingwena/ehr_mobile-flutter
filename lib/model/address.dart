import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address{

  String street;
  String town;
  String city;

  Address(this.street, this.town, this.city);

  factory Address.fromJson(Map<String, dynamic> json) =>_$AddressFromJson(json);

      Map<String, dynamic> toJson() =>_$AddressToJson(this);


  @override
  String toString() {
    return 'Address{street: $street, town: $town, city: $city}';
  }
}