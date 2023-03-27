import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:motorvelox/state/fuel_manager.dart';
import 'package:motorvelox/state/ui_manager.dart';
import 'package:provider/provider.dart';
import 'mobile/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb
          ? const FirebaseOptions(
              apiKey: "AIzaSyBBoA9bYQlzrsJfmbU8lah7_74N5QMCcPE",
              projectId: "bellator-imperium",
              storageBucket: "bellator-imperium.appspot.com",
              messagingSenderId: "822960044648",
              appId: "1:822960044648:web:54ee3bbd198eb0691fd9dd",
            )
          : null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FuelManager(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Motorvelox',
        theme: ThemeData(
          primaryColor: const Color(0xFF5956E9),
          primaryColorLight: Colors.white,
          fontFamily: 'Raleway',
        ),
        initialRoute: '/',
        routes: getApplicationRoutes(),
        //  home: const HomeSplash(),
      ),
    );
  }
}
