import 'package:flutter/material.dart';

import 'auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController tokenController = TextEditingController();

  String otpSent = "";
  bool isOTPVerified = false;
  bool isTokenVerified = false;

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OTP Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Request OTP when the button is pressed
                  String otp =
                      await authService.requestOTP(phoneController.text);
                  setState(() {
                    otpSent = otp;
                    isOTPVerified = false;
                    isTokenVerified = false;
                  });
                },
                child: const Text("Request OTP"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "OTP",
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Verify OTP when the button is pressed
                  bool isVerified = await authService.verifyOTP(
                      phoneController.text, otpController.text);
                  setState(() {
                    isOTPVerified = isVerified;
                    isTokenVerified = false;
                  });

                  if (isVerified) {
                    // Navigate to the next screen or perform necessary actions
                    print("OTP verified!");
                  } else {
                    // Handle invalid OTP case
                    print("Invalid OTP. Please try again.");
                  }
                },
                child: const Text("Verify OTP"),
              ),
              const SizedBox(height: 20),
              if (isOTPVerified)
                Column(
                  children: [
                    TextField(
                      controller: tokenController,
                      decoration: const InputDecoration(
                        labelText: "Token",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Verify Token when the button is pressed
                        bool isTokenValid =
                            await authService.verifyToken(tokenController.text);
                        setState(() {
                          isTokenVerified = isTokenValid;
                        });

                        if (isTokenValid) {
                          // Navigate to the next screen or perform necessary actions
                          print("Token verified! Login successful!");
                        } else {
                          // Handle invalid Token case
                          print("Invalid Token. Please try again.");
                        }
                      },
                      child: const Text("Verify Token"),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              if (isTokenVerified)
                const Text(
                  "Token Verified!",
                  style: TextStyle(color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
