import 'dart:ui';

class Subscriptions {
  String id;
  String colorCode;
  String description;
  String name;
  String price;
  List<String> features;
  Subscriptions({
    required this.id,
    required this.colorCode,
    required this.description,
    required this.name,
    required this.price,
    required this.features,
  });

  factory Subscriptions.fromMap(Map<String, dynamic> map) {
    return Subscriptions(
        id: map['id'] ?? '',
        colorCode: map['color_code'] ?? '',
        description: map['description'] ?? '',
        name: map['name'] ?? '',
        price: map['price'] ?? '',
        features:
            List<String>.from((map['features'] as String).split('\u{000A}')));
  }

  @override
  String toString() {
    return 'Subscriptions(id: $id, colorCode: $colorCode, description: $description, name: $name, price: $price, features: $features)';
  }

  Color bgColor() => Color(int.parse(colorCode, radix: 16) + 0xFF000000);
  String imagePathKey() => name.split(' ').first.toLowerCase();
}
