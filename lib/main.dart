import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:factories/data/datasources/auth_repository_impl.dart';
import 'package:factories/domain/repositories/auth_repository.dart';
import 'package:factories/presentation/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => AuthRepositoryImpl()),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}
