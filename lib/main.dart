import 'package:babysitter/blocs/parentauthbloc/auth_bloc.dart';
import 'package:babysitter/blocs/sitterauthbloc/sitterauthbloc_bloc.dart';
import 'package:babysitter/firebase_options.dart';
import 'package:babysitter/repositories/famille_auth_repository.dart';
import 'package:babysitter/repositories/firebase_messaging_repository.dart';
import 'package:babysitter/repositories/sitter_auth_repository.dart';
import 'package:babysitter/screens/check_user_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => FamilleAuthRepository()),
        RepositoryProvider(create: (_) => SitterAuthRepository()),
        RepositoryProvider(create: (_) => FirebaseMessaginRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (BuildContext context) => AuthBloc(
                authrepository:
                    RepositoryProvider.of<FamilleAuthRepository>(context),
                firebaseMessaginRepository:
                    RepositoryProvider.of<FirebaseMessaginRepository>(context)),
          ),
          BlocProvider<SitterauthblocBloc>(
            create: (BuildContext context) => SitterauthblocBloc(
                sitterAuthRepository:
                    RepositoryProvider.of<SitterAuthRepository>(context),
                firebaseMessaginRepository:
                    RepositoryProvider.of<FirebaseMessaginRepository>(context)),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ChecKBefore(),
        ),
      ),
    );
  }
}
