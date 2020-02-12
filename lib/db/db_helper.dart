
import 'package:jaguar_query_sqflite/jaguar_query_sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  SqfliteAdapter _adapter;

  initDb() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, 'impMobile');
    _adapter = new SqfliteAdapter(path);
    await _adapter.connect();
    return _adapter;
  }

  Future<SqfliteAdapter> getAdapter() async {
    if(_adapter==null){
      await initDb();
    }
    return _adapter;
  }
}