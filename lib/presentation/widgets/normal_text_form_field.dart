import 'package:flutter/material.dart';

class NormalTextFormField extends StatelessWidget {
  const NormalTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
  });

  final String hintText;
  final TextEditingController? controller; // Controlador opcional
  final String? Function(String?)? validator; // Validador opcional

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      focusNode: focusNode,
      onTapOutside: (event) => {focusNode.unfocus()},
      controller: controller, // Usar el controlador si se proporciona
      validator: validator, // Usar el validador si se proporciona
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: 10,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      ),
    );
  }
}
