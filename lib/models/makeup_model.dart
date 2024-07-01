class Makeup {
  final int id;
  final String brand;
  final String name;
  final String imageLink;
  final String description;

  Makeup({
    required this.id,
    required this.brand,
    required this.name,
    required this.imageLink,
    required this.description,
  });

  factory Makeup.fromJson(Map<String, dynamic> json) {
    return Makeup(
      id: json['id'],
      brand: json['brand'] ?? 'Unknown',
      name: json['name'] ?? 'No Name',
      imageLink: json['image_link'] ?? '',
      description: json['description'] ?? 'No Description',
    );
  }
}
