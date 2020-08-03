import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:demo/client.dart';
import 'package:sqflite/sqflite.dart';

class ClientDatabaseProvider {
  ClientDatabaseProvider._();

  static final ClientDatabaseProvider db = ClientDatabaseProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await getDatabaseInstance();
    return _database;
  }

  Future<Database> getDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "client.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Client ("
          "id integer primary key AUTOINCREMENT,"
          "name TEXT,"
          "direction TEXT,"
          "email TEXT,"
          "phone TEXT"
          ")");
    });
  }

  addClientToDatabase(Client client) async {
    final db = await database;
    var raw = await db.insert(
      "Client",
      client.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return raw;
  }

  updateClient(Client client) async {
    final db = await database;
    var response = await db.update("Client", client.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return response;
  }

  Future<Client> getClientWithId(int id) async {
    final db = await database;
    var response = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return response.isNotEmpty ? Client.fromMap(response.first) : null;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    var response = await db.query("Client");
    List<Client> list = response.map((c) => Client.fromMap(c)).toList();
    print(list);
    return list;
  }

  deleteClientWithId(int id) async {
    final db = await database;
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  deleteAllClients() async {
    final db = await database;
    db.delete("Client");
  }
}
