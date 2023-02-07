import 'package:flutter/material.dart';
import 'package:keanggotaan_orbit/config/routes.dart';
import 'package:keanggotaan_orbit/providers/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: routes.routeInformationParser,
        routerDelegate: routes.routerDelegate,
        routeInformationProvider: routes.routeInformationProvider,
      ),
    );
  }
}
