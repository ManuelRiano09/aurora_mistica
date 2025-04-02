import 'package:flutter/material.dart';

class LargeTextActionButton extends StatelessWidget {
  final String text;

  const LargeTextActionButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300, // Ajusta el ancho según necesites
      height: 60, // Ajusta la altura si es necesario
      child: FloatingActionButton.extended(
        onPressed: () {
          // Acción del botón
        },
        label: Text(
          text,
          style: TextStyle(fontFamily: 'Times New Roman', fontSize: 20.0),
        ),
        elevation: 15.0,
      ),
    );
  }
}
