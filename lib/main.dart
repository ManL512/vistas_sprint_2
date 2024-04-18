import 'package:flutter/material.dart';
import 'package:vistas_sprint_2/screens/calendario.dart';
import 'package:vistas_sprint_2/screens/menu_medicamentos.dart'; // Importa el archivo menu_medicamentos.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
      home: MenuMedicamentos(), // Establece MenuMedicamentos como la pantalla inicial
      routes: {
      '/menu': (context) => MenuMedicamentos(),
      '/calendario': (context) => CalendarioPage(),
      //'/notificaciones': (context) => NotificacionesPage(),
    // Agrega más rutas según sea necesario
  },
    );
  }
}