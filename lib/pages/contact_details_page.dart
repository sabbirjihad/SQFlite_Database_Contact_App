import 'package:contact_app_12/db/sqlite_helper.dart';
import 'package:contact_app_12/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetailsPage extends StatefulWidget {
  static final String routeName='/details';

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late ContactModel contactModel;
  bool isLoading = true;
  @override
  void didChangeDependencies() {
    final contactID=ModalRoute.of(context)!.settings.arguments as int;
    SqliteHelper.getContactById(contactID).then((value){
      setState(() {
        contactModel=value;
        isLoading=false;
      });
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      body: Center(
          child: isLoading? const CircularProgressIndicator(): ListView(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(contactModel.name),
                ),
              ),
              ListTile(
                title: Text(contactModel.mobile),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: (){
                          _callNumber();
                        },
                        icon: Icon(Icons.call)
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.sms)
                    ),
                  ],
                ),
              ),

            ListTile(
                title: Text(contactModel.email??'Not Provided'),
                trailing:IconButton(
                        onPressed:contactModel.email==null?null: (){},
                         icon: Icon(Icons.email)
                         ),
                 ),
              ListTile(
                title: Text(contactModel.streetAddress??'Not Provided'),
                trailing:IconButton(
                    onPressed:contactModel.streetAddress==null?null: (){},
                    icon: Icon(Icons.map)
                ),
              ),
              ListTile(
                title: Text(contactModel.website??'Not Provided'),
                trailing:IconButton(
                    onPressed:contactModel.website==null?null: (){},
                    icon: Icon(Icons.web)
                ),
              ),
            ],
          ),
      ),
    );
  }

  void _callNumber() async{
    final url = 'tel:${contactModel.mobile}';
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(
          SnackBar(content: Text('No Apps Found to perform this Action'))
      );
    }
  }
}
