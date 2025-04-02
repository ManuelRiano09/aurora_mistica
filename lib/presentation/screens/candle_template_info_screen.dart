import 'package:aurora_candle/domain/entities/candle_template_entity.dart';
import 'package:aurora_candle/presentation/providers/candle_template_provider.dart';
import 'package:aurora_candle/presentation/screens/edit_candle_template_screen.dart';
import 'package:aurora_candle/presentation/screens/main_screen.dart';
import 'package:aurora_candle/presentation/widgets/confirmation_alert_dialog.dart';
import 'package:aurora_candle/presentation/widgets/edit_quantity_alert_dialog.dart';
import 'package:aurora_candle/utils/color_name_to_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CandleTemplateInfoScreen extends StatelessWidget {
  const CandleTemplateInfoScreen(
      {super.key, required this.candleTemplateEntity});

  final CandleTemplateEntity candleTemplateEntity;

  @override
  Widget build(BuildContext context) {
    final colorNameToColorWidget = ColorNameToColorWidget();
    final candleTemplateProvider = context.watch<CandleTemplateProvider>();

    Color primaryColor = colorNameToColorWidget
        .getColorFromString(candleTemplateEntity.color.name);

    if (primaryColor == Colors.white) {
      primaryColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(primaryColor),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ExpandableInfoCard(
                    title: "Esencia",
                    value: candleTemplateEntity.scent,
                    icon: Icons.spa_rounded,
                    iconColor: primaryColor,
                  ),
                  ExpandableInfoCard(
                    title: "Descripcion",
                    value: candleTemplateEntity.description ??
                        "No hay descripción",
                    icon: Icons.description,
                    iconColor: primaryColor,
                  ),
                  ExpandableInfoCard(
                    title: "Comentarios",
                    value:
                        candleTemplateEntity.comments ?? "No hay comentarios",
                    icon: Icons.comment,
                    iconColor: primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Cantidad: ${(() {
                      try {
                        return candleTemplateProvider.candleTemplateEntityList
                            .firstWhere((template) =>
                                template.id == candleTemplateEntity.id)
                            .quantity
                            .toString();
                      } catch (e) {
                        print('holiwis');
                        return "No disponible"; // Mensaje de error o valor por defecto
                      }
                    })()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonWidget(
        candleTemplateEntity: candleTemplateEntity,
      ),
    );
  }

  Widget _buildHeader(Color primaryColor) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage('https://img.pikbest.com/back_our/bg/20191230/bg/1f31c3dd0befc.png!w700wp'),
              fit: BoxFit.cover,
            ),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(30)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black.withOpacity(0.9), primaryColor],
            ),
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          child: Text(
            candleTemplateEntity.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class ExpandableInfoCard extends StatefulWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final double maxHeight;

  const ExpandableInfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.maxHeight = 350, // Altura máxima expandida
  });

  @override
  _ExpandableInfoCardState createState() => _ExpandableInfoCardState();
}

class _ExpandableInfoCardState extends State<ExpandableInfoCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var valueOfIconMargin = 0.0;
    if (widget.iconColor == Color.fromARGB(255, 245, 245, 220) ||
        widget.iconColor == Colors.white ||
        widget.iconColor == Colors.yellow) {
      valueOfIconMargin = 31.0;
    }

    return Card(
      //color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment
                      .center, // Asegura que los iconos se superpongan correctamente
                  children: [
                    // Contorno negro (usamos una sombra para mejor efecto)
                    Text(
                      String.fromCharCode(widget.icon.codePoint),
                      style: TextStyle(
                        fontSize: valueOfIconMargin,
                        fontFamily: widget.icon.fontFamily,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = Colors.black, // Contorno negro
                      ),
                    ),
                    // Icono principal encima
                    Icon(widget.icon, size: 30, color: widget.iconColor),
                  ],
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),
            if (isExpanded) const SizedBox(height: 8),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Text(
                widget.value
                    .split('\n')
                    .first, // Muestra solo la primera línea cuando está colapsado
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              secondChild: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight:
                      widget.maxHeight, // Altura máxima cuando está expandido
                ),
                child: SingleChildScrollView(
                  child: Text(
                    widget.value,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
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

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget(
      {super.key, required this.candleTemplateEntity});

  final CandleTemplateEntity candleTemplateEntity;

  void _confirmDeleteSubmission(BuildContext context) {
    final candleTemplateProvider = CandleTemplateProvider();
    candleTemplateProvider.deleteCandleTemplate(candleTemplateEntity.id);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  void _confirmEditSubmission(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => EditCandleTemplateScreen(
              candleTemplateEntity: candleTemplateEntity)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = ColorNameToColorWidget()
        .getColorFromString(candleTemplateEntity.color.name);

    if (primaryColor == Colors.white) {
      primaryColor = Colors.black;
    }

    return FloatingActionButton(
      backgroundColor: primaryColor,
      child: const Icon(Icons.more_vert, color: Colors.white),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.numbers, color: Colors.deepPurple),
                    title: const Text("Editar Cantidad"),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return EditQuantityAlertDialog(
                              candleTemplateEntity: candleTemplateEntity);
                        },
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.edit, color: Colors.blue),
                    title: const Text("Editar"),
                    onTap: () {
                      Navigator.pop(context);
                      _confirmEditSubmission(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.delete, color: Colors.red),
                    title: const Text("Eliminar"),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmationAlertDialog(
                            message: [
                              const TextSpan(
                                text:
                                    "Estas segura que deseas eliminar esta plantilla?\n\n",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text:
                                      "Nombre: ${candleTemplateEntity.title}"),
                            ],
                            onConfirm: () => _confirmDeleteSubmission(context),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
