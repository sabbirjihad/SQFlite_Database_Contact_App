import 'package:contact_app_12/models/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class SqliteHelper{
  static const String _create_table_contact='''create table $tbl_contact(
  $tbl_contact_col_id integer primary key autoincrement,
  $tbl_contact_col_name text,
  $tbl_contact_col_mobile text,
  $tbl_contact_col_email text,
  $tbl_contact_col_address text,
  $tbl_contact_col_website text,
  $tbl_contact_col_image text,
  $tbl_contact_col_favourite integer)''';

  static const String _create_table_contact_call='''create table 'tbl_contact_call'(
  'call_id' integer primary key autoincrement,
 
  'call_duration' integer,
  'caller_id' text)''';

  static Future<Database> open() async{
    final rootPath= await getDatabasesPath();
    final dbPath= Path.join(rootPath,'contact.db');
    return openDatabase(dbPath, version:2,onCreate: (db,version) async{
      await db.execute(_create_table_contact);
      await db.execute(_create_table_contact_call);

    },onUpgrade: ( db , oldVersion,newVersion) async {
      if(newVersion==2){
        await db.execute(_create_table_contact_call);
      }
    }
    );

  }

  static Future<int> insertNewContact(ContactModel contactModel) async{
     final db =await open();
     return db.insert(tbl_contact, contactModel.toMap());
  }

  static Future<int> updateContactFavorite(int? id,  favValue) async{
     final db =await open();
     return db.update(tbl_contact, {tbl_contact_col_favourite:favValue},
         where:'$tbl_contact_col_id = ? ',whereArgs: [id]);
  }

  static Future<int> deleteContact(int? id) async{
    final db =await open();
    return db.delete(tbl_contact, where:'$tbl_contact_col_id = ? ',whereArgs: [id],);
  }
  static Future<List<ContactModel>> getAllContacts() async{
    final db =await open();
    List<Map<String, dynamic>> maplist= await db.query(tbl_contact);
    return List.generate(maplist.length, (index) => ContactModel.fromMap(maplist[index]));
  }


  static Future<List<ContactModel>> getAllFavoriteContacts() async{
    final db =await open();
    List<Map<String, dynamic>> maplist= await db.query(tbl_contact,where: '${tbl_contact_col_favourite}=?',whereArgs: [1]);
    return List.generate(maplist.length, (index) => ContactModel.fromMap(maplist[index]));
  }




  static Future<ContactModel> getContactById(int? id) async{
    final db =await open();
    List<Map<String, dynamic>> maplist= await db.query(tbl_contact,where:'$tbl_contact_col_id = ? ',whereArgs: [id]);
    return ContactModel.fromMap(maplist.first);
  }


 }











