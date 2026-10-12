class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String creationAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    String parsedImage = json['image']?.toString().trim() ?? '';
    if (parsedImage.startsWith('["') && parsedImage.endsWith('"]')) {
      parsedImage = parsedImage.substring(2, parsedImage.length - 2);
    } else if (parsedImage.startsWith('[') && parsedImage.endsWith(']')) {
      parsedImage = parsedImage
          .substring(1, parsedImage.length - 1)
          .replaceAll('"', '')
          .replaceAll("'", "");
    }
    parsedImage = parsedImage.replaceAll('"', '').replaceAll("'", "").trim();

    return CategoryModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      image: parsedImage,
      creationAt: json['creationAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }
}
