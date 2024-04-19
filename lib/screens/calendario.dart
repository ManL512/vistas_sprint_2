import 'package:flutter/material.dart';
import 'package:vistas_sprint_2/constants/constants.dart';


class CalendarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: Text('Calendario', style: TextStyle(color: AppColors.firstRectangleColor)),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Acción al presionar el icono de perfil
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.boxColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Medicamentos del dia',
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                MedicationCard(name: 'Paracetamol', dosage: '1 comprimido cada 8 horas'),
                MedicationCard(name: 'Ibuprofeno', dosage: '1 comprimido cada 6 horas'),
                // Agrega más MedicationCard según sea necesario
              ],
            ),
          ),
          // Sección de navegación entre vistas
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavigationButton(context, Icons.medication, 'Medicamentos', false),
                _buildNavigationButton(context, Icons.calendar_today, 'Calendario', true), //Efecto de la barra navegacion
                _buildNavigationButton(context, Icons.notifications, 'Notificaciones', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildNavigationButton(BuildContext context, IconData icon, String label, bool isActive) {
  return GestureDetector(
    onTap: () {
      _navigateToPage(context, label);
    },
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isActive ? AppColors.thirdRectangleColor : Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : Colors.black,
                size: 32.0,
              ),
              SizedBox(height: 8.0),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  void _navigateToPage(BuildContext context, String pageName) {
    switch (pageName) {
      case 'Medicamentos':
        Navigator.pushNamed(context, '/menu');
        break;
      case 'Calendario':
        // Ya estás en la página de Calendario, no es necesario navegar
        break;
      case 'Notificaciones':
        Navigator.pushNamed(context, '/notificaciones');
        break;
    }
  }
}

class MedicationCard extends StatelessWidget {
  final String name;
  final String dosage;

  const MedicationCard({
    required this.name,
    required this.dosage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: AppColors.boxColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.local_hospital, color: Colors.white),
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.black),
        ),
        subtitle: Text(
          'Dosis: $dosage',
          style: TextStyle(color: Colors.black87),
        ),
        trailing: IconButton(
          icon: Icon(Icons.info), // Icono para mostrar más información
          onPressed: () {
            _showMedicationDetails(context); // Método para mostrar detalles del medicamento
          },
        ),
      ),
    );
  }

  void _showMedicationDetails(BuildContext context) {
    // Aquí puedes implementar la lógica para mostrar los detalles del medicamento
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(name), // Nombre del medicamento como título del diálogo
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dosis: $dosage'),
              SizedBox(height: 8.0),
              // Agrega más detalles según sea necesario
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
