import 'dart:convert';

import 'package:client/helpers/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> get accountDetails async {
  var jwt = await storage.read(key: "user");
  //

  if (jwt == null) return "";
  return jwt;
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FutureBuilder(
        future: accountDetails,
        builder: (context, snapshot) {
         
          if (!snapshot.hasData) return Text("Loading");
          if (snapshot.data != "") {
            
            authenticationController.loadUser(jsonDecode(snapshot.data as String));
            return PartnerForm();
          } else {
            return Login();
          }
        },
      ),
    );
  }
}
