import 'dart:convert';
import 'package:allcast_test_app/data/models/bitcoin_price_model.dart';
import 'package:http/http.dart' as http;

class BitcoinApiService {
  final String _baseUrl = 'https://api.coingecko.com/api/v3/simple/price';

  Future<BitcoinPrice> getBitcoinPrice() async {
    final response = await http.get(Uri.parse('$_baseUrl?ids=bitcoin&vs_currencies=usd'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return BitcoinPrice.fromJson(data);
    } else {
      throw Exception('Failed to fetch Bitcoin price');
    }
  }
}
