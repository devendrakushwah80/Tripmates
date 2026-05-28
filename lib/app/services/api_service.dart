import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// Small reusable service for the PHP + MySQL backend.
///
/// The app runs on a real Android phone, so the API must use the PC LAN IP,
/// never localhost. Change this at run time with:
/// --dart-define=TRIPMATES_API_BASE_URL=http://YOUR_PC_IP/tripmates_backend
class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String baseUrl = String.fromEnvironment(
    'TRIPMATES_API_BASE_URL',
    defaultValue: 'http://192.168.1.34/tripmates_backend',
  );

  static const Duration _timeout = Duration(seconds: 20);

  final http.Client _client;

  Future<ApiResult> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    return _postForm('register.php', {
      'full_name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': 'passenger',
    });
  }

  Future<ApiResult> login({required String email, required String password}) {
    return _postForm('login.php', {'login': email, 'password': password});
  }

  Future<ApiResult> forgotPassword({required String email}) {
    return _postForm('forgot_password.php', {'email': email});
  }

  Future<ApiResult> _postForm(
    String fileName,
    Map<String, String> fields,
  ) async {
    final uri = Uri.parse('$baseUrl/$fileName');

    try {
      // PHP endpoints were tested with Postman form-data, so MultipartRequest
      // matches that request shape exactly.
      final request = http.MultipartRequest('POST', uri)
        ..fields.addAll(fields)
        ..headers['Accept'] = 'application/json';

      final streamed = await _client.send(request).timeout(_timeout);
      final response = await http.Response.fromStream(streamed);
      return _parseResponse(response);
    } on TimeoutException {
      return const ApiResult(
        ok: false,
        message:
            'Request timed out. Please check your connection and try again.',
      );
    } on SocketException {
      return const ApiResult(
        ok: false,
        message: 'Could not reach the server. Check Wi-Fi and PC IP address.',
      );
    } catch (e) {
      return ApiResult(ok: false, message: 'Something went wrong: $e');
    }
  }

  ApiResult _parseResponse(http.Response response) {
    final body = response.body.trim();
    final data = _decodeBody(body);
    final message = _extractMessage(data, body);
    final normalized = message.toLowerCase();

    final successFromJson =
        data['success'] == true ||
        data['status'] == true ||
        '${data['status']}'.toLowerCase() == 'success';

    final successFromText =
        normalized.contains('registration successful') ||
        normalized.contains('login successful') ||
        normalized.contains('successfully registered') ||
        normalized.contains('success');

    final knownError =
        normalized.contains('already exists') ||
        normalized.contains('wrong password') ||
        normalized.contains('user not found') ||
        normalized.contains('server error') ||
        normalized.contains('invalid');

    final ok =
        response.statusCode >= 200 &&
        response.statusCode < 300 &&
        (successFromJson || (successFromText && !knownError));

    final payload = data['data'] is Map
        ? Map<String, dynamic>.from(data['data'] as Map)
        : data;
    final tokens = payload['tokens'] is Map
        ? Map<String, dynamic>.from(payload['tokens'] as Map)
        : const <String, dynamic>{};
    final normalizedPayload = <String, dynamic>{
      ...payload,
      if (tokens['access_token'] != null) 'token': tokens['access_token'],
      if (payload['user'] is Map)
        'user': {
          ...Map<String, dynamic>.from(payload['user'] as Map),
          if ((payload['user'] as Map)['full_name'] != null)
            'name': (payload['user'] as Map)['full_name'],
        },
    };

    return ApiResult(
      ok: ok,
      statusCode: response.statusCode,
      message: _friendlyMessage(message, response.statusCode),
      data: normalizedPayload,
    );
  }

  Map<String, dynamic> _decodeBody(String body) {
    if (body.isEmpty) return const {};
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) return decoded;
      if (decoded is Map) return Map<String, dynamic>.from(decoded);
      return {'message': decoded.toString()};
    } catch (_) {
      return {'message': body};
    }
  }

  String _extractMessage(Map<String, dynamic> data, String fallback) {
    for (final key in ['message', 'msg', 'error', 'status']) {
      final value = data[key];
      if (value != null && '$value'.trim().isNotEmpty) {
        return '$value'.trim();
      }
    }
    return fallback.isEmpty ? 'Server returned an empty response.' : fallback;
  }

  String _friendlyMessage(String message, int statusCode) {
    final lower = message.toLowerCase();
    if (lower.contains('registration successful')) {
      return 'Registration successful';
    }
    if (lower.contains('user already exists') ||
        lower.contains('already exists')) {
      return 'User already exists';
    }
    if (lower.contains('login successful')) return 'Login successful';
    if (lower.contains('wrong password')) return 'Wrong password';
    if (lower.contains('user not found')) return 'User not found';
    if (lower.contains('server error') || statusCode >= 500) {
      return 'Server error';
    }
    return message;
  }
}

class ApiResult {
  const ApiResult({
    required this.ok,
    required this.message,
    this.statusCode,
    this.data = const {},
  });

  final bool ok;
  final String message;
  final int? statusCode;
  final Map<String, dynamic> data;
}
