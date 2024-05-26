import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductsService {
  static const String _baseUrl = 'https://ecommerce.routemisr.com/api/v1/products?page=';

  static Future<Map<String, dynamic>> fetchProducts(int page) async {
    final response = await http.get(Uri.parse('$_baseUrl$page'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<Product> products = (jsonResponse['data'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();

      return {
        'products': products,
        'currentPage': jsonResponse['metadata']['currentPage'],
        'numberOfPages': jsonResponse['metadata']['numberOfPages'],
      };
    } else {
      throw Exception('Failed to load products');
    }
  }
}
