import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/products.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse(_baseUrl);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;

      final List<dynamic> productsJson = data['products'] as List<dynamic>;

      return productsJson
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception('Failed to load products. Status: ${response.statusCode}');
  }
}
