import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://40.90.224.241:5000/';

  // Function to send OTP
  Future<Map<String, dynamic>> sendOtp(
      int countryCode, int mobileNumber) async {
    final url = Uri.parse('http://40.90.224.241:5000/login/otpCreate');

    try {
      print('Sending OTP Request to: $url');
      print(
          'Request Body: { "countryCode": $countryCode, "mobileNumber": $mobileNumber }');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'countryCode': countryCode,
          'mobileNumber': mobileNumber,
        }),
      );

      // Log the response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        return responseData;
      } else {
        print('Failed to send OTP. Status Code: ${response.statusCode}');
        throw Exception(
            'Failed to send OTP. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in sendOtp: $e');
      rethrow;
    }
  }

  // Function to validate OTP
  Future<Map<String, dynamic>> validateOtp(
      int countryCode, int mobileNumber, int otp) async {
    final url = Uri.parse('http://40.90.224.241:5000/login/otpValidate');

    try {
      print('Sending OTP Validation Request to: $url');
      print(
          'Request Body: { "countryCode": $countryCode, "mobileNumber": $mobileNumber, "otp": $otp }');

      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'countryCode': countryCode,
              'mobileNumber': mobileNumber,
              'otp': otp,
            }),
          )
          .timeout(
              Duration(seconds: 15)); // Increase timeout duration if needed

      // Log the response status and body
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData; // Return the response body as a Map
      } else {
        print('Failed to validate OTP. Status Code: ${response.statusCode}');
        throw Exception(
            'Failed to validate OTP. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in validateOtp: $e');
      rethrow;
    }
  }

  // // Function to log out
  // Future<void> logout(String csrfToken) async {
  //   final url = Uri.parse('$baseUrl/logout');
  //   final response = await http.get(
  //     url,
  //     headers: {'X-Csrf-Token': csrfToken},
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to log out');
  //   }
  // }
  //
  // // Function to update user details
  // Future<Map<String, dynamic>> updateUser(
  //     String csrfToken, int countryCode, String userName) async {
  //   final url = Uri.parse('$baseUrl/update');
  //   final response = await http.post(
  //     url,
  //     headers: {'X-Csrf-Token': csrfToken, 'Content-Type': 'application/json'},
  //     body: jsonEncode({'countryCode': countryCode, 'userName': userName}),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to update user');
  //   }
  // }

  // Function to like a product
  Future<Map<String, dynamic>> likeProduct(
      String csrfToken, String listingId, bool isFav) async {
    final url = Uri.parse('$baseUrl/favs');
    final response = await http.post(
      url,
      headers: {'X-Csrf-Token': csrfToken, 'Content-Type': 'application/json'},
      body: jsonEncode({'listingId': listingId, 'isFav': isFav}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to like product');
    }
  }

  // Function to check if the user is logged in
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

  // Function to log out the user
  Future<bool> logout(String csrfToken) async {
    final response = await http.get(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'X-Csrf-Token': csrfToken,
      },
    );

    if (response.statusCode == 200) {
      // Clear stored tokens or session data if necessary
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('csrfToken');
      prefs.remove('userData');
      return true;
    } else {
      throw Exception('Failed to log out');
    }
  }

  // Function to update the user profile (username)
  Future<bool> updateUser(
      String csrfToken, String countryCode, String userName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/update'),
      headers: {
        'X-Csrf-Token': csrfToken,
      },
      body: json.encode({
        'countryCode': countryCode,
        'userName': userName,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update user');
    }
  }
}
