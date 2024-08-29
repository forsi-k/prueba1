import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Constantes/Constantes.dart';
import 'package:prueba1/Pantallas/login.dart';
import 'package:prueba1/Pantallas/pantalla_principal.dart';
import 'package:prueba1/Widget/bobinas/actualizar_bobinas.dart';
import 'package:prueba1/Widget/bobinas/avance_bobinas.dart';
import 'package:prueba1/Widget/bobinas/crear_bobina.dart';
import 'package:prueba1/Widget/bobinas/menu_bobinas.dart';
import 'package:prueba1/Widget/bobinas/read_bobinas.dart';
import 'package:prueba1/Widget/funciones%20fabricacion/editor_fabs.dart';
import 'package:prueba1/Widget/funciones%20fabricacion/new_fabricacion.dart';
import 'package:prueba1/firebase_options.dart';
import 'package:prueba1/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Indexnum>(create: (_) => Indexnum()),
          ChangeNotifierProvider<Mail>(create: (_) => Mail()),
          ChangeNotifierProvider<BobDatos>(create: (_) => BobDatos()),
          ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ],
        builder: (context, _) {
          return MaterialApp(
            title: 'TTE',
            debugShowCheckedModeBanner: false,
            initialRoute: '/login',
            routes: <String, WidgetBuilder>{
              '/home': (BuildContext context) => const PantallaPrincipal(),
              '/edit': (BuildContext context) => const EditFabricacion(),
              '/bob': (BuildContext context) => const ReadBobinas(),
              '/mbob': (BuildContext context) => const MenuBobinas(),
              '/addbob': (BuildContext context) => const AddBob(),
              '/actbob': (BuildContext context) => const ActualizarBobinas(),
              '/avancebob': (BuildContext context) => const AvanceBobinas(),
              '/newfab': (BuildContext context) => const AddFabricacion(),
              '/editfab': (BuildContext context) => const EditFabricacion(),
              '/login': (BuildContext context) => const Login()
            },
            theme: ThemeData(
              scaffoldBackgroundColor:
                  colorFondo, // COLOR DEL FONDO DEFINIDO EN CONSTANTES.DART
              brightness: Brightness.dark,
            ),
          );
        });
  }
}
