class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int stock;
  final String type;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.stock,
    required this.type,
    required this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'] ?? '',
      stock: json['stock'] ?? 0,
      type: json['type'] ?? 'Mango',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'stock': stock,
      'type': type,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
  
  // Computed property to determine if product is in stock
  bool get inStock => stock > 0;
  
  // Computed property for estimated pickup date range
  String get estimatedPickupDateRange {
    // Generate a date range of 3-5 days from now
    final now = DateTime.now();
    final start = now.add(const Duration(days: 3));
    final end = now.add(const Duration(days: 5));
    
    // Format dates as strings
    final startStr = '${start.day}/${start.month}/${start.year}';
    final endStr = '${end.day}/${end.month}/${end.year}';
    
    return '$startStr - $endStr';
  }
}
