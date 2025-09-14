
class ProductModel {
  final int id;
  final String title;
  final String description;
  final num price;
  final num rating;
  final List<dynamic> images;
  final String category;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
    required this.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as num,
      rating: json['rating'] ?? 0,
      images: json['images'] ?? (json['thumbnail'] != null ? [json['thumbnail']] : []),
      category: json['category'] ?? 'general',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'rating': rating,
        'images': images,
        'category': category,
      };
}