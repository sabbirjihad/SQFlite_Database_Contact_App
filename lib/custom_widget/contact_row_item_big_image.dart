import 'dart:io';
import 'package:contact_app_12/db/sqlite_helper.dart';
import 'package:contact_app_12/models/contact_model.dart';
import 'package:contact_app_12/pages/contact_details_page.dart';
import 'package:flutter/material.dart';

class ContactRowItemBigImage extends StatefulWidget {
  final ContactModel contact;
  final Function(ContactModel, bool) getDataCallback;
  final Function(ContactModel) deleteCallBack;
   const ContactRowItemBigImage(this.contact,this.getDataCallback,this.deleteCallBack);

  @override
  _ContactRowItemBigImageState createState() => _ContactRowItemBigImageState();
}

class _ContactRowItemBigImageState extends State<ContactRowItemBigImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 32.0),
      width: double.maxFinite,
      height: 300.0,
      decoration:  BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
              child: Image.file(
                 File(widget.contact.image!),
                width: double.maxFinite,height: 300,fit: BoxFit.cover,
              )
          ),
          Positioned(
            left: 0,
              top: 0,
              child: IconButton(
                icon: Icon(widget.contact.favourite?Icons.favorite : Icons.favorite_border),
                iconSize: 50.0,
                color: Colors.red,
                onPressed: () async{
                  final value=widget.contact.favourite?0:1;
                 await SqliteHelper.updateContactFavorite(widget.contact.id, value);
                 widget.getDataCallback(widget.contact,!widget.contact.favourite);

                },
              )
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: IconButton(
                icon: Icon(Icons.delete_forever,color: Colors.red,),
                iconSize: 50.0,
                color: Colors.red,
                onPressed: () async{
                 _showConfirmationDialog();
                },
              )
          ),
          Positioned(
            top: 0,bottom: 0,left: 0,right: 0,
              child: Center(
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.all(4.0),
                    child: Text(widget.contact.name,
                      style: const TextStyle(fontSize: 18.0,color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
              )
          ),
          Positioned(
            left: 35,
              right: 35,
              bottom: -25,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                ),
                child: const Text('Details'),
                onPressed: () {
                       Navigator.pushNamed(
                           context,
                           ContactDetailsPage.routeName,
                           arguments: widget.contact.id,
                       );
                   }),
                  )
                ]
              ),
          );
  }

  void _showConfirmationDialog() {
    showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text('Delete ${widget.contact.name}?'),
      content: Text('Are you sure you want to Delete this contact?'),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Cancel')
        ),
        ElevatedButton(
            onPressed: (){
              SqliteHelper.deleteContact(widget.contact.id).then((_){
              Navigator.pop(context);
              widget.deleteCallBack(widget.contact);
              }
              );
            },
            child:const Text('Delete')
        )
      ],
    ));
  }
}
