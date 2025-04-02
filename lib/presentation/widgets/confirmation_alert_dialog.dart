import 'package:flutter/material.dart';

class ConfirmationAlertDialog extends StatelessWidget {
  const ConfirmationAlertDialog({super.key, required this.message, required this.onConfirm});

  final List<TextSpan> message; // Lista de TextSpan como parámetro
  final VoidCallback onConfirm; // Función para manejar la confirmación


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.amber,
            size: 50,
          ),
          SizedBox(height: 30),
          Text.rich(
            TextSpan(
              children: message
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      actionsAlignment: MainAxisAlignment.center, // Centra los botones
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Cierra la alerta sin hacer nada
          },
          child: Text('Cancelar', style: TextStyle(color: Colors.white)),
        ),
        SizedBox(width: 10), // Espacio entre botones
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          onPressed: () {
            Navigator.of(context).pop(); // Cierra la alerta antes de continuar
            onConfirm(); // Llama a la función que ejecuta la lógica
          },
          child: Text('Confirmar', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
