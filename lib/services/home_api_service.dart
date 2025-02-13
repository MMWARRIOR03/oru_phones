import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/faq_model.dart';
import '../model/fetch_brand_model.dart';
import '../model/fetch_prod_model.dart';

class HomeApiService {
  static const String baseUrl = 'http://40.90.224.241:5000';

  //is logged in?
  Future<Map<String, dynamic>> isLoggedIn() async {
    final response = await http.get(
      Uri.parse('$baseUrl/isLoggedIn'),
    );

    if (response.statusCode == 200) {
      // Assuming the response contains user data and tokens
      print('User data: ${response.body}');
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check login status');
    }
  }

  // Fetch FAQs
  Future<List<FAQ>> fetchFAQs() async {
    final response = await http.get(Uri.parse('http://40.90.224.241:5000/faq'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((faq) => FAQ.fromJson(faq)).toList();
    } else {
      throw Exception('Failed to load FAQs');
    }
  }

  // Fetch Brands
  Future<List<Brand>> fetchBrands() async {
    final response =
        await http.get(Uri.parse('http://40.90.224.241:5000/makeWithImages'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((brand) => Brand.fromJson(brand)).toList();
    } else {
      throw Exception('Failed to load brands');
    }
  }

  // Fetch Filters
  Future<Map<String, dynamic>> fetchFilters() async {
    final response = await http.get(Uri.parse('$baseUrl/showSearchFilters'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load filters');
    }
  }

  // Fetch Products (with filters)
  Future<List<Product>> fetchFilteredProducts(
      Map<String, dynamic> filter) async {
    final response = await http.post(
      Uri.parse('http://40.90.224.241:5000/filter'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({"filter": filter}),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Like Product (set isFav to true)
  Future<void> likeProduct(String userId, String listingId, bool isFav) async {
    final response = await http.post(
      Uri.parse('http://40.90.224.241:5000/favs'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': userId,
        'listingId': listingId,
        'isFav': isFav,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update favorites');
    }
  }
}
