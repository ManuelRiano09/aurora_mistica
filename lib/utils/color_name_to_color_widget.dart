import 'package:flutter/material.dart';

class ColorNameToColorWidget {
  Map<String, Color> candleColorsMap = {
    'red': Color.fromARGB(255, 241, 40, 40),
    'blue': const Color.fromARGB(255, 70, 125, 208),
    'green': Color.fromARGB(255, 56, 168, 54),
    'yellow': Colors.yellow,
    'white': Color.fromARGB(255, 255, 255, 255),
    'gray': Color.fromARGB(255, 128, 128, 128),
    'orange': Color.fromARGB(255, 255, 165, 0),
    'pink': Color.fromARGB(255, 255, 192, 203),
    'purple': Color.fromARGB(255, 128, 0, 128),
    'brown': Color.fromARGB(255, 139, 69, 19),
    'violet': Color.fromARGB(255, 238, 130, 238),
    'beige': Color.fromARGB(255, 245, 245, 220),
    'gold': Color.fromARGB(255, 255, 215, 0),
    'silver': Color.fromARGB(255, 192, 192, 192),
  };

  Color getColorFromString(String? colorName) {
    return candleColorsMap[colorName] ?? Colors.red; // by default is red
  }

  String getSpanishName(String colorName) {
    switch (colorName) {
      case 'red':
        return 'Rojo';
      case 'blue':
        return 'Azul';
      case 'green':
        return 'Verde';
      case 'yellow':
        return 'Amarillo';
      case 'black':
        return 'Negro';
      case 'white':
        return 'Blanco';
      case 'gray':
        return 'Gris';
      case 'orange':
        return 'Naranja';
      case 'pink':
        return 'Rosa';
      case 'purple':
        return 'Morado';
      case 'brown':
        return 'Marrón';
      case 'lightBlue':
        return 'Celeste';
      case 'violet':
        return 'Violeta';
      case 'beige':
        return 'Beige';
      case 'turquoise':
        return 'Turquesa';
      case 'gold':
        return 'Dorado';
      case 'silver':
        return 'Plateado';
      default :
        return 'Rojo';
    }
  }
}

