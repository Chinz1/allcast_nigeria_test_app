import 'package:allcast_test_app/bitcoin_converter_bloc/events.dart';
import 'package:allcast_test_app/bitcoin_converter_bloc/state.dart';
import 'package:allcast_test_app/data/repository/bitcoin_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BitcoinBloc extends Bloc<BitcoinEvent, BitcoinState> {
  final BitcoinRepository repository;

  BitcoinBloc({required this.repository}) : super(BitcoinInitial()) {
    on<FetchBitcoinPrice>((event, emit) async {
      emit(BitcoinLoading());
      try {
        final price = await repository.fetchBitcoinPrice();
        emit(BitcoinLoaded(
          bitcoinPrice: price,
          lastUpdated: DateTime.now(),
        ));
      } catch (e) {
        emit(BitcoinError(e.toString()));
      }
    });

    on<ConvertUsdToBtc>((event, emit) {
      if (state is BitcoinLoaded) {
        final currentState = state as BitcoinLoaded;
        final btcAmount = event.usdAmount / currentState.bitcoinPrice.usd;
        emit(BitcoinLoaded(
          bitcoinPrice: currentState.bitcoinPrice,
          convertedBtc: btcAmount,
          lastUpdated: currentState.lastUpdated, // Keep the same timestamp
        ));
      }
    });
  }
}


