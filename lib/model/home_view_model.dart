import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../services/home_api_service.dart';

class HomeViewModel extends BaseViewModel {
  final HomeApiService _apiService = HomeApiService();
  bool _isLoggedIn = false;
  String? _userName;

  bool get isLoggedIn => _isLoggedIn;
  String? get userName => _userName;

  final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>(); //scaffoldKey => null

  // Function to check if the user is logged in
  Future<void> checkLoginStatus() async {
    setBusy(true);
    try {
      var userData = await _apiService.isLoggedIn();
      _isLoggedIn = true;
      _userName = userData['userName'];
    } catch (e) {
      _isLoggedIn = false;
      _userName = null;
    }
    setBusy(false);
    notifyListeners();
  }

  List<String> faqs = [];
  List<Map<String, dynamic>> brands = [];
  Map<String, dynamic> filters = {};
  List<Map<String, dynamic>> products = [];
  String errorMessage = '';
  bool isLoading = false;

  // Method to fetch all data
  Future<void> fetchHomeData() async {
    setBusy(true);

    try {
      // Fetch FAQs
      faqs = (await _apiService.fetchFAQs()).cast<String>();
      // Fetch Brands
      brands = (await _apiService.fetchBrands()).cast<Map<String, dynamic>>();
      // Fetch Filters
      filters = await _apiService.fetchFilters();
      // Fetch Products
      products = (await _apiService.fetchFilteredProducts({
        "filter": {
          "condition": ["Like New", "Fair"],
          "make": ["Samsung"],
          "storage": ["16 GB", "32 GB"],
          "ram": ["4 GB"],
          "warranty": ["Brand Warranty", "Seller Warranty"],
          "priceRange": [40000, 175000],
          "verified": true,
          "sort": {"price": -1}, // Example: Sort by Price High to Low
          "page": 1
        }
      }))
          .cast<Map<String, dynamic>>();
      setBusy(false);
    } catch (e) {
      errorMessage = e.toString();
      setBusy(false);
      notifyListeners();
    }
  }

  // Method to like a product
  // Future<void> likeProduct(String listingId, String csrfToken) async {
  //   try {
  //     await _apiService.likeProduct(listingId, csrfToken);
  //   } catch (e) {
  //     errorMessage = e.toString();
  //     notifyListeners();
  //   }
  // }
}
