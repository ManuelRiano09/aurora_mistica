import 'package:flutter/material.dart';

class ColorOption extends StatelessWidget {
  final Color color;
  final VoidCallback onSelect;

  const ColorOption({
    super.key,
    required this.color,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(2, 2),
                )
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
