enum CandleTemplateColors {
  red,
  blue,
  green,
  yellow,
  black,
  white,
  gray,
  orange,
  pink,
  purple,
  brown,
  lightBlue,
  violet,
  beige,
  turquoise,
  gold,
  silver
}

class CandleTemplateEntity {
  final String id; // Firestore usa ID como String
  final String title;
  final CandleTemplateColors color;
  final String scent;
  final int quantity;
  final String? description;
  final String? comments;

  CandleTemplateEntity({
    required this.id,
    required this.title,
    required this.color,
    required this.scent,
    required this.quantity,
    this.description,
    this.comments,
  });

  // Convertir a JSON para Firestore
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'color': color.name, // Convertir Enum a String
      'scent': scent,
      'quantity': quantity,
      'description': description,
      'comments': comments,
    };
  }

  // Crear entidad desde Firestore
  factory CandleTemplateEntity.fromJson(String id, Map<String, dynamic> json) {
    return CandleTemplateEntity(
      id: id,
      title: json['title'],
      color: CandleTemplateColors.values.firstWhere(
          (e) => e.name == json['color'],
          orElse: () => CandleTemplateColors.white), // Default en caso de error
      scent: json['scent'],
      quantity: json['quantity'],
      description: json['description'],
      comments: json['comments'],
    );
  }
}
