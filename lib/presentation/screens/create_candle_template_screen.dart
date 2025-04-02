import 'package:aurora_candle/domain/entities/candle_template_entity.dart';
import 'package:aurora_candle/presentation/providers/candle_template_provider.dart';
import 'package:aurora_candle/presentation/screens/main_screen.dart';
import 'package:aurora_candle/presentation/widgets/color_selector_circle_widget.dart';
import 'package:aurora_candle/presentation/widgets/confirmation_alert_dialog.dart';
import 'package:aurora_candle/presentation/widgets/normal_text_form_field.dart';
import 'package:aurora_candle/utils/color_name_to_color_widget.dart';
import 'package:flutter/material.dart';

class CreateCandleTemplateScreen extends StatefulWidget {
  const CreateCandleTemplateScreen({super.key});

  @override
  State<CreateCandleTemplateScreen> createState() =>
      _CreateCandleTemplateScreenState();
}

class _CreateCandleTemplateScreenState
    extends State<CreateCandleTemplateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  final TextEditingController _scentController = TextEditingController();

  String selectedColorName = "red"; // Estado para el color seleccionado

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _commentsController.dispose();
    _scentController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final ColorNameToColorWidget colorNameToColorWidget =
        ColorNameToColorWidget();
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          List<TextSpan> text = [
            TextSpan(
                text: '¿Estás segura que deseas\n',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'crear esta plantilla?\n',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextSpan(text: '\n'),
            TextSpan(text: 'Nombre: ${_nameController.text}\n'),
            TextSpan(
                text:
                    'Color: ${colorNameToColorWidget.getSpanishName(selectedColorName)}\n'),
            TextSpan(text: 'Esencia : ${_scentController.text}\n'),
          ];
          return ConfirmationAlertDialog(
              message: text, onConfirm: _confirmSubmission);
        },
      );
    }
  }

  void _confirmSubmission() async {
    final CandleTemplateProvider candleTemplateProvider = CandleTemplateProvider();

    // Agregar una nueva vela
    await candleTemplateProvider.addCandleTemplate(
      CandleTemplateEntity(
        id: "temp", // Firestore generará el ID
        title: _nameController.text,
        color: candleTemplateProvider.getEnumFromString(selectedColorName),
        scent: _scentController.text,
        quantity: 0,
        description: _descriptionController.text,
        comments: _commentsController.text,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Creación de Plantilla',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 111, 93, 159),
          toolbarHeight: 70,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: const Color.fromARGB(255, 200, 162, 206),
              height: 4.0,
            ),
          ),
        ),
        body: Column(
          children: [
            _NameTemplateForm(_nameController),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 40), // Espaciado
                  _ColorAndScentTemplateForm(
                    _scentController,
                    onColorSelected: (color) {
                      setState(() {
                        selectedColorName = color;
                      });
                    },
                  ),
                  const SizedBox(height: 70), // Espaciado
                  // Campos con validación
                  NormalTextFormField(
                    hintText: 'Descripción',
                    controller: _descriptionController,
                    // validator: (value) {
                    //   // this flied can be empty
                    // },
                  ),
                  const SizedBox(height: 40),

                  NormalTextFormField(
                    hintText: 'Comentarios',
                    controller: _commentsController,
                  ),
                  const SizedBox(height: 100),

                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: Icon(Icons.send, color: Colors.white, size: 20),
                    label: Text(
                      'Enviar',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 148, 74, 188), // Color del botón
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Bordes redondeados
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12), // Espaciado
                      elevation: 5, // Sombra
                      shadowColor: Colors.black54,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorAndScentTemplateForm extends StatelessWidget {
  const _ColorAndScentTemplateForm(this.controller,
      {required this.onColorSelected});

  final TextEditingController? controller;
  final Function(String) onColorSelected; // Callback para enviar el color

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 40), //space
        ColorSelectorCircle(
          onColorSelected: onColorSelected,
        ),
        SizedBox(width: 50), //space
        Row(
          // Agrupar imagen y campo de texto juntos
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/5883/5883440.png',
              height: 50,
            ),
            SizedBox(
                width: 2), // Espacio opcional entre imagen y campo de texto
            SizedBox(
              width:
                  120, // Ajusta el ancho del campo de texto según sea necesario
              child: NormalTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Obligatorio';
                  }
                  return null;
                },
                hintText: 'Esencia',
                controller: controller,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NameTemplateForm extends StatelessWidget {
  const _NameTemplateForm(this.controller);

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();

    return Container(
      color: const Color.fromARGB(255, 200, 162, 206),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sección derecha: Imagen
            SizedBox(
              width: 120, // Tamaño fijo para la imagen
              child: Image.network(
                'https://images.vexels.com/media/users/3/135583/isolated/preview/6ab6aa994cceb668b0bf3021097e4463-icono-de-luz-de-vela.png?w=360',
                height: 120,
              ),
            ),
            // Sección izquierda: Campo de texto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Nombre:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Obligatorio';
                      }
                      return null;
                    },
                    controller: controller,
                    focusNode: focusNode,
                    decoration:
                        InputDecoration(hintText: 'Ingrese el nombre...'),
                    onTapOutside: (event) => {focusNode.unfocus()},
                  )
                ],
              ),
            ),
            const SizedBox(width: 20), // Espaciado entre texto e imagen
          ],
        ),
      ),
    );
  }
}
