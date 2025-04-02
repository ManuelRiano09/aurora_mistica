import 'package:aurora_candle/presentation/widgets/color_option_widget.dart';
import 'package:aurora_candle/utils/color_name_to_color_widget.dart';
import 'package:flutter/material.dart';

class ColorSelectorCircle extends StatefulWidget {
  final Function(String) onColorSelected; // Callback para enviar el color seleccionado

  const ColorSelectorCircle({super.key, required this.onColorSelected, this.color});
  final String? color;

  @override
  _ColorSelectorCircleState createState() => _ColorSelectorCircleState();
  
}

class _ColorSelectorCircleState extends State<ColorSelectorCircle> {

  late Color _selectedColor; // Estado para el color seleccionado
  String colorName = 'rojo';
  final ColorNameToColorWidget colorNameToColorWidget = ColorNameToColorWidget();

   @override
  void initState() {
    super.initState();
    _selectedColor = colorNameToColorWidget.getColorFromString(widget.color); // Si color es null, usa Colors.red
  }

  void _showColorOptions(BuildContext context) {

    final colorProvider = ColorNameToColorWidget();

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Selecciona un color",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: colorProvider.candleColorsMap.entries
                        .map((entry) => ColorOption(
                              color: entry.value,
                              onSelect: () {
                                setState(() {
                                  _selectedColor = entry.value;
                                  colorName =  entry.key; // Cambia el color
                                });

                                widget.onColorSelected(colorName); // Llama el callback

                                Navigator.pop(context); // Cierra el modal
                              },
                            ))
                        .toList(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 12),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showColorOptions(context),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _selectedColor, // Usa el color del estado
          border: Border.all(
            color: Colors.black,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 2),
            )
          ],
        ),
      ),
    );
  }
}
