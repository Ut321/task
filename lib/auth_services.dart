import 'package:http/http.dart' as http;

class AuthService {
  final String loginRequestApi =
      "https://flutter.magadh.co/api/v1/users/login-request";
  final String loginVerifyApi =
      "https://flutter.magadh.co/api/v1/users/login-verify";
  final String verifyTokenApi =
      "https://flutter.magadh.co/api/v1/users/verify-token";

  // Function to request OTP from the API
  Future<String> requestOTP(String phoneNumber) async {
    final httpClient = http.Client();
    final response = await httpClient.post(
      Uri.parse(loginRequestApi),
      body: {'phone_number': phoneNumber},
    );

    if (response.statusCode == 200) {
      // If the OTP request is successful, return the OTP sent to the user
      return response.body;
    } else {
      // Handle the error case
      print("Failed to request OTP. Status Code: ${response.statusCode}");
      return "";
    }
  }

  // Function to verify OTP
  Future<bool> verifyOTP(String phoneNumber, String enteredOTP) async {
    final httpClient = http.Client();
    final response = await httpClient.post(
      Uri.parse(loginVerifyApi),
      body: {'phone_number': phoneNumber, 'otp': enteredOTP},
    );

    if (response.statusCode == 200) {
      // If the OTP verification is successful, return true
      return true;
    } else {
      // Handle the error case
      print("OTP verification failed. Status Code: ${response.statusCode}");
      return false;
    }
  }

  // Function to verify token
  Future<bool> verifyToken(String token) async {
    final httpClient = http.Client();
    final response = await httpClient.post(
      Uri.parse(verifyTokenApi),
      body: {'token': token},
    );

    if (response.statusCode == 200) {
      // If the token verification is successful, return true
      return true;
    } else {
      // Handle the error case
      print("Token verification failed. Status Code: ${response.statusCode}");
      return false;
    }
  }
}
