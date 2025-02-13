import 'package:flutter/material.dart';

import '../services/api_services.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  var _mobNoController = TextEditingController();
  void sendOtp() async {
    print('send otp pressed');
    if (_mobNoController.text.isEmpty) {
      print('Please enter a mobile number');
      return;
    }

    final mobileNumber = int.tryParse(_mobNoController.text);
    if (mobileNumber == null) {
      print('Invalid mobile number');
      return;
    }

    try {
      final response = await ApiService().sendOtp(91, mobileNumber);
      if (response['status'] == 'success') {
        setState(() {
          var isOtpSent = true;
        });
      } else {
        print('Failed to send OTP: ${response['message']}');
      }
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/oru-login.png', // Add your logo here
                    height: 80,
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Welcome',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(63, 62, 143, 1)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromRGBO(112, 112, 112, 1)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
            Text(
              'Enter Your Phone Number',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            TextField(
              controller: _mobNoController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixText: '+91 ',
                hintText: 'Mobile Number',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  activeColor: Color.fromRGBO(63, 62, 143, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Accept ',
                      style: TextStyle(fontSize: 14),
                      children: [
                        TextSpan(
                          text: 'Terms and condition',
                          style: TextStyle(
                              color: Color.fromRGBO(63, 62, 143, 1),
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: Color.fromRGBO(63, 62, 143, 1),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _isChecked
                    ? () {
                        sendOtp();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                    phoneNumber: _mobNoController.text,
                                  )),
                        );
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !_isChecked
                        ? Text('Next ', style: TextStyle(fontSize: 16))
                        : Text('Next ',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
