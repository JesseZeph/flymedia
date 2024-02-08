import 'dart:ui';

class Subscriptions {
  String id;
  String colorCode;
  String description;
  String name;
  int maxCampaigns;
  int maxApplicants;
  String price;
  List<String> features;
  Subscriptions({
    required this.id,
    required this.colorCode,
    required this.description,
    required this.name,
    required this.maxApplicants,
    required this.maxCampaigns,
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
        maxApplicants: map['applicants_number'] ?? 0,
        maxCampaigns: map['campaigns_number'] ?? 0,
        features:
            List<String>.from((map['features'] as String).split('\u{000A}')));
  }

  @override
  String toString() {
    return 'Subscriptions(id: $id, colorCode: $colorCode, description: $description, name: $name, price: $price, features: $features, maxApplicants: $maxApplicants, maxCampaigns: $maxCampaigns)';
  }

  Color bgColor() => Color(int.parse(colorCode, radix: 16) + 0xFF000000);
  String imagePathKey() => name.split(' ').first.toLowerCase();
}
