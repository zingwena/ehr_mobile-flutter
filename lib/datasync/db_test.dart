import 'dart:async';

import 'package:ehr_mobile/model/person.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void openDb() async {
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'ehrMobile.db'),
    // When the database is first created, create a table to store dogs.
//    onCreate: (db, version) {
//      return db.execute(
//        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
//      );
//    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    //version: 1,
  );

  Future<List<Person>> persons() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(
      'Person',limit: 10,orderBy: 'id');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Person.basic(
        maps[i]['firstName'],
        maps[i]['lastName'],
        maps[i]['sex'],
        maps[i]['nationalId'],
        maps[i]['birthDate'],
        maps[i]['religionId'],
        maps[i]['maritalStatusId'],
        maps[i]['educationLevelId'],
        maps[i]['nationalityId'],
        maps[i]['countryId'],
        maps[i]['selfIdentifiedGender'],
        maps[i]['occupationId'],
      );
    });
  }

}

