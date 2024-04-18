import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:vistas_sprint_2/constants/constants.dart';
import 'package:vistas_sprint_2/screens/calendario.dart';

class MenuMedicamentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis medicamentos', style: TextStyle(color: AppColors.firstRectangleColor)),
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
          // Sección de barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.boxColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Buscar medicamento...',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Sección de cajas de medicamentos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        MedicationCard(
                          name: 'Paracetamol',
                          dosage: '1 comprimido cada 8 horas',
                          editAction: () {
                            _showEditMedicationDialog(context, 'Paracetamol', 'Analgésico', ['Lunes', 'Martes'], '08', 'Para fiebre', '1 comprimido cada 8 horas');
                          },
                        ),
                        MedicationCard(
                          name: 'Ibuprofeno',
                          dosage: '1 comprimido cada 6 horas',
                          editAction: () {
                            _showEditMedicationDialog(context, 'Ibuprofeno', 'Antiinflamatorio', ['Martes', 'Jueves'], '12:00 PM', 'Para dolor', '1 comprimido cada 6 horas');
                          },
                        ),
                        // Agrega más MedicationCard según sea necesario
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.firstRectangleColor,
                      ),
                      padding: EdgeInsets.all(2.0),
                      child: IconButton(
                        icon: Icon(Icons.add, color: Colors.white), // Ícono con color blanco
                        onPressed: () {
                          _showAddMedicationDialog(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Sección de navegación entre vistas
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavigationButton(context, Icons.medication, 'Medicamentos', true), // Destacar la primera vista
                _buildNavigationButton(context, Icons.calendar_month_outlined, 'Calendario', false),
                _buildNavigationButton(context, Icons.notifications, 'Notificaciones', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddMedicationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return _buildMedicationDialog(context, 'Agregar Medicamento', 'Agregar', () {
          // Lógica para agregar el medicamento
          Navigator.of(context).pop(); // Cerrar el diálogo
        });
      },
    );
  }

  void _showEditMedicationDialog(BuildContext context, String name, String type, List<String> days, String time, String description, String dosage) {
    showDialog(
      context: context,
      builder: (context) {
        return _buildMedicationDialog(context, 'Editar Medicamento', 'Guardar Cambios', () {
          // Lógica para guardar los cambios del medicamento
          Navigator.of(context).pop(); // Cerrar el diálogo
        }, initialName: name, initialType: type, initialDays: days, initialTime: time, initialDescription: description, initialDosage: dosage);
      },
    );
  }

  Widget _buildMedicationDialog(
    BuildContext context,
    String title,
    String confirmLabel,
    VoidCallback confirmAction, {
    String? initialName,
    String? initialType,
    List<String>? initialDays,
    String? initialTime,
    String? initialDescription,
    String? initialDosage,
  }) {
    TextEditingController nameController = TextEditingController(text: initialName);
    TextEditingController typeController = TextEditingController(text: initialType);
    TextEditingController descriptionController = TextEditingController(text: initialDescription);
    TextEditingController dosageController = TextEditingController(text: initialDosage);

    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(controller: nameController, decoration: InputDecoration(labelText: 'Nombre del Medicamento')),
          TextField(controller: typeController, decoration: InputDecoration(labelText: 'Tipo de Medicamento')),
          MultiSelectFormField(
            autovalidate: AutovalidateMode.always, // Modo de validación automática
            dataSource: [
              {'display': 'Lunes', 'value': 'Lunes'},
              {'display': 'Martes', 'value': 'Martes'},
              {'display': 'Miércoles', 'value': 'Miércoles'},
              {'display': 'Jueves', 'value': 'Jueves'},
              {'display': 'Viernes', 'value': 'Viernes'},
              {'display': 'Sábado', 'value': 'Sábado'},
              {'display': 'Domingo', 'value': 'Domingo'},
            ],
            textField: 'display',
            valueField: 'value',
            okButtonLabel: 'Aceptar',
            cancelButtonLabel: 'Cancelar',
            hintWidget: Text('Seleccione los días'),
            onSaved: (value) {
              // Handle dropdown value change
            },
          ),
          Row(
            children: [
              Expanded(
                child: TextField(controller: TextEditingController(text: initialTime), decoration: InputDecoration(labelText: 'Hora')),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(controller: TextEditingController(text: initialTime), decoration: InputDecoration(labelText: 'Minutos')),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: 'AM',
                  items: ['AM', 'PM'].map((period) {
                    return DropdownMenuItem<String>(
                      value: period,
                      child: Text(period),
                    );
                  }).toList(),
                  onChanged: (value) {
                    // Handle dropdown value change
                  },
                  decoration: InputDecoration(labelText: 'AM/PM'),
                ),
              ),
            ],
          ),
          TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Descripción')),
          TextField(controller: dosageController, decoration: InputDecoration(labelText: 'Dosis')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: confirmAction,
          child: Text(confirmLabel),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(BuildContext context, IconData icon, String label, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacement( // Reemplazar la vista actual con CalendarioPage
            context,
            MaterialPageRoute(builder: (context) => CalendarioPage()),
          );
        }
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
}

class MedicationCard extends StatelessWidget {
  final String name;
  final String dosage;
  final VoidCallback editAction;

  const MedicationCard({
    required this.name,
    required this.dosage,
    required this.editAction,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
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
          icon: Icon(Icons.edit),
          onPressed: editAction,
        ),
      ),
    );
  }
}
