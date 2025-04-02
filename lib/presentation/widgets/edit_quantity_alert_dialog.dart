import 'package:aurora_candle/domain/entities/candle_template_entity.dart';
import 'package:aurora_candle/presentation/providers/candle_template_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditQuantityAlertDialog extends StatelessWidget {
  const EditQuantityAlertDialog({super.key, required this.candleTemplateEntity});

  final CandleTemplateEntity candleTemplateEntity;

  void _submitForm(BuildContext context, CandleTemplateEntity candleTemplateEntity, int counter) {
    final candleTemplateProvider = context.read<CandleTemplateProvider>();

    candleTemplateProvider.updateCandleQuantity(candleTemplateEntity.id, counter);
  }

  @override
  Widget build(BuildContext context) {
    final candleTemplateProvider = context.read<CandleTemplateProvider>();
    int counter = candleTemplateProvider.candleTemplateEntityList.firstWhere((candle) => candle.id == candleTemplateEntity.id).quantity;

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          title: Center(
            child: Text(
              'Cantidad',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (counter > 0) counter--;
                        });
                      },
                      icon: Icon(Icons.remove, color: Colors.redAccent, size: 28),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Text(
                        '$counter',
                        key: ValueKey<int>(counter),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          counter++;
                        });
                      },
                      icon: Icon(Icons.add, color: Colors.greenAccent, size: 28),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(counter); // Devuelve el valor
                      _submitForm(context, candleTemplateEntity, counter);
                    },
                    child: Text(
                      'Aceptar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra sin devolver nada
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
