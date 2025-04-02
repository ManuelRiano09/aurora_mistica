import 'package:flutter/material.dart';

class CandleTree extends StatelessWidget {
  const CandleTree({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // Acción al presionar
      borderRadius: BorderRadius.circular(10), // Borde redondeado al tocar
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.5), // Borde negro
          borderRadius: BorderRadius.circular(30),
          
        ),
        child: Column(
          children: [
            // Imagen (Parte superior)
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.network(
                'https://images.vexels.com/media/users/3/135583/isolated/preview/6ab6aa994cceb668b0bf3021097e4463-icono-de-luz-de-vela.png?w=360',
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
            Divider(
              height: 0,
              color: Colors.black, // Color de la línea
              thickness: 1, // Grosor de la línea
              indent: 5, // Espaciado desde la izquierda
              endIndent: 5, // Espaciado desde la derecha
            ),
            // Parte inferior con fondo morado y texto
            Container(
              width: double.infinity,
              height: 58.5, // box size
              padding: const EdgeInsets.symmetric(vertical: 13.5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 56, 168, 54), // Fondo morado
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Center(
                child: Text(
                  'Dinero',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
