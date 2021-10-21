import 'package:contact_app_12/custom_widget/contact_row_item_big_image.dart';
import 'package:contact_app_12/db/sqlite_helper.dart';
import 'package:contact_app_12/models/contact_model.dart';
import 'package:contact_app_12/pages/new_contact_page.dart';
import 'package:contact_app_12/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListPage extends StatefulWidget {
  static final String routeName='/';

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
 // List<ContactModel> contactList=[];
  late ContactProvider _provider;
  @override
  void didChangeDependencies() {
    _provider = Provider.of<ContactProvider>(context,listen: false);
    _getData();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
 //  @override
 //  void initState() {
 //    _getData();
 //    super.initState();
 //  }
  // @override
  // void didChangeDependencies() {
  // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Contact List'),
        actions: [
          TextButton(
              onPressed: () async {
                _provider.getFavContact();
                // final l= await SqliteHelper.getAllFavoriteContacts();
                // setState(() {
                //   contactList= l;
                // });
              },
              child: Text('Favorite Contact',style: TextStyle(color: Colors.white,fontSize: 20),)
          )
          // PopupMenuButton(itemBuilder: [
          //   PopupMenuItem(
          //       child: Text(''),
          //   )
          // ]
          //
          // )
        ],
      ),
      body: Consumer<ContactProvider>(
        builder:(context,contactProvider, _) =>ListView.builder(
            itemCount: contactProvider.contactList.length,
            itemBuilder: (context, index)=>ContactRowItemBigImage(contactProvider.contactList[index], _updateContactFav, _deleteContact)
            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, NewContactPage.routeName).then((_){
            setState(() {
             _getData();
            });
          });
        },
      ),
    );
  }
  void _getData() async{
    _provider.getContact();
    // final cList= await SqliteHelper.getAllContacts();
    // setState(() {
    //   contactList=cList;
    // });
  }
  void _updateContactFav(ContactModel contactModel, bool fav){

    _provider.updateContactFav(contactModel, fav);
   // final index =  _provider.contactList.indexWhere((contact) => contact.id==contactModel.id);
   // final contact = _provider.contactList.firstWhere((element) => element.id==contactModel.id);
   // _provider.contactList.elementAt(index).favourite = fav ;
   //  final oldContact = contactList.elementAt(index);
    // setState(() {
    //
    // });
  }
  void _deleteContact(ContactModel contactModel){
    _provider.deleteContact(contactModel);
    // contactList.remove(contactModel);
    // setState(() {
    //
    //
    // });
  }
}



