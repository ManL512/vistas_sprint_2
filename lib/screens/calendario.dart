import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa para trabajar con fechas
import 'package:vistas_sprint_2/constants/constants.dart';

class CalendarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Barra de días de la semana
          Container(
            height: 60.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                final day = DateTime.now().add(Duration(days: index));
                final isToday = index == 0; // Verifica si es el día actual

                return _buildDayItem(day, isToday);
              },
            ),
          ),
          // Resto del contenido
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
                _buildNavigationButton(context, Icons.calendar_today, 'Calendario', true),
                _buildNavigationButton(context, Icons.notifications, 'Notificaciones', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayItem(DateTime day, bool isToday) {
    final dayFormat = DateFormat.E(); // Formato de día abreviado (Lun, Mar, Mié, ...)
    final dateFormat = DateFormat.d(); // Formato de día del mes (1, 2, 3, ...)

    return Container(
      width: 50.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: isToday ?  AppColors.thirdRectangleColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayFormat.format(day),
            style: TextStyle(
              color: isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          Text(
            dateFormat.format(day),
            style: TextStyle(
              color: isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
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
          icon: Icon(Icons.info_outline),
          onPressed: () {
            _showMedicationDetails(context);
          },
        ),
      ),
    );
  }

  void _showMedicationDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(name),
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
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
