// PEACH PAYMENTS CONFIGURATION
//
// To activate live payments:
// 1. Register at peachpayments.com
// 2. Complete merchant verification
// 3. Obtain Entity ID and Access Token
// 4. Add to Firebase Remote Config:
//    - peach_entity_id
//    - peach_access_token
//    - peach_environment (test or live)
// 5. Update PeachPaymentsService to read from Remote Config
//
// Test credentials available immediately after registration.
// Live credentials require merchant approval (2–5 business days).
//
// Peach Payments supports:
// Visa, Mastercard, Amex, EFT, SnapScan, Ozow
//
// Webhook URL for payment notifications:
// https://us-central1-YOUR-PROJECT.cloudfunctions.net/peachWebhook
// Register this URL in your Peach Payments merchant dashboard.

class PaymentConfig {
  static const String environment = 'test'; // change to 'live' at go-live
  static const String currency = 'ZAR';
  static const String supportEmail = 'hello@hireiq.co.za';
  static const String peachDashboard = 'https://peachpayments.com';
  static const String testBaseUrl = 'https://testsecure.peachpayments.com';
  static const String liveBaseUrl = 'https://secure.peachpayments.com';

  static String get baseUrl =>
      environment == 'live' ? liveBaseUrl : testBaseUrl;
}
