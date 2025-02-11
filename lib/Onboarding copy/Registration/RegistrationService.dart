import 'dart:convert';
import 'package:http/http.dart' as http;

/// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

/// Service class for handling user registration
class RegistrationService {
  static const String baseUrl = 'http://royal_oven.katysoft.tech/api/v1';

  /// Registers a new user with the provided details
  ///
  /// Throws an [ApiException] if the registration fails or if there is a network error.
  ///
  /// Parameters:
  /// - [firstName]: The first name of the user
  /// - [lastName]: The last name of the user
  /// - [username]: The username of the user
  /// - [email]: The email address of the user
  /// - [phoneNo]: The phone number of the user
  /// - [gender]: The gender of the user
  /// - [plusCodeAddress]: The plus code address of the user
  /// - [password]: The password for the user's account
  ///
  /// Returns a [Map<String, dynamic>] containing the success status and response data.
  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String phoneNo,
    required String gender,
    required String plusCodeAddress,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'first_name': firstName,
              'last_name': lastName,
              'username': username,
              'email': email,
              'phone_no': phoneNo,
              'gender': gender.toLowerCase(),
              'plus_code_address': plusCodeAddress,
              'password': password,
            }),
          )
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw ApiException(
                'Connection timeout. Please check your internet connection.'),
          );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': responseData};
      } else {
        String errorMessage = 'Registration failed';
        if (responseData is Map) {
          errorMessage = responseData['message'] ??
              responseData['error'] ??
              'Registration failed with status: ${response.statusCode}';
        }
        throw ApiException(errorMessage, response.statusCode);
      }
    } on http.ClientException {
      throw ApiException(
          'Network error. Please check your internet connection.');
    } on FormatException {
      throw ApiException('Invalid response format from server.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('An unexpected error occurred: $e');
    }
  }
}
