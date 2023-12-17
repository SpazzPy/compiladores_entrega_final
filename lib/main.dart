import 'package:flutter/material.dart';
import 'package:compiladores_entrega_final/Module/HomePage.dart';

// Definimos la función principal que arranca la aplicación
void main() {
  runApp(const MyApp());
}

// Definimos la clase MyApp que es un StatelessWidget
class MyApp extends StatelessWidget {
  // Constructor de la clase
  const MyApp({super.key});

  // Definimos el método build que construye la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    // Retornamos un MaterialApp
    return MaterialApp(
      // Desactivamos la bandera de modo de depuración
      debugShowCheckedModeBanner: false,
      // Establecemos el título de la aplicación
      title: 'Compiladores Entrega Final',
      // Establecemos la página de inicio de la aplicación
      home: const HomePage(),
      // Establecemos el tema de la aplicación
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}

// Definimos la clase HomePage que es un StatefulWidget
class HomePage extends StatefulWidget {
  // Constructor de la clase
  const HomePage({super.key});

  // Creamos el estado de la página
  @override
  State<HomePage> createState() => _HomePageState();
}

// Definimos la clase _HomePageState que es el estado de HomePage
class _HomePageState extends State<HomePage> {
  // Definimos el método build que construye la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    // Retornamos un Scaffold
    return const Scaffold(
      // Establecemos el cuerpo de la página
      body: Home(),
    );
  }
}
