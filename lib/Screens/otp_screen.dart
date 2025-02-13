import 'dart:async';
import 'package:flutter/material.dart';
import '../services/api_services.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  OtpScreen({required this.phoneNumber});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  Timer? _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _start = 30;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  // Validate OTP
  void validateOtp() async {
    try {
      // Concatenate OTP from all controllers
      String otp = _otpControllers.map((controller) => controller.text).join();

      // Check if OTP is valid
      if (otp.length == 4 && int.tryParse(otp) != null) {
        final mobileNumber = int.parse(widget.phoneNumber.toString());
        final otpInt = int.parse(otp); // OTP is now an integer
        final response =
            await ApiService().validateOtp(91, mobileNumber, otpInt);

        if (response['status'] == 'SUCCESS') {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          // Show error if OTP validation fails
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Invalid OTP. Please try again."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // If OTP length is not 4 or it's not a valid number, show error
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Please enter a valid 4-digit OTP."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error validating OTP: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/oru-login.png',
              height: 80,
            ),
            SizedBox(height: 50),
            Text(
              'Verify Mobile No.',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(63, 62, 143, 1)),
            ),
            SizedBox(height: 30),
            Text(
              'Please enter the 4 digit verification code sent to your mobile number +91-${widget.phoneNumber} via SMS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _otpControllers[index],
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 60),
            Text('Didn’t receive OTP?'),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: _start == 0 ? startTimer : null,
              child: Text(
                  _start == 0
                      ? 'Resend OTP'
                      : 'Resend OTP in 0:${_start.toString().padLeft(2, '0')} Sec',
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                  )),
            ),
            SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(63, 62, 143, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: validateOtp,
                child: Text('Verify OTP',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
