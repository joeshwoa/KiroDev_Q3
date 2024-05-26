class Product {
  final int sold;
  final List<String> images;
  final String subcategory;
  final int ratingsQuantity;
  final String title;
  final String description;
  final int price;
  final int quantity;
  final String imageCover;
  final String category;
  final String categoryImage;
  final String brand;
  final String brandImage;
  final double ratingsAverage;

  Product({
    required this.sold,
    required this.images,
    required this.subcategory,
    required this.ratingsQuantity,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageCover,
    required this.category,
    required this.categoryImage,
    required this.brand,
    required this.brandImage,
    required this.ratingsAverage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sold: json['sold'],
      images: List<String>.from(json['images']),
      subcategory: json['subcategory'][0]['name'], // edit: add this [0] because i not see that the subcategory is array
      ratingsQuantity: json['ratingsQuantity'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      imageCover: json['imageCover'],
      category: json['category']['name'],
      categoryImage: json['category']['image'],
      brand: json['brand']['name'],
      brandImage: json['brand']['image'],
      ratingsAverage: json['ratingsAverage'].toDouble(),
    );
  }
}
