import 'package:contact_app_12/db/sqlite_helper.dart';
import 'package:contact_app_12/models/contact_model.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider with ChangeNotifier{

  List<ContactModel> contactList=[];

  void getContact() async{
    contactList=await SqliteHelper.getAllContacts();
    notifyListeners();
  }
  void getFavContact() async{
    contactList=await SqliteHelper.getAllFavoriteContacts();
    notifyListeners();
  }
  void updateContactFav(ContactModel contactModel, bool fav){
    final index = contactList.indexWhere((contact) => contact.id==contactModel.id);
    contactList.elementAt(index).favourite = fav ;
    notifyListeners();

  }
  void deleteContact(ContactModel contactModel){
    contactList.remove(contactModel);
    notifyListeners();

  }
}