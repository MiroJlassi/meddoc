import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meddoc/core/theme/app_theme.dart';
import 'package:meddoc/core/router/app_router.dart';
import 'package:meddoc/providers/auth_provider.dart';
import 'package:meddoc/providers/doctors_provider.dart';
import 'package:meddoc/providers/appointments_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase est désactivé pour utiliser les données mockées
  // Pour activer Firebase :
  // 1. Exécutez : flutterfire configure
  // 2. Décommentez les lignes ci-dessous
  // 3. Remplacez AuthProvider par la version Firebase
  
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DoctorsProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentsProvider()),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          final router = AppRouter(authProvider);
          
          return MaterialApp.router(
            title: 'MedDoc',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            routerConfig: router.router,
          );
        },
      ),
    );
  }
}
