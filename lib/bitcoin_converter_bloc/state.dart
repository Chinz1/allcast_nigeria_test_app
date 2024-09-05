import 'package:allcast_test_app/data/models/bitcoin_price_model.dart';
import 'package:equatable/equatable.dart';


// States
abstract class BitcoinState extends Equatable {
  @override
  List<Object> get props => [];
}

class BitcoinInitial extends BitcoinState {}

class BitcoinLoading extends BitcoinState {}

class BitcoinLoaded extends BitcoinState {
  final BitcoinPrice bitcoinPrice;
  final double convertedBtc;
  final DateTime lastUpdated;

  BitcoinLoaded({
    required this.bitcoinPrice,
    this.convertedBtc = 0.0,
    required this.lastUpdated,
  });

  @override
  List<Object> get props => [bitcoinPrice, convertedBtc, lastUpdated];
}

class BitcoinError extends BitcoinState {
  final String message;
  BitcoinError(this.message);

  @override
  List<Object> get props => [message];
}
