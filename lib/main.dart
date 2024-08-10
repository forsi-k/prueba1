import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba1/Constantes/Constantes.dart';
import 'package:prueba1/Pantallas/pantallaPrincipal.dart';
import 'package:prueba1/Widget/funciones%20fabricacion/Editorfabs.dart';
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
        ChangeNotifierProvider<Indexnum>(create: (_)=>Indexnum()),
        ChangeNotifierProvider<FabNum>(create: (_)=>FabNum())
      ],
      builder: (context,_) {
        return MaterialApp(
            title: 'TTE',
            debugShowCheckedModeBanner: false,
            
              initialRoute: '/home',

              routes: <String, WidgetBuilder>{
                '/home': (BuildContext context) => const PantallaPrincipal(),
                '/edit': (BuildContext context) => const EditFabricacion()                
              },

              theme: ThemeData(
              scaffoldBackgroundColor:colorFondo, // COLOR DEL FONDO DEFINIDO EN CONSTANTES.DART
              brightness: Brightness.dark,
              
            ), 
        );
      }
    );
  }
}
