import 'dart:io';
import 'package:contact_app_12/db/sqlite_helper.dart';
import 'package:contact_app_12/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewContactPage extends StatefulWidget {
   static final String routeName='/new_contact';
  @override
  _NewContactPageState createState() => _NewContactPageState();
}
class _NewContactPageState extends State<NewContactPage> {
  final _nameController=TextEditingController();
  final _phoneController=TextEditingController();
  final _emailController=TextEditingController();
  final _streetAddressController=TextEditingController();
  final _webSiteController=TextEditingController();
  final _formKey=GlobalKey<FormState>();
  var _imageSource=ImageSource.camera;

  String? _imagePath;

  // @override
  // void initState() {
    // TODO: implement initState
  //   super.initState();
  // }
  // @override
  // void didChangeDependencies() {
   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _streetAddressController.dispose();
    _webSiteController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
        actions: [
          IconButton(
              onPressed: _saveContact,
              icon: const Icon(Icons.save)
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Contact Name'
              ),
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'Please provide a valid name';
                }
                if(value.length>20){
                  return 'Name should be  less than 20 character';
                }
                return null;
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Mobile Number'
              ),
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'Please provide a valid Mobile Number';
                }
                return null;
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter Email(Optional)'
              ),
              validator: (value){
                return null;
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: _streetAddressController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  hintText: 'Street Address (optional)'
              ),
              validator: (value){
                return null;
              },
            ),
            const SizedBox(height: 15,),
            TextFormField(
              controller: _webSiteController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.web),
                  hintText: 'Website (optional)'
              ),
              validator: (value){
                return null;
              },
            ),
            const SizedBox(height: 20,),
            Center(
              child:  Card(
                elevation: 10,
                color: Colors.grey,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: _imagePath==null ? Image.asset('images/sabbir.jpg',fit: BoxFit.cover,):
                  Image.file(File(_imagePath!),fit: BoxFit.cover),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: (){
                      _imageSource= ImageSource.camera;
                      _getImage();
                    },
                    child:  Text('Capture Image')
                ),
                ElevatedButton(
                    onPressed:(){
                      _imageSource= ImageSource.gallery;
                      _getImage();
                    },
                    child: Text('Select From Gallery')
                )
              ],
            )
          ],
        ),
      ),
    );
  }

     void _saveContact() async {
    if(_imagePath==null){
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Please Choose an image First')),
      );
      return;
    }
    if(_formKey.currentState!.validate()){
      final name=_nameController.text;
      final mobile=_phoneController.text;
      final email=_emailController.text;
      final address= _streetAddressController.text;
      final web =_webSiteController.text;
      final contact=ContactModel(
          name: name,
          mobile: mobile,
          email: email,
          image: _imagePath,
          streetAddress: address,
          website: web,
      );
      
      int rowId = await SqliteHelper.insertNewContact(contact);//async use in _saveContact() why use await..
      if( rowId> 0){
        print(rowId);
        Navigator.pop(context);
      }
    }
  }

  void _getImage() {
    final Future<XFile?> imageFutureFile = ImagePicker().pickImage(source:_imageSource);
    imageFutureFile.then((imgFile) {
      if(imgFile != null){
        setState(() {
          _imagePath=imgFile.path;
        });
       // _imagePath=imgFile.path;
      }
    });
  }
}
