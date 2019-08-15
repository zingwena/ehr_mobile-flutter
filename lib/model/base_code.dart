
import 'base_entity.dart';

abstract class BaseCode extends BaseEntity{
  String code;
  BaseCode();

  BaseCode.basic(int id,String name,this.code){
    this.id = id;
    this.name = name;
  }
}