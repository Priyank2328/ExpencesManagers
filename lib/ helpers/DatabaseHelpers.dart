import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelpers
{
  Database db;
  Future<Database> create_db() async
  {
    if(db!=null)
    {
      return db;
    }
    else
    {
      Directory dir = await getApplicationDocumentsDirectory();
      String path = join (dir.path,"shop_db");
      var db = await openDatabase(path,version: 1,onCreate: create_table);
      return db;
    }
  }
  create_table(Database db,int version) async
  {
    db.execute("create table details (tid integer primary key autoincrement,title text,remark text,amt text,type text,date text)");
    print("Table Created");
  }
  Future<int> managers(title,remark,amt,type,date) async
  {
    var db = await create_db();
    int id = await db.rawInsert("insert into details (title,remark,amt,type,date) values (?,?,?,?,?)",[title,remark,amt,type,date]);
    return id;
  }
  Future<List> expencesview() async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from details");
    return data.toList();
  }
  Future<int> recorddelect(tid) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from details where tid=?",[tid]);
    return status;
  }
  Future<List> updatemanager(tid) async
  {
    var db = await create_db();
    var data = await db.rawQuery("select * from details where tid=?",[tid]);
    return data.toList();
  }
  Future<int> savaexpences(title,remark,amt,type,date,tid) async
  {
    var db = await create_db();
    int status = await db.rawUpdate("update details set title=?,remark=?,amt=?,type=?,date=? where tid=?",[title,remark,amt,type,date,tid]);
    return status;
  }
}
