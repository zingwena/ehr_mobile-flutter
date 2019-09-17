import 'base_entity.dart';

abstract class BaseCode extends BaseEntity{
  BaseCode();

  BaseCode.basic(String code,String name){
    this.code = code;
    this.name = name;
  }
}