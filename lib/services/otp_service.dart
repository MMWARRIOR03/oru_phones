import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

// OTP create function
Future<void> createOtp(String mobileNumber, String countryCode) async {
  final url = Uri.parse('http://40.90.224.241:5000/login/otpCreate');

  try {
    final response = await http.post(
      url,
      body: jsonEncode({
        'countryCode': countryCode,
        'mobileNumber': mobileNumber,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // OTP creation was successful
      Fluttertoast.showToast(msg: "OTP sent successfully.");
    } else {
      // Handle API error
      Fluttertoast.showToast(msg: "Error: ${response.body}");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Error: $e");
  }
}

// OTP validate function
Future<void> validateOtp(
    String mobileNumber, String countryCode, String otp) async {
  final url = Uri.parse('http://40.90.224.241:5000/login/otpValidate');

  try {
    final response = await http.post(
      url,
      body: jsonEncode({
        'countryCode': countryCode,
        'mobileNumber': mobileNumber,
        'otp': otp,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // OTP validation was successful
      Fluttertoast.showToast(msg: "OTP validated successfully.");
    } else {
      // Handle API error
      Fluttertoast.showToast(msg: "Invalid OTP.");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Error: $e");
  }
}
