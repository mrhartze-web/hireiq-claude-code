import 'dart:convert';
import 'package:http/http.dart' as http;

class PeachPaymentsService {
  // Base URL — test environment until go-live
  static const String _baseUrl = 'https://testsecure.peachpayments.com';

  // Loaded from Firebase Remote Config in production.
  // Replace with real values after merchant registration.
  static const String _entityId = 'YOUR_ENTITY_ID';
  static const String _accessToken = 'YOUR_ACCESS_TOKEN';

  /// Create a checkout for a subscription payment.
  /// Returns checkoutId and redirectUrl when credentials are present.
  Future<Map<String, dynamic>> createCheckout({
    required String userId,
    required String planId,
    required double amount,
    required String currency,
    required String planName,
    required String userEmail,
  }) async {
    // When live credentials are configured, POST to:
    // POST $_baseUrl/v1/checkouts
    // with headers: Authorization: Bearer $_accessToken
    // and body: entityId, amount, currency, paymentType=DB,
    //           merchantTransactionId, customParameters, etc.
    //
    // For now: return structured placeholder that matches the
    // real Peach Payments checkout response shape.
    if (_entityId == 'YOUR_ENTITY_ID') {
      return {
        'checkoutId': 'checkout_${DateTime.now().millisecondsSinceEpoch}',
        'redirectUrl': '$_baseUrl/v1/checkouts',
        'status': 'pending',
        'amount': amount,
        'currency': currency,
        'planId': planId,
        'userId': userId,
      };
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/v1/checkouts'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'entityId': _entityId,
        'amount': amount.toStringAsFixed(2),
        'currency': currency,
        'paymentType': 'DB',
        'merchantTransactionId': '${userId}_${planId}_${DateTime.now().millisecondsSinceEpoch}',
        'customer.email': userEmail,
        'customParameters[planId]': planId,
        'customParameters[userId]': userId,
        'customParameters[planName]': planName,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Peach Payments checkout failed: ${response.body}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Verify payment status after redirect return.
  Future<Map<String, dynamic>> verifyPayment({
    required String checkoutId,
  }) async {
    if (_entityId == 'YOUR_ENTITY_ID') {
      return {
        'checkoutId': checkoutId,
        'result': {'code': 'pending_credentials', 'description': 'Awaiting credentials'},
        'status': 'pending',
      };
    }

    final uri = Uri.parse('$_baseUrl/v1/checkouts/$checkoutId/payment')
        .replace(queryParameters: {'entityId': _entityId});

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    if (response.statusCode != 200) {
      throw Exception('Peach Payments verify failed: ${response.body}');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Parse Peach Payments result codes.
  /// Codes starting with '000' are successful transactions.
  static bool isSuccessCode(String resultCode) {
    return resultCode.startsWith('000');
  }
}
