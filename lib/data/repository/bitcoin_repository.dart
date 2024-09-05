import 'package:allcast_test_app/data/models/bitcoin_price_model.dart';
import 'package:allcast_test_app/data/services/bitcoin_api_service.dart';


class BitcoinRepository {
  final BitcoinApiService apiService;

  BitcoinRepository(this.apiService);

  Future<BitcoinPrice> fetchBitcoinPrice() async {
    return await apiService.getBitcoinPrice();
  }
}
