import 'package:contact_app_12/models/contact_model.dart';
import 'package:contact_app_12/pages/contact_details_page.dart';
import 'package:flutter/material.dart';

class ContactRoeItem extends StatefulWidget {
  final ContactModel contact;
  final int index;
  ContactRoeItem(this.contact,this.index);

  @override
  _ContactRoeItemState createState() => _ContactRoeItemState();
}

class _ContactRoeItemState extends State<ContactRoeItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 5,
        child: ListTile(
          onTap: (){
            Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: widget.contact);
          },
          tileColor: widget.index.isEven?Colors.greenAccent:Colors.green,
          //leading:  CircleAvatar(),
          trailing: IconButton(icon: const Icon(Icons.favorite_border),onPressed: (){},),
          title: Text(widget.contact.name),
          subtitle: Text(widget.contact.mobile),

        ),
      ),
    );
  }
}
