import 'package:contact_app_12/pages/contact_details_page.dart';
import 'package:contact_app_12/pages/contact_list_page.dart';
import 'package:contact_app_12/pages/new_contact_page.dart';
import 'package:contact_app_12/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ContactProvider() ,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: ContactListPage.routeName,
        routes: {
          ContactListPage.routeName:(context)=>ContactListPage(),
          NewContactPage.routeName:(context)=>NewContactPage(),
          ContactDetailsPage.routeName:(context)=>ContactDetailsPage(),

        },
      ),
    );
  }
}

