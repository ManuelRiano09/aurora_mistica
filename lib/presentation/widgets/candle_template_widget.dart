import 'package:aurora_candle/domain/entities/candle_template_entity.dart';
import 'package:aurora_candle/presentation/screens/candle_template_info_screen.dart';
import 'package:aurora_candle/utils/color_name_to_color_widget.dart';
import 'package:flutter/material.dart';

class CandleTemplateWidget extends StatelessWidget {
  const CandleTemplateWidget({super.key, required this.candleTemplateEntity});

  final CandleTemplateEntity candleTemplateEntity;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // Color blanco sin afectar el InkWell
      borderRadius: BorderRadius.circular(30),
      child: CandleTemplateButton(
        candleTemplateEntity: candleTemplateEntity,
      ),
    );
  }
}

class CandleTemplateButton extends StatelessWidget {
  const CandleTemplateButton({
    super.key,
    required this.candleTemplateEntity,
  });

  final CandleTemplateEntity candleTemplateEntity;

  @override
  Widget build(BuildContext context) {
    final ColorNameToColorWidget colorNameToColorWidget =
        ColorNameToColorWidget();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CandleTemplateInfoScreen(
                    candleTemplateEntity: candleTemplateEntity,
                  )),
        );
      }, // Acción al presionar
      borderRadius: BorderRadius.circular(30), // Mantiene la forma redondeada
      splashColor: Colors.black.withValues(
          alpha: 20,
          red: 38,
          green: 38,
          blue: 1), // Olas al presionar 255, 243, 232, 249
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 53, 19, 64),
              width: 1.5), // Borde negro
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Imagen (Parte superior)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    'https://images.vexels.com/media/users/3/135583/isolated/preview/6ab6aa994cceb668b0bf3021097e4463-icono-de-luz-de-vela.png?w=360',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
                Divider(
                  height: 0,
                  color: Colors.black,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
                // Parte inferior con fondo de color
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: colorNameToColorWidget
                          .getColorFromString(candleTemplateEntity.color.name),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                    ),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          text:
                              '${candleTemplateEntity.title}\n', // Aquí va el texto principal
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          children: [
                            TextSpan(
                              text: candleTemplateEntity.scent,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Cantidad en la esquina superior derecha
            Positioned(
              top: 8,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: colorNameToColorWidget
                          .getColorFromString(candleTemplateEntity.color.name),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${candleTemplateEntity.quantity}',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
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
