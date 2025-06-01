import 'package:evently_app/evently_app.dart';
import 'package:evently_app/providers/config_provider.dart';
import 'package:evently_app/providers/location_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConfigProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: const EventlyApp(),
    ),
  );
}
