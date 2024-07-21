import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/routes.dart';

import 'package:lush_app/services/firebase_helper.dart';
import 'package:lush_app/services/chat_provider.dart';
import 'package:lush_app/services/user_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ChangeNotifierProvider<ChatProvider>(
          create: (_) => ChatProvider(firebaseHelper: FirebaseHelper())),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseHelper().ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      title: 'Lush',
      routes: routes,
    );
  }
}
