import 'dart:convert';
import 'dart:math';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:rapyd_collect_api/core/models/base_response.dart';
import 'package:rapyd_collect_api/core/models/plan.dart';
import 'package:rapyd_collect_api/core/utils/rapyd_client_api.dart';
import 'package:http/http.dart' as http;

class RapydClientApiImpl extends RapydClientApi {
  final _baseURL = 'https://sandboxapi.rapyd.net/v1';
  final _accessKey = 'rak_928E5143F245FA46ED59';
  final _secretKey =
      'rsk_8bba9ad45129cf492993e9b7ed95f91c293e974503e29da9dcafe846532ec239bdab74b24216d3f0';
  String _generateSalt() {
    final _random = Random.secure();
    // Generate 16 characters for salt by //generating 16 random bytes
    // and encoding it.
    final randomBytes = List<int>.generate(16, (index) => _random.nextInt(256));
    return base64UrlEncode(randomBytes);
  }

  Map<String, String> _generateHeader({
    required String method,
    required String endpoint,
    String body = '',
  }) {
    int unixTimetamp = DateTime.now().millisecondsSinceEpoch;
    String timestamp = (unixTimetamp / 1000).round().toString();

    var salt = _generateSalt();

    var toSign =
        '$method/v1$endpoint$salt$timestamp$_accessKey$_secretKey$body';

    print(toSign);

    var keyEncoded = ascii.encode(_secretKey);
    var toSignEncoded = ascii.encode(toSign);

    var hmacSha256 = Hmac(sha256, keyEncoded); // HMAC-SHA256
    var digest = hmacSha256.convert(toSignEncoded);
    var ss = hex.encode(digest.bytes);
    var tt = ss.codeUnits;
    var signature = base64.encode(tt);

    var headers = {
      'Content-Type': 'application/json',
      'access_key': _accessKey,
      'salt': salt,
      'timestamp': timestamp,
      'signature': signature,
    };

    return headers;
  }

  @override
  Future<Map> checkout(String price) async {
    final checkoutBody = <String, String>{
      "amount": price,
      "currency": "USD",
      "country": "US",
      "complete_checkout_url": "https://example.com/thankyou",
      "cancel_checkout_url": "https://example.com/error"
    };
    var method = "post";
    var rapydEndpoint = '/checkout';

    final walletURL = Uri.parse(_baseURL + rapydEndpoint);

    final headers = _generateHeader(
      method: method,
      endpoint: rapydEndpoint,
      body: jsonEncode(checkoutBody),
    );

    try {
      var response = await http.post(walletURL,
          headers: headers, body: jsonEncode(checkoutBody));

      print(response.body);

      final baseResponse = BaseResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        print('checkout done successfully!');
        return baseResponse.data;
      } else {
        throw Exception(response.body);
      }
    } catch (_) {
      print(_);
      print('Failed to subscribe');
    }
    throw Exception('Failed to checkout');
  }

  @override
  Future<List<Plan>> getPlans() async {
    List<Plan> retrievedPlans = [];

    var method = "get";
    var rapydEndpoint = '/plans';

    final walletURL = Uri.parse(_baseURL + rapydEndpoint);

    final headers = _generateHeader(
      method: method,
      endpoint: rapydEndpoint,
    );

    print(walletURL);

    try {
      var response = await http.get(walletURL, headers: headers);

      print(response.body);

      if (response.statusCode == 200) {
        print('plans retrieved successfully!');

        final baseResponse = BaseResponse.fromJson(jsonDecode(response.body));

        for (var plan in baseResponse.data) {
          retrievedPlans.add(Plan.fromJson(plan));
        }
        return retrievedPlans;
      } else {
        throw Exception(response.body);
      }
    } catch (_) {
      print(_);
      print('Failed to retrieve plan list');
    }
    throw Exception('Failed to get plans ');
  }

  @override
  Future<Plan> getPlanDetails(String planId) async {
    Plan? retrievedPlanDetails;

    var method = "get";
    var rapydEndpoint = '/plans/$planId';

    final walletURL = Uri.parse(_baseURL + rapydEndpoint);

    final headers = _generateHeader(
      method: method,
      endpoint: rapydEndpoint,
    );

    try {
      var response = await http.get(walletURL, headers: headers);

      if (response.statusCode == 200) {
        print('plans retrieved successfully!');

        final baseResponse = BaseResponse.fromJson(jsonDecode(response.body));

        retrievedPlanDetails = Plan.fromJson(baseResponse.data);

        return retrievedPlanDetails!;
      } else {
        throw Exception(response.body);
      }
    } catch (_) {
      print('Failed to retrieve plan');
    }

    throw Exception('Unable to get data');
  }

  @override
  Future<Map> subscribeToPlan(String planId) async {
    Map subscribeBody = {
      "customer": "cus_157f87d8508724c7e8fd4a5abe28cc34",
      "merchant_reference_id": "acct_111197",
      "country": "us",
      "language": "US",
      "billing": "pay_automatically",
      "cancel_at_period_end": true,
      "coupon": "",
      "payment_fees": {
        "fx_fee": {"calc_type": "net", "fee_type": "percentage", "value": 0}
      },
      "payment_method_": "ewallet",
      "subscription_items": [
        {"plan": planId, "quantity": 1}
      ],
      "metadata": {"merchant_defined": true},
      "tax_percent": 0,
      "complete_payment_url": "https://example.com/thankyou",
      "error_payment_url": "https://example.com/error",
      "cancel_url": "https://example.com/error",
      "complete_url": "https://example.com/thankyou",
      "page_expiration": 1699470811,
      "trial_from_plan": false,
      "trial_period_days": null
    };

    var method = "post";
    var rapydEndpoint = '/checkout/subscription';

    final walletURL = Uri.parse(_baseURL + rapydEndpoint);

    print('wallet url $walletURL');

    final headers = _generateHeader(
      method: method,
      endpoint: rapydEndpoint,
      body: jsonEncode(subscribeBody),
    );

    try {
      var response = await http.post(walletURL,
          headers: headers, body: jsonEncode(subscribeBody));

      print(response.body);

      final baseResponse = BaseResponse.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        print('subscribed successfully!');
        return baseResponse.data;
      } else {
        throw Exception(response.body);
      }
    } catch (_) {
      print(_);
      print('Failed to subscribe');
    }
    throw Exception('Failed to subscribe');
  }
}
