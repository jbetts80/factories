import 'package:factories/presentation/details/factory_detail.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:factories/data/datasources/auth_repository_impl.dart';
import 'package:factories/data/datasources/factory_repository_impl.dart';
import 'package:factories/domain/repositories/auth_repository.dart';
import 'package:factories/domain/repositories/factory_repository.dart';
import 'package:factories/presentation/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => AuthRepositoryImpl()),
        Provider<FactoryRepository>(create: (_) => FactoryRepositoryImpl()),
      ],
      child: MaterialApp(
        home: LoginScreen(),
        routes: {
          FactoryDetail.routeName: (_) => FactoryDetail(),
        },
      ),
    );
  }
}
