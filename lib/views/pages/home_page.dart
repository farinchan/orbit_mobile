import 'package:flutter/material.dart';
import 'package:keanggotaan_orbit/providers/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ini adalah home page"), actions: [
        IconButton(onPressed: () async{ 
          Provider.of<AuthProvider>(context, listen: false).logout(context);
          
        }, icon: Icon(Icons.logout))
      ],),
    );
  }
}